package Interpretation;

import java.net.Socket;
import java.io.InputStream;
import java.io.IOException;

public class WrappedInputStream {
	InputStream i;
	
	public WrappedInputStream(Socket input) throws IOException {
		i = input.getInputStream();
	}
	
	public byte readByte() throws IOException {
		byte[] readByte = new byte[1];
		i.read(readByte);
		return readByte[0];
	}
	
	public char readChar() throws IOException {
		return (char) (readByte() & 0xFF);
	}
}