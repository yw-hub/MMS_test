import java.io.*;
import java.net.*;
import java.util.concurrent.TimeUnit;

public class BigFetch {
	
	public static char readChar(InputStream input) throws IOException {
		byte[] c = new byte[1];
		input.read(c);
		return (char) (c[0] & 0xFF);
	}
	
	public static void readUntil(InputStream input, StringBuilder word, char
            separator) throws IOException {
		char letter;
		word.setLength(0);
		letter = readChar(input);
		while (letter != separator) {
			word.append(letter);
			letter = readChar(input);
		}
		//if (dbg) System.out.println(word);
	}

	public static void readWindowsLine(InputStream input, StringBuilder word)
			throws IOException {
		readUntil(input, word, '\r');
		if (readChar(input) != '\n') {
			// Throw exception
		}
		System.out.println(word);
	}
	
	public static void main(String[] args) throws IOException, InterruptedException {
		try (
				Socket echoSocket = new Socket("13.236.71.140", 19812);
				PrintWriter out =
						new PrintWriter(echoSocket.getOutputStream(), true);
				InputStream stream = echoSocket.getInputStream();
		) {
			StringBuilder word = new StringBuilder();
			
			System.out.println("executing");
			out.print("001 Login\r\nUser-name:test\r\nUser-password:test\r\nProtocol-version:13.0\r\n\r\n");
			out.flush();
			
			System.out.println("executing");
			out.print("003 Execute-Statement\r\nStatement:" +
				args[0] +
				"\r\nFirst-Page-Size:1\r\nOutput-Mode:debug\r\n\r\n");
			out.flush();
			
			while (!"Row-Count".equals(word.toString().trim())) {
				readWindowsLine(stream, word);
				readUntil(stream, word, ':');
			}
			readWindowsLine(stream, word);
			int rowCount = Integer.parseInt(word.toString().trim());
			
			System.out.println("executing");
			out.print("003 Execute-Statement\r\nStatement:" +
				args[0] +
				"\r\nFirst-Page-Size:" +
				rowCount +
				"\r\nOutput-Mode:debug\r\n\r\n");
			out.flush();

			System.out.println("executing");
			out.print("005 Logout\r\n\r\n");
			out.flush();
			//System.out.println("echo: " + in.readLine());
			
			while (!"005 OK".equals(word.toString().trim())) {
				readWindowsLine(stream, word);
			}

		} catch (UnknownHostException e) {
			System.err.println("Failed loopback");
			System.exit(1);
		} catch (IOException e) {
			System.err.println("Couldn't get I/O for loopback");
			System.exit(1);
		} finally {
		}
	}
	
}