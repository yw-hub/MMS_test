package Interpretation.FDType;

import java.lang.Appendable;
import java.lang.StringBuilder;
import java.nio.ByteBuffer;
import java.io.IOException;
import java.nio.ByteOrder;

import com.google.gson.Gson;

import Interpretation.WrappedInputStream;

public class FDString extends FDType {
	public static final String identifier = "VK_STRING";
	public static final int lengthLength = 4;
	public static final int charLength = 2;
	private static final boolean dbg = false;
	
	public FDString() {
		super();
	}
	
	public void interpret(WrappedInputStream input, Appendable output, Gson gson) throws IOException {
		StringBuilder value = new StringBuilder();

		int length = FDLong.value(input);
		/*byte[] stream = FDType.binaryStream(input, lengthLength);
		int length = ByteBuffer.wrap(stream).getInt();
		if (dbg) for (byte b : stream) System.out.println(b);*/
		if (dbg) System.out.println(getName() + " string length: " + length);
		for (; length<0; length++) {
			byte[] stream = FDType.binaryStream(input, charLength);
			value.append(ByteBuffer.wrap(stream).getChar());
			//value.append(input.readChar());
		}
		FDType.keyval(columnName, value.toString(), output);
	}
}