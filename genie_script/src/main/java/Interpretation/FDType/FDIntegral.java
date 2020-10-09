package Interpretation.FDType;

import java.lang.Appendable;
import java.nio.ByteBuffer;
import java.io.IOException;

import com.google.gson.Gson;

import Interpretation.WrappedInputStream;

public abstract class FDIntegral extends FDType {
	public final int length;
	public static final int maxLength = 8;
	
	public FDIntegral(int l) {
		super();
		this.length = l;
	}

	protected long val(WrappedInputStream input) throws IOException {
		byte[] stream = binaryStream(input, length);
		long result;
		if (length<=2) {
			result = ByteBuffer.wrap(stream).getShort();
		} else if (length <= 4) {
			result = ByteBuffer.wrap(stream).getInt();
		} else {
			result = ByteBuffer.wrap(stream).getLong();
		}
		return result;
	}

	public void interpret(WrappedInputStream input, Appendable output,
			Gson gson) throws IOException {
		long result = this.val(input);
		FDType.keyval(columnName, gson.toJson(result), output);
	}
}