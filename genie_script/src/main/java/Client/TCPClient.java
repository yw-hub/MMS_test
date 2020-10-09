package Client;

import java.io.*;
import java.net.Socket;

import javax.net.ssl.SSLSocket;

/**
 * TCPClient script that sends JSON GENIE Data
 */
public class TCPClient implements Runnable{

    private Socket connectionSocket;


    public TCPClient(Socket s) throws IOException {
        try{
            System.out.println("Server Connected");
            connectionSocket = s;
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    // Threaded script to open a socket connection
    public void run(){
        try{
            JSONWriter.getInstance().sendUpdateData(connectionSocket);
            connectionSocket.close();
        }catch(Exception e){e.printStackTrace();}
    }
}