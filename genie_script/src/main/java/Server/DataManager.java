package Server;

import java.io.*;
import java.net.Socket;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.simple.JSONObject;
import static java.lang.Math.toIntExact;
/**
 * DataManager that reads JSON and store into MYSQL DB
 */
public class DataManager {

    private static final Logger log = LogManager.getLogger();
    // JDBC driver name and databse URL
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:8889/medsec?useSSL=false";

    // Databse credentials
    private static final String USER = "root";
    private static final String PASSWORD = "root";

    private static DataManager instance = null;
    private static Connection connection;
    private static Statement stm;

    public static DataManager getInstance() {
        if (instance == null) {
            instance = new DataManager();
        }
        return instance;
    }

    public void ConnectionDB() {
        try {
            Class.forName(JDBC_DRIVER);
            log.info("coonecting mysql database");
            connection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void processFile(JSONObject file){
        try {
//            int id = Integer.parseInt((String) file.get("id"));
            String fileName = (String)file.get("FileName");
            int id = Integer.parseInt(fileName.substring(fileName.lastIndexOf("-") + 1,
                    fileName.lastIndexOf(".")).trim());
            // search the patient ID firstly to check if it exists in DB
            stm = connection.createStatement();
            String query = "SELECT id FROM File WHERE id = " + id;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the file " + id + ". Begin to update!");
                    updateFile(file);
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertFile(file);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateFile(JSONObject file) {
        String fileName = (String)file.get("FileName");
        int id = Integer.parseInt(fileName.substring(fileName.lastIndexOf("-") + 1,
                fileName.lastIndexOf(".")).trim());
        String title = fileName;
        String link = fileName;
        String pid = String.valueOf(id);
        String query = "UPDATE File SET title='" + title + "', link='"
                + link +"', pid='" + pid + "'" +
                "WHERE id= " + id;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertFile(JSONObject file) throws ParseException{
        String fileName = (String)file.get("FileName");
//        int id = Integer.parseInt((String) file.get("id"));
        int id = Integer.parseInt(fileName.substring(fileName.lastIndexOf("-") + 1,
                fileName.lastIndexOf(".")).trim());
        String title = fileName;
        String link = fileName;
        String pid = String.valueOf(id);
        String query = "INSERT INTO File (id, title, link, pid) " +
                "VALUES(?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,id);
            preparedStatement.setString(2, title);
            preparedStatement.setString(3, link);
            preparedStatement.setString(4,pid);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void processPatient(JSONObject patient) {
        try {
            int patientId = Integer.parseInt((String) patient.get("PatientId"));
            // search the patient ID firstly to check if it exists in DB
            stm = connection.createStatement();
            String query = "SELECT id FROM User WHERE id = " + patientId;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the patient" + patientId + ". Begin to update!");
                    updatePatient(patient);
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertPatient(patient);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /*
    Update existing patient
    Assume they only change their address or email
    */
    public void updatePatient(JSONObject patient) {
        int patientId = Integer.parseInt((String) patient.get("PatientId"));
        String email = (String) patient.get("Email");
        String street = (String) patient.get("Street");
        String suburb = (String) patient.get("Suburb");
        String state = (String) patient.get("State");
        String query = "UPDATE User SET email='" + email + "', street='"
                + street +"', suburb='" + suburb + "', state='" + state + "'" +
                "WHERE id= " + patientId;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    /*
    Insert new patient
     */
    public void insertPatient(JSONObject patient) throws ParseException{
        int patientId = Integer.parseInt((String) patient.get("PatientId"));
        String surname = (String) patient.get("SurName");
        String firstName = (String) patient.get("FirstName");
        //String middleName = (String) patient.get("MiddleName");
        String dob = (String) patient.get("DOB");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date dataStr = format.parse(dob);
        java.sql.Date dateDB = new java.sql.Date(dataStr.getTime());
        String email = (String) patient.get("Email");
        String street = (String) patient.get("Street");
        String suburb = (String) patient.get("Suburb");
        String state = (String) patient.get("State");
        String query = "INSERT INTO User (id, surname, firstname, dob, email, street, suburb, state) " +
                    "VALUES(?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,patientId);
            preparedStatement.setString(2,surname);
            preparedStatement.setString(3,firstName);
            preparedStatement.setDate(4,dateDB);
            preparedStatement.setString(5,email);
            preparedStatement.setString(6,street);
            preparedStatement.setString(7,suburb);
            preparedStatement.setString(8,state);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }





    public static Connection getConnection() {
        return connection;
    }

    public static Statement getStatement() {

        return stm;
    }

    public void processAppointment(JSONObject appointment) {
        try {
            int apptId = Integer.parseInt((String) appointment.get("id"));
            // search the patient ID firstly to check if it exists in DB
            stm = connection.createStatement();
            String query = "SELECT id FROM Appointment WHERE id = " + apptId;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the appointment" + apptId + ". Begin to update!");
                    try {
                        updateAppt(appointment);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertAppt(appointment);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateAppt(JSONObject appointment) throws ParseException{
        int apptId = Integer.parseInt((String) appointment.get("id"));
        String title = (String) appointment.get("name");
        //String dateChange = (String) appointment.get("LastUpdated");
        String date = (String) appointment.get("date");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date dataStr;
        dataStr = format.parse(date);
        java.sql.Date dateAppt = new java.sql.Date(dataStr.getTime());
        String note = (String) appointment.get("note");
        String status = (String) appointment.get("status");
        int duration = Integer.parseInt((String) appointment.get("duration"));
//        Boolean isCancelled = Boolean.valueOf((String) appointment.get("is_cancelled")) ;
        int patientId = Integer.parseInt((String) appointment.get("pid"));
        String query = "UPDATE Appointment SET title='" + title + "', date='" + dateAppt + "', note='" + note +
                "', status='" + status + "', duration='" + duration +
//                "', is_cancelled='" + isCancelled +
                "', uid='" + patientId +  "'" +
                "WHERE id= " + apptId;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertAppt(JSONObject appointment) throws ParseException{
        int apptId = Integer.parseInt((String) appointment.get("id"));
        String title = (String) appointment.get("name");
        String dataCreate = (String) appointment.get("data_create");
        //String dateChange = (String) appointment.get("LastUpdated");
        String date = (String) appointment.get("date");
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        java.util.Date dataStr;
        dataStr = format.parse(dataCreate);
        java.sql.Date dateCreated = new java.sql.Date(dataStr.getTime());
        dataStr = format.parse(date);
        java.sql.Date dateAppt = new java.sql.Date(dataStr.getTime());
        String detail = (String) appointment.get("detail");
        String note = (String) appointment.get("note");
        String status = (String) appointment.get("status");
        int duration = Integer.parseInt((String) appointment.get("duration"));
//        Boolean isCancelled = Boolean.valueOf((String) appointment.get("Cancelled")) ;
        int patientId = Integer.parseInt((String) appointment.get("pid"));
        String query = "INSERT INTO Appointment (id, title, date_create, date, detail, note, " +
                "status, duration, uid) " +
                "VALUES(?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,apptId);
            preparedStatement.setString(2,title);
            preparedStatement.setDate(3,dateCreated);
            preparedStatement.setDate(4,dateAppt);
            preparedStatement.setString(5,detail);
            preparedStatement.setString(6,note);
            preparedStatement.setString(7,status);
            preparedStatement.setInt(8,duration);
//            preparedStatement.setBoolean(9,isCancelled);
            preparedStatement.setInt(9,patientId);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void processPathology(JSONObject pathology) {
        try {
            int pathologyId = Integer.parseInt((String) pathology.get("id"));
            // search the patient ID firstly to check if it exists in DB
            stm = connection.createStatement();
            String query = "SELECT id FROM Pathology WHERE id = " + pathologyId;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the pathology" + pathologyId + ". Begin to update!");
                    try {
                        updatePathology(pathology);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertPathology(pathology);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePathology(JSONObject pathology) throws ParseException{
        int pathologyId = Integer.parseInt((String) pathology.get("id"));
        String name = (String) pathology.get("pathologyname");
        //String dateChange = (String) appointment.get("LastUpdated");
        String address = (String) pathology.get("address");
        String phone = (String) pathology.get("phone");
        String fax = (String) pathology.get("fax");
//        Boolean isCancelled = Boolean.valueOf((String) appointment.get("is_cancelled")) ;
//        String openhours = (String) pathology.get("openhours");
        String website = (String) pathology.get("website");
        String query = "UPDATE Pathology SET name='" + name + "', address='" + address + "', contact='" + phone +
                "', fax='" + fax + "', website='" + website +
//                "', is_cancelled='" + isCancelled +
//                "', uid='" + patientId +
                "'" +
                "WHERE id= " + pathologyId;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertPathology(JSONObject pathology) throws ParseException{
        int pathologyId = Integer.parseInt((String) pathology.get("id"));
        String name = (String) pathology.get("pathologyname");
        String address = (String) pathology.get("address");
        String phone = (String) pathology.get("phone");
        String fax = (String) pathology.get("fax");
        //        String openhours = (String) pathology.get("openhours");
        String website = (String) pathology.get("website");
        String query = "INSERT INTO Pathology (id, name, contact, address, fax, website) " +
                "VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,pathologyId);
            preparedStatement.setString(2,name);
            preparedStatement.setString(3,address);
            preparedStatement.setString(4,phone);
            preparedStatement.setString(5,fax);
            preparedStatement.setString(6,website);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void processRadiology(JSONObject radiology) {
        try {
            int radiologyId = Integer.parseInt((String) radiology.get("id"));
            // search the patient ID firstly to check if it exists in DB
            stm = connection.createStatement();
            String query = "SELECT id FROM Radiology WHERE id = " + radiologyId;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the radiology" + radiologyId + ". Begin to update!");
                    try {
                        updateRadiology(radiology);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertRadiology(radiology);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateRadiology(JSONObject radiology) throws ParseException{
        int radiologyId = Integer.parseInt((String) radiology.get("id"));
        String name = (String) radiology.get("radiologyname");
        //String dateChange = (String) appointment.get("LastUpdated");
        String address = (String) radiology.get("address");
        String phone = (String) radiology.get("phone");
        String fax = (String) radiology.get("fax");
//        Boolean isCancelled = Boolean.valueOf((String) appointment.get("is_cancelled")) ;
//        String openhours = (String) pathology.get("openhours");
        String website = (String) radiology.get("website");
        String query = "UPDATE Radiology SET name='" + name + "', address='" + address + "', contact='" + phone +
                "', fax='" + fax + "', website='" + website +
//                "', is_cancelled='" + isCancelled +
//                "', uid='" + patientId +
                "'" +
                "WHERE id= " + radiologyId;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertRadiology(JSONObject radiology) throws ParseException{
        int radiologyId = Integer.parseInt((String) radiology.get("id"));
        String name = (String) radiology.get("radiologyname");
        String address = (String) radiology.get("address");
        String phone = (String) radiology.get("phone");
        String fax = (String) radiology.get("fax");
        //        String openhours = (String) pathology.get("openhours");
        String website = (String) radiology.get("website");
        String query = "INSERT INTO Radiology (id, name, contact, address, fax, website) " +
                "VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,radiologyId);
            preparedStatement.setString(2,name);
            preparedStatement.setString(3,address);
            preparedStatement.setString(4,phone);
            preparedStatement.setString(5,fax);
            preparedStatement.setString(6,website);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void processDoctor(JSONObject doctor) {
        try {
            int doctorId = Integer.parseInt((String) doctor.get("id"));
            // search the patient ID firstly to check if it exists in DB
            stm = connection.createStatement();
            String query = "SELECT id FROM Doctor WHERE id = " + doctorId;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the doctor" + doctorId + ". Begin to update!");
                    try {
                        updateDoctor(doctor);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertDoctor(doctor);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDoctor(JSONObject doctor) throws ParseException{
        int doctorId = Integer.parseInt((String) doctor.get("id"));
        String name = (String) doctor.get("doctorname");
        //String dateChange = (String) appointment.get("LastUpdated");
        String address = (String) doctor.get("address");
        String phone = (String) doctor.get("phone");
        String fax = (String) doctor.get("fax");
        String email = (String) doctor.get("email");
//        String openhours = (String) pathology.get("openhours");
        String website = (String) doctor.get("website");
        String query = "UPDATE Doctor SET name='" + name + "', address='" + address + "', contact='" + phone +
                "', fax='" + fax + "', website='" + website + "', email='" + email +
//                "', is_cancelled='" + isCancelled +
//                "', uid='" + patientId +
                "'" +
                "WHERE id= " + doctorId;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertDoctor(JSONObject doctor) throws ParseException{
        int doctorId = Integer.parseInt((String) doctor.get("id"));
        String name = (String) doctor.get("doctorname");
        String address = (String) doctor.get("address");
        String phone = (String) doctor.get("phone");
        String fax = (String) doctor.get("fax");
        //        String openhours = (String) pathology.get("openhours");
        String website = (String) doctor.get("website");
        String email = (String) doctor.get("email");
        String query = "INSERT INTO Doctor (id, name, contact, address, fax, website, email) " +
                "VALUES(?,?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,doctorId);
            preparedStatement.setString(2,name);
            preparedStatement.setString(3,address);
            preparedStatement.setString(4,phone);
            preparedStatement.setString(5,fax);
            preparedStatement.setString(6,website);
            preparedStatement.setString(7,email);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void processHospital(JSONObject hospital) {
        try {
            int hospitalId = Integer.parseInt((String) hospital.get("id"));
            stm = connection.createStatement();
            String query = "SELECT id FROM Hospital WHERE id = " + hospitalId;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the hospital" + hospitalId + ". Begin to update!");
                    try {
                        updateHospital(hospital);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertHospital(hospital);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateHospital(JSONObject hospital) throws ParseException{
        int hospitalId = Integer.parseInt((String) hospital.get("id"));
        String name = (String) hospital.get("hospitalname");
        //String dateChange = (String) appointment.get("LastUpdated");
        String address = (String) hospital.get("address");
        String phone = (String) hospital.get("phone");
        String fax = (String) hospital.get("fax");
//        Boolean isCancelled = Boolean.valueOf((String) appointment.get("is_cancelled")) ;
//        String openhours = (String) pathology.get("openhours");
        String website = (String) hospital.get("website");
        String query = "UPDATE Hospital SET name='" + name + "', address='" + address + "', contact='" + phone +
                "', fax='" + fax + "', website='" + website +
//                "', is_cancelled='" + isCancelled +
//                "', uid='" + patientId +
                "'" +
                "WHERE id= " + hospitalId;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertHospital(JSONObject hospital) throws ParseException{
        int hospitalId = Integer.parseInt((String) hospital.get("id"));
        String name = (String) hospital.get("hospitalname");
        String address = (String) hospital.get("address");
        String phone = (String) hospital.get("phone");
        String fax = (String) hospital.get("fax");
        //        String openhours = (String) pathology.get("openhours");
        String website = (String) hospital.get("website");
        String query = "INSERT INTO Hospital (id, name, contact, address, fax, website) " +
                "VALUES(?,?,?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,hospitalId);
            preparedStatement.setString(2,name);
            preparedStatement.setString(3,address);
            preparedStatement.setString(4,phone);
            preparedStatement.setString(5,fax);
            preparedStatement.setString(6,website);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void processResource(JSONObject resource) {
        try {
            int resourceId = Integer.parseInt((String) resource.get("id"));
            stm = connection.createStatement();
            String query = "SELECT id FROM Resource WHERE id = " + resourceId;
            ResultSet resultSet = stm.executeQuery(query);
            if (resultSet.next()) {
                do {
                    log.info("find the resource" + resourceId + ". Begin to update!");
                    try {
                        updateResource(resource);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                } while (resultSet.next());
            } else {
                log.info("Cannot find it, it should be a new one. Begin to insert!");
                try {
                    insertResource(resource);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateResource(JSONObject resource) throws ParseException{
        int resourceId = Integer.parseInt((String) resource.get("id"));
        int patientId = Integer.parseInt((String) resource.get("pid"));
        String name = (String) resource.get("resourcename");
        //String dateChange = (String) appointment.get("LastUpdated");
//        Boolean isCancelled = Boolean.valueOf((String) appointment.get("is_cancelled")) ;
//        String openhours = (String) pathology.get("openhours");
        String website = (String) resource.get("website");
        String query = "UPDATE Resource SET uid='" + patientId + "', name='" + name + "', website='" + website +
//                "', is_cancelled='" + isCancelled +
                "'" +
                "WHERE id= " + resourceId;
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void insertResource(JSONObject resource) throws ParseException{
        int resourceId = Integer.parseInt((String) resource.get("id"));
        int patientId = Integer.parseInt((String) resource.get("pid"));
        String name = (String) resource.get("resourcename");
//        String p = (String) resource.get("fax");
        //        String openhours = (String) pathology.get("openhours");
        String website = (String) resource.get("website");
        String query = "INSERT INTO Resource (id, uid, name, website) " +
                "VALUES(?,?,?,?)";
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1,resourceId);
            preparedStatement.setInt(2,patientId);
            preparedStatement.setString(3,name);
            preparedStatement.setString(4,website);
            preparedStatement.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}