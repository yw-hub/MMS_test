import java.io.*;
import java.net.*;

public class EchoClient {
    public static void main(String[] args) throws IOException {
        try (
                Socket echoSocket = new Socket("13.236.71.140", 19812);
                PrintWriter out =
                        new PrintWriter(echoSocket.getOutputStream(), true);
                InputStream stream = echoSocket.getInputStream();
        ) {
            byte[] bytes = new byte[4096];
            int bytesRead = 0;

            System.out.println(System.getProperty("file.encoding"));
            System.out.println("executing");
            out.print("001 Login\r\nUser-name:test\r\nUser-password:test\r\nProtocol-version:13.0\r\n\r\n");
            out.flush();
            //System.out.println("echo: " + in.readLine());
            bytesRead = stream.read(bytes);
            for (int i =0; i < bytesRead; i++){
                System.out.print((char) (bytes[i] & 0xFF));
            }
            System.out.println("\nexecuted");

            System.out.println("executing");
             out.print("002 Execute-statement\r\nStatement:" +
                    args[0] +
                    "\r\nOutput-Mode:release\r\n\r\n");
            out.flush();
            //System.out.println("echo: " + in.readLine());
            //System.out.print((char)in.read());
            bytesRead = stream.read(bytes);
            for (int i =0; i < bytesRead; i++){
                System.out.print((char) (bytes[i] & 0xFF));
            }
            System.out.println("\nexecuted");

            System.out.println("executing");
            out.print("003 Logout\r\n\r\n");
            out.flush();
            //System.out.println("echo: " + in.readLine());
            bytesRead = stream.read(bytes);
            for (int i =0; i < bytesRead; i++){
                System.out.print((char) (bytes[i] & 0xFF));
            }
            System.out.println("\nexecuted");

        } catch (UnknownHostException e) {
            System.err.println("Failed loopback");
            System.exit(1);
        } catch (IOException e) {
            System.err.println("Couldn't get I/O for loopback");
            System.exit(1);
        }
    }
}