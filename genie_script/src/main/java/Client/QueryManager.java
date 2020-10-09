//package Client;
//
//import Interpretation.FDInterpreter;
//import Interpretation.WrappedInputStream;
//import org.json.simple.JSONArray;
//
//import java.io.IOException;
//import java.io.OutputStreamWriter;
//import java.net.Socket;
//
//@Deprecated
///**
// * Handles Query between client and GENIE DB
// */
//public class QueryManager {
//
//    private final String GENIE_IP = "10.160.36.46";
//    private final int GENIE_PORT = 19812;
//    private Socket echoSocket;
//
//    private StringBuilder outputBuilder;
//    private OutputStreamWriter out;
//    private WrappedInputStream in;
//
//    /**
//     * Setup Query Manager
//     *
//     * @throws IOException
//     */
//    public QueryManager() throws IOException {
//        this.echoSocket = new Socket(GENIE_IP, GENIE_PORT);
//        this.outputBuilder = new StringBuilder();
//        this.out =
//                new OutputStreamWriter(echoSocket.getOutputStream(), "UTF-8");
//        this.in = new WrappedInputStream(echoSocket);
//    }
//
//    /**
//     * Calls login to GENIE server
//     * Login must be first called before connecting
//     * @throws IOException
//     * @throws IllegalAccessException
//     * @throws NoSuchFieldException
//     * @throws InstantiationException
//     */
//    public boolean login() throws IOException, IllegalAccessException,
//            NoSuchFieldException, InstantiationException {
//        System.out.println("GENIE-LOGIN executing");
//        out.write("001 Login\r\nUser-name:Wenkai\r\nUser-password:123\r\nProtocol-version:13.0\r\n\r\n");
//        out.flush();
//
//        StringBuilder output = new StringBuilder();
//        while (output.indexOf("\r\n\r\n") == -1) {
//            output.append(in.readChar());
//        }
//        System.out.print(output);
//        if (output.indexOf("On SQL Authentication failed") != -1)
//            return false;
//        output.setLength(0);
//
//        System.out.println("\nGENIE-LOGIN executed");
//        return true;
//
//    }
//
//    /**
//     * Executes Query operation on the server
//     * @param queryString
//     * @return
//     * @throws IOException
//     * @throws IllegalAccessException
//     * @throws NoSuchFieldException
//     * @throws InstantiationException
//     */
//    public JSONArray query(String queryString) throws IOException, IllegalAccessException, NoSuchFieldException, InstantiationException {
//        System.out.println("GENIE-QUERY executing");
//        out.write("002 Execute-statement\r\nStatement:" +
//                queryString +
//                "\r\nOutput-Mode:release\r\n\r\n");
//        out.flush();
//        System.out.println("interpreting");
//        JSONArray outputArray = FDInterpreter.getInstance().interpret(in);
//        System.out.println("\nGENIE-QUERY executed");
//        return outputArray;
//    }
//
//    /**
//     * Closes the connection between client and GENIE DB
//     * @throws IOException
//     * @throws IllegalAccessException
//     * @throws NoSuchFieldException
//     * @throws InstantiationException
//     */
//    public void logout() throws IOException, IllegalAccessException,
//            NoSuchFieldException, InstantiationException {
//        System.out.println("GENIE-LOGOUT executing");
//        out.write("003 Logout\r\n\r\n");
//        out.flush();
//        StringBuilder output = new StringBuilder();
//        while (output.indexOf("\r\n\r\n") == -1) {
//            output.append(in.readChar());
//        }
//        System.out.print(output);
//        output.setLength(0);
//        System.out.println("\nGENIE-LOGOUT executed");
//        this.echoSocket.close();
//    }
//}