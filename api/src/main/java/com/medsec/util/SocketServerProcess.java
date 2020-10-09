package com.medsec.util;

import com.medsec.entity.Appointment;
import com.medsec.entity.User;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.*;
import java.net.Socket;
import java.time.*;
import java.util.ArrayList;
import java.util.HashMap;
@Deprecated
public class SocketServerProcess implements Runnable {

    private Socket connectedSocket;
    private static boolean flag = false;
    private static final Logger LOG = LogManager.getLogger();

    public SocketServerProcess(Socket s){
        try {
            this.connectedSocket = s;
            LOG.info("GenieScript client connected");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void run() {
        try {
            String msg;
            InputStream in = connectedSocket.getInputStream();
            DataInputStream dataInputStream = new DataInputStream(in);
//            BufferedReader reader = new BufferedReader(new InputStreamReader(connectedSocket.getInputStream()));
            while(!flag && (msg = dataInputStream.readUTF()) != null) {
//                String data = SymmetricEncrypt.getInstance().decrypt(msg);
                flag = processData(msg);
            }
            connectedSocket.close();
            LOG.info("Client disconnected, data transfer complete");
        } catch (EOFException e) {
            LOG.info("Client disconnected, data transfer complete");
        } catch (IOException e) {
            LOG.error("socket is closed by IO exception ");
        }
    }


    /** receive the data and do relevant data process */
    private boolean processData(String data){
        JSONObject jsonObj = parse(data);
        GScommands command = GScommands.valueOf((String) jsonObj.get("command"));

        switch (command){
            case AUTHENTICATION:
                System.out.println(jsonObj.get("secret"));
                return false;
            case APPOINTMENT:
                System.out.println(jsonObj.get("doc"));
                return apptHandler((JSONObject) jsonObj.get("doc"));
            case PATIENT:
                System.out.println(jsonObj.get("doc"));
                return userHandler((JSONObject) jsonObj.get("doc"));
            case FILE:
                System.out.println(jsonObj.get("doc"));
                return fileHandler((JSONObject) jsonObj.get("doc"));
            case DISCONNECTION:
                System.out.println("disconnected");
                return false;
        }
        return true;
    }

    /** parse string to json object */
    private JSONObject parse(String jsonString) {
        try {
            JSONObject jsonObj = (JSONObject) new JSONParser().parse(jsonString);
            return jsonObj;
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }

    /** process user data, insert new user or update existed user */
    private boolean userHandler(JSONObject user){
        Database db = new Database();
        String id = (String) user.get("Id");
        if (!isPatientExist(id)) {
            LOG.info("insert new patient");
            User patient = processUser(user);
            db.insertUser(patient);
        } else {
            LOG.info("update existed patient");
            User patient = processUser(user);
            db.updateUser(patient);
        }
        return false;
    }

    /** process appointment data, insert new appointment or update existed appointment */
    private boolean apptHandler(JSONObject appt){
        Database db = new Database();
        String id = (String) appt.get("Id");
        if (!isApptExist(id)) {
            LOG.info("insert new appointment");
            Appointment apptointment = processAppt(appt);
            db.insertAppointment(apptointment);
            try {
                PushNotification pn = new PushNotification();
                HashMap<String, String> pnResult = pn.sendNotification(apptointment);
                LOG.info("Push notification for new appointment");
                for (String token: pnResult.keySet()) {
                    LOG.info("FCMToken: " + token + " Push Notification Request:" + pnResult.get(token));
                }
            } catch (IOException e) {
                LOG.error("Push notification error");
            }
        } else {
            LOG.info("update exist appointment");
            Appointment apptointment = processAppt(appt);
            db.updateAppointment(apptointment);
        }
        return false;
    }


    /** create User instance from json object */
    private User processUser(JSONObject user){
        String id = (String) user.get("Id");
        String surname = (String) user.get("Surname");
        String firstName = (String) user.get("FirstName");
        String email = (String) user.get("EmailAddress");
        String street = (String) user.get("AddressLine1");
        String suburb = (String) user.get("Suburb");
        String state = (String) user.get("State");
//        LocalDate dob = LocalDate.parse((String) user.get("DOB"));
        String dob = dobConvert((String) user.get("DOB"));
        User patient = new User().id(id).surname(surname).firstname(firstName).email(email)
                .street(street).suburb(suburb).state(state).dob(dob).role(UserRole.PATIENT);
        return patient;
    }

    public String dobConvert(String dob){
        String[] dobArray = dob.split("/");
        String day = dobArray[0];
        String month = dobArray[1];
        String year = dobArray[2];
        if (Integer.parseInt(day) < 10){
            day = "0" + day;
        }
        String dobNew = year + "-" + month + "-" + day;
        return dobNew;
    }

    /** check if the patient is already in the database */
    public boolean isPatientExist(String id){
        Database db = new Database();
        User patient = db.getUserById(id);
        return patient != null;
    }

    /** create appointment instance from json object */
    public Appointment processAppt(JSONObject appt){
        String id = (String) appt.get("Id");
        String uid = (String) appt.get("PT_Id_Fk");
        String title = (String) appt.get("Reason");
        String detail = (String) appt.get("Comment");
        String note = (String) appt.get("Note");
        Instant dateCreate = Instant.parse((String) appt.get("CreationDate"));
        String test = (String) appt.get("StartTime");
        long startTime = Long.parseLong(test);
        Instant dateChange = updateTimeConvert((String) appt.get("LastUpdated"));
        Instant dateStart = Instant.parse((String) appt.get("StartDate"));
        Instant date = startDateConvert(dateStart, startTime);
        int duration = Integer.parseInt((String) appt.get("ApptDuration")) / 60;
        String status = (String) appt.get("status");
        Appointment appointment = new Appointment().id(id).uid(uid).title(title).detail(detail).note(note)
                .date_create(dateCreate).date_change(dateChange).date(date).duration(duration).status(AppointmentStatus.UNCONFIRMED);
        return appointment;
    }

    /** check if the appointment is already in the database */
    public boolean isApptExist(String id){
        Database db = new Database();
        Appointment appt = db.getAppointment(id);
        return appt != null;
    }

    /* get the correct start time of an appointment */
    public Instant startDateConvert(Instant startDate, long startTime) {
        startDate = startDate.minus(Duration.ofHours(10));
        startDate = startDate.plusMillis(startTime);
        return startDate;

    }

    /** get the correct update time from String */
    public Instant updateTimeConvert(String lastChnageDate) {
        String year = lastChnageDate.substring(0, 4);
        String month = lastChnageDate.substring(4, 6);
        String day = lastChnageDate.substring(6, 8);
        String hour = lastChnageDate.substring(8, 10);
        String minute = lastChnageDate.substring(10, 12);
        String second = lastChnageDate.substring(12);
        String updateTime = year + "-" + month + "-" + day + "T" + hour + ":" + minute + ":" + second
                + ".00Z";
        Instant instant = Instant.parse(updateTime);
        return instant;
    }

    public boolean fileHandler(JSONObject file) {
        int bytesRead = 0;
        InputStream in = null;
        String path = System.getProperty("user.dir");
        String filePath =  path + "\\result\\" + file.get("PT_Id_Fk") + "\\" + file.get("FileName");

        try {
            in = connectedSocket.getInputStream();
            File newFile = new File(filePath);
            if (!newFile.exists()){
                newFile.getParentFile().mkdir();
                newFile.createNewFile();
            }
            DataInputStream clientData = new DataInputStream(in);
            OutputStream output = new FileOutputStream(newFile);
            long size = (long) file.get("FileSize");
            byte[] buffer = new byte[1024];
            while (size > 0 && (bytesRead = clientData.read(buffer, 0, (int)Math.min(buffer.length, size))) != -1) {

                output.write(buffer, 0, bytesRead);
                size -= bytesRead;
            }
            output.flush();
            output.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        com.medsec.entity.File patientFile = new com.medsec.entity.File().id((String) file.get("Id"))
                .title((String) file.get("FileName")).link(filePath).apptid((String) file.get("PT_Id_Fk"));
        Database db = new Database();
        if (!isFileExist((String) file.get("Id"))){
            LOG.info("insert new File");
            db.insertFile(patientFile);
        }
        return false;
    }

    public boolean isFileExist(String id){
        Database db = new Database();
        com.medsec.entity.File file = db.selectFileById(id);
        return file != null;
    }
}
