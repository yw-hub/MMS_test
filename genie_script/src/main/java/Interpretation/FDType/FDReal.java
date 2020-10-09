package Interpretation.FDType;

import java.lang.Appendable;
import java.nio.ByteBuffer;
import java.io.IOException;

import com.google.gson.Gson;

import Interpretation.WrappedInputStream;

public class FDReal extends FDType {
	public static final String identifier = "VK_REAL";
	public static final int length = 8;
	
	public FDReal() {
		super();
	}
	
	public void interpret(WrappedInputStream input, Appendable output, Gson gson) throws IOException {
		byte[] stream = FDType.binaryStream(input, length);
		double result = ByteBuffer.wrap(stream).getDouble();
		FDType.keyval(columnName, gson.toJson(result), output);
	}
}