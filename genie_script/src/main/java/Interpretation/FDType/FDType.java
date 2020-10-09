package Interpretation.FDType;

import com.google.gson.Gson;

import java.io.IOException;
import java.lang.Appendable;

import Interpretation.WrappedInputStream;

public abstract class FDType {
	
	public static final String identifier = null;
	protected String columnName;
	
	public FDType() {
		this.columnName = "unnamed column";
	}
	
	public void name(String name) {
		columnName = name;
	}
	
	public String getName() {
		return columnName;
	}
	
	public String getTypeIdentifier() {
		return identifier;
	}
	
	public abstract void interpret(WrappedInputStream input, Appendable output,
	                               Gson gson) throws IOException;
	
	protected static void keyval(String key, String val, Appendable output)
			throws IOException{
		output.append("\"");
		output.append(key);
		output.append("\"");
		output.append(":");
		output.append(val);
	}
	
	public void nullVal(Appendable output, Gson gson) throws IOException {
		keyval(columnName, gson.toJson(null), output);
	}
	
	// The byte array for primitives is a little-endian array of big-endian bytes
	protected static byte[] binaryStream(WrappedInputStream input, int length)
			throws IOException {
		byte[] stream = new byte[length];
		for (int i=1; i<=length; i++)
			stream[length-i] = input.readByte();
		return stream;
	}
	
	/*public class FDFloat extends FDType {
		public static final String identifier = "VK_FLOAT";
		// Not yet implemented
		// I don't know why someone would ever want to use this data type
		public void interpret(WrappedInputStream input, Appendable output, Gson gson);
	}
	
	public class FDBlob extends FDType {
		public static final String identifier = "VK_BLOB";
		// Not yet implemented
		public void interpret(WrappedInputStream input, Appendable output, Gson gson);
	}
	public class FDImage extends FDType {
		public static final String identifier = "VK_IMAGE";
		// Not yet implemented
		public void interpret(WrappedInputStream input, Appendable output, Gson gson);
	}*/
}