package Client;

import SocketConnection.QueryCommand;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManagerFactory;
import javax.swing.*;
import javax.swing.filechooser.FileNameExtensionFilter;
import javax.swing.text.DefaultCaret;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import java.net.Socket;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.KeyStore;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;


public class GenieUI {
    private static int PORT = 11111;
    private static String IP = "13.58.243.191";
    public static String FileMonitorPATH="Please choose a directory as a Genie file";
    public static boolean monitorThread = false;//update 20/09/2020
    private static long prevTime;
    // 30 mins delay for update
    private static long DELAY_UPDATE = 12 * 60 * 60 * 1000;

    private static final Path PATH = Paths.get
            ("src/main/resources/").toAbsolutePath();
    //private static final String GENIE_DB_NAME = "TestData/user.json";
    private static final String CLIENT_KEY_STORE_PASSWORD = "client";
    private static final String CLIENT_TRUST_KEY_STORE_PASSWORD = "client";
    private static final String CLIENT_KEY_PATH = "/client_ks.jks";
    private static final String TRUST_SERVER_KEY_PATH = "/serverTrust_ks.jks";

    public static QueryCommand COMMAND = null;
    public static String FILE_UPLOAD_PATH = "";
    public static String FILE_EXTENSION = null;
    public static String PATIENT_FILE_UPLOAD_PATH = "";
    public static String APPOINTMENT_FILE_UPLOAD_PATH = "";
    public static String pdf_relatedID;

    private JPanel panelMain;
    private JTextField ipField;
    private JTextField portField;
    private JTextField monitorPath; //update 20/09/2020
    private JButton updateIPButton;
    private JButton updateMonitorButton;   //update 20/09/2020


    // update 20/09/2020
    private JButton choosePath;
    private JTextField pdfPath;
    private JButton Pdf_path_Button;

    //    waiting to be finished in Sprint2
    private JButton sendUpdateButton; // has to change to be a resource.xls modify button
    private JTextField resource_UserID;
    private JTextField resource_Title;
    private JComboBox selectPurpose;

    private JTextArea resource_Messages;
    private JScrollPane messageScrollPane;
    private JButton uploadPDFButton;
    private JTextField pdf_RelatedID_field;
    private JTextField pdfLabel;
    private JScrollPane consoleScrollPane;
    private JTextArea consoleTextArea;

    public GenieUI() {
        // Set print stream to output textarea
        PrintStream printStream = new PrintStream(new ConsoleOutputStream(consoleTextArea));
        System.setOut(printStream);
        System.setErr(printStream);

        // Allow for scrolling
        DefaultCaret caret = (DefaultCaret)consoleTextArea.getCaret();
        caret.setUpdatePolicy(DefaultCaret.ALWAYS_UPDATE);

        // Default set ip and port
        ipField.setText(IP);
        portField.setText(String.valueOf(PORT));
        pdfPath.setText(FILE_UPLOAD_PATH);
        monitorPath.setText(FileMonitorPATH);     //update 20/09/2020

        // Update IP button
        updateIPButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                IP = ipField.getText();
                PORT = Integer.parseInt(portField.getText());
                System.out.println("Server address has been set to : " + IP +":"+ PORT);
            }
        });

        //Choose directory button
        choosePath.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JFileChooser jfc = new JFileChooser();
                //
                jfc.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
                //
                jfc.setCurrentDirectory(new File("."));
                jfc.setMultiSelectionEnabled(false);
                jfc.showDialog(panelMain,"Save");
                File file = jfc.getSelectedFile();
                FileMonitorPATH = file.getAbsolutePath();
                monitorPath.setText(FileMonitorPATH);
            }
        });

        //Update monitor file path button  20/09/2020
        updateMonitorButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (monitorThread == false){
                    monitorThread = true;
//                    FileMonitorPATH = monitorPath.getText();
                    System.out.println("Location of files from GENIE has been set to : " + FileMonitorPATH);
                    FileMonitor monitor = new FileMonitor();
                    monitor.MonitorStart(FileMonitorPATH);
                }else{
                    JPanel monitorPanel = new JPanel();
                    JOptionPane.showMessageDialog(monitorPanel,
                            "Please close this application and open a new one to reset the file location!",
                            "Warn", JOptionPane.WARNING_MESSAGE);
                }

            }
        });

        // Update PDF File Path button
        Pdf_path_Button.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {

                JFileChooser jfc = new JFileChooser();
                jfc.setFileSelectionMode(JFileChooser.FILES_ONLY);
                jfc.setFileFilter(new FileNameExtensionFilter("pdf file", "pdf"));
                jfc.setCurrentDirectory(new File("."));
                jfc.setMultiSelectionEnabled(false);
                jfc.showDialog(panelMain,"Choose");
                File file = jfc.getSelectedFile();
                FILE_UPLOAD_PATH = file.getAbsolutePath();
                pdfPath.setText(FILE_UPLOAD_PATH);
            }
        });

        // Create new action listener for button sendUpdate and send update
        sendUpdateButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                String resourcePath = FileMonitorPATH + "/Resource.xls";
                File ResourceFile = new File(resourcePath);
                if (!ResourceFile.exists()) {

                    HSSFWorkbook workbook = new HSSFWorkbook();
                    HSSFSheet sheet = workbook.createSheet();
                    HSSFRow row = sheet.createRow(0);
                    HSSFCell cell = row.createCell(0);
                    cell.setCellValue("Id");
                    cell = row.createCell(1);
                    cell.setCellValue("Uid");
                    cell = row.createCell(2);
                    cell.setCellValue("Name");
                    cell = row.createCell(3);
                    //cell.setCellValue("Website");
                    cell.setCellValue("Date");
                    cell = row.createCell(4);
                    cell.setCellValue("Content");
                    try {
                        FileOutputStream resourceOutput = new FileOutputStream(resourcePath);
                        workbook.write(resourceOutput);
                        resourceOutput.close();
                    } catch (IOException e1) {
                        e1.printStackTrace();
                    }
                    System.out.println("Resource.xls has been created");
                } else {
                    System.out.println("Resource.xls already exists");
                }

                try{
                    FileInputStream fs=new FileInputStream(resourcePath);
                    POIFSFileSystem ps=new POIFSFileSystem(fs);
                    HSSFWorkbook wb=new HSSFWorkbook(ps);
                    LocalDate date = LocalDate.now(); // get the current date
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    String createdate = date.format(formatter);
                    System.out.println(createdate);
                    HSSFSheet sheet=wb.getSheetAt(0);
                    HSSFRow row=sheet.getRow(0);
                    FileOutputStream out=new FileOutputStream(resourcePath);
                    row=sheet.createRow((short)(sheet.getLastRowNum()+1));
                    row.createCell(0).setCellValue(sheet.getLastRowNum());
                    row.createCell(1).setCellValue(resource_UserID.getText());
                    row.createCell(2).setCellValue(resource_Title.getText());
                    row.createCell(3).setCellValue(createdate);
                    row.createCell(4).setCellValue(resource_Messages.getText());
                    //row.createCell(3).setCellValue(resource_Messages.getText());
                    out.flush();
                    wb.write(out);
                    out.close();
                }catch (IOException e2){
                    e2.printStackTrace();
                }
            }
        });

        //Create new action listener for button uploadPDFButton and send pdf file
        uploadPDFButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                try {
                    File pdfFile = new File(FILE_UPLOAD_PATH);
                    String fileName = pdfFile.getName();
                    String fileExtention = fileName.substring(fileName.lastIndexOf(".") + 1).trim();
                    if (selectPurpose.getSelectedItem().toString().equals("For Appointment")){
                        if (fileExtention.equals("pdf")){
                            COMMAND = QueryCommand.getCommandName("FileA");
                            FILE_EXTENSION = fileExtention;
                            pdf_relatedID = pdf_RelatedID_field.getText();
                        }else{
                            JPanel panel1 = new JPanel();
                            JOptionPane.showMessageDialog(panel1,
                                    "Invalid files in the current selection.\n" +
                                    "Please upload file with '.pdf' extension\n",
                                    "Warn", JOptionPane.WARNING_MESSAGE);
                            COMMAND = null;
                            FILE_EXTENSION = null;
                            System.out.println("Upload Failed");
                        }
                    }else{
                        if (fileExtention.equals("pdf")){
                            COMMAND = QueryCommand.getCommandName("FileP");
                            FILE_EXTENSION = fileExtention;
                            pdf_relatedID = pdf_RelatedID_field.getText();
                        }else{
                            JPanel panel1 = new JPanel();
                            JOptionPane.showMessageDialog(panel1,
                                    "Invalid files in the current selection.\n" +
                                            "Please upload file with '.pdf' extension\n",
                                    "Warn", JOptionPane.WARNING_MESSAGE);
                            COMMAND = null;
                            FILE_EXTENSION = null;
                            System.out.println("Upload Failed");
                        }
                    }
                    if (COMMAND != null) {
                        System.out.println("Send Update");
                        try {
                            Socket clientSocket = GenieUI.initSSLSocket();
                            TCPClient tcpClient = new TCPClient(clientSocket);
                            tcpClient.run();
                        } catch (IOException e1) {
                            e1.printStackTrace();
                        }
                    }
                    else{
                        JPanel panel4 = new JPanel();
                        JOptionPane.showMessageDialog(panel4,
                                "Please upload the correct file!",
                                "Warn", JOptionPane.WARNING_MESSAGE);
                        System.out.println("Please upload the correct file!");
                    }

                } catch (Exception e1) {
                    e1.printStackTrace();
                }
            }
        });
        selectPurpose.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                if (selectPurpose.getSelectedItem().toString().equals("For Appointment")){
                    pdfLabel.setText("Appointment ID:");
                }else{
                    pdfLabel.setText("Patient ID:");
                }
            }
        });
    }

    /**
     * Instantiate GENIE UI
     * @param args
     * @throws IOException
     * @throws InterruptedException
     */
    public static void main(String[] args) throws IOException, InterruptedException {
        // Init UI
        JFrame frame = new JFrame("Genie Script Application");
        frame.setContentPane(new GenieUI().panelMain);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
        frame.setSize(1066, 700);

        System.out.println("Client Scheduled Script Running");
    }

    public static Socket initSSLSocket() {
        try{
            KeyStore ks = KeyStore.getInstance("JKS");
            ks.load(new FileInputStream(PATH + CLIENT_KEY_PATH), CLIENT_KEY_STORE_PASSWORD.toCharArray());
            KeyManagerFactory kmf = KeyManagerFactory.getInstance("SunX509");
            kmf.init(ks, CLIENT_KEY_STORE_PASSWORD.toCharArray());

            KeyStore tks = KeyStore.getInstance("JKS");
            tks.load(new FileInputStream(PATH + TRUST_SERVER_KEY_PATH), CLIENT_TRUST_KEY_STORE_PASSWORD.toCharArray());
            TrustManagerFactory tmf = TrustManagerFactory.getInstance("SunX509");
            tmf.init(tks);

            SSLContext context = SSLContext.getInstance("SSL");

            context.init(kmf.getKeyManagers(), tmf.getTrustManagers(), null);

            Socket sslSocket = context.getSocketFactory().createSocket(IP, PORT);

            return sslSocket;
        } catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }

}
