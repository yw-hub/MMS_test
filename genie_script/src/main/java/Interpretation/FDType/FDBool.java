package Interpretation.FDType;

import com.google.gson.Gson;

import java.lang.Appendable;
import java.io.IOException;
import java.nio.ByteBuffer;

import Interpretation.WrappedInputStream;

public class FDBool extends FDType {
	public static final String identifier = "VK_BOOLEAN";
	public static final int length = 2;
	
	public FDBool() {
		super();
	}
	
	public void interpret(WrappedInputStream input, Appendable output, Gson gson) throws IOException {
		byte[] stream = FDType.binaryStream(input, length);
		short result = ByteBuffer.wrap(stream).getShort();
		boolean value = (result == 0);
		FDType.keyval(columnName, gson.toJson(value), output);
	}
}