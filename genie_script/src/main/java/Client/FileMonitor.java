package Client;
import java.io.File;
import java.io.IOException;
import java.net.Socket;
//import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import SocketConnection.QueryCommand;
import org.apache.commons.io.monitor.FileAlterationMonitor;
import org.apache.commons.io.monitor.FileAlterationObserver;

import javax.swing.*;

public class FileMonitor {

        private static void FileListenerTest(String FilePATH) throws Exception{
            String filePath = FilePATH;// monitor path
            long interval = TimeUnit.MILLISECONDS.toMillis(100);// set time interval 0.1sec
            FileAlterationObserver observer = new FileAlterationObserver(filePath);
            observer.addListener(new FileListener());//new file listener
            FileAlterationMonitor monitor = new FileAlterationMonitor(interval, observer);
            monitor.start();//start monitor
        }
        private static void InitUpload(String FilePATH){
            File folder = new File(FilePATH);
            File[] tempList = folder.listFiles();
            for (int i = 0; i < tempList.length; i++) {

                if (tempList[i].isFile()) {
                    String fileName = tempList[i].getName();
                    String fileExtention = fileName.substring(fileName.lastIndexOf(".") + 1).trim();
                    String filepath = tempList[i].getPath();
                    QueryCommand type = QueryCommand.getCommandName(fileName);
                    //System.out.println(filepath);
                    if (type!=null){

                        if (/*(type==QueryCommand.FILE && fileExtention.equals("pdf"))
                                ||*/ (type!=QueryCommand.FILE && fileExtention.equals("html"))
                                || (type!=QueryCommand.FILE && fileExtention.equals("xls")))
                        {
                            GenieUI.COMMAND = type;
                            GenieUI.FILE_EXTENSION = fileExtention;
                            System.out.println(GenieUI.COMMAND);
                        }
                        else{
                            GenieUI.COMMAND = null;
                            GenieUI.FILE_EXTENSION = null;
                            System.out.println(fileName + " is not a valid file, Upload Failed.");
                        }

                    }else{
                        GenieUI.COMMAND = null;
                        GenieUI.FILE_EXTENSION = null;
                        System.out.println(fileName + " is not a valid file, Upload Failed.");
                    }
                    GenieUI.FILE_UPLOAD_PATH = filepath;
                    if (GenieUI.COMMAND != null) {
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
                        System.out.println("Please upload the correct file!");
                    }
                }
                if (tempList[i].isDirectory()) {
                    System.out.println("The Folder " + tempList[i] + " is not expected to appear here!");
                }
            }
        }
        public static void MonitorStart(String FilePATH) {
            new Thread(new Runnable() {
                @Override
                public void run() {
                    try {
                        System.out.println("-----Please wait a while for the initialization-----");
                        JPanel warningPanel = new JPanel();
                        JOptionPane.showMessageDialog(warningPanel,
                                "Please do not do any operation on the folder until the initialization is over!" +
                                        "\nWe will send you an information dialog once the initialization finished!" +
                                        "\nClick OK to start initialization now!",
                                "Warn", JOptionPane.WARNING_MESSAGE);
                        InitUpload(FilePATH);
                        System.out.println("-----------Init Uploading finished---------");
                        JOptionPane.showMessageDialog(warningPanel,
                                "Now initialization is over!",
                                "Information", JOptionPane.WARNING_MESSAGE);
                        System.out.println("--------------Start Listening--------------");
                        FileListenerTest(FilePATH);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }).start();
        }
}

