package Interpretation.FDType;

import java.io.IOException;
import java.lang.Appendable;
import java.lang.StringBuilder;
import java.nio.ByteBuffer;
import java.util.concurrent.TimeUnit;

import com.google.gson.Gson;

import Interpretation.WrappedInputStream;

public class FDTime extends FDType {
	public static final String identifier = "VK_TIME";
	public static final int[] lengths = {2, 1, 1};
	public static final String[] formats = {"%04d", "%02d", "%02d"};
	public static final String lastFormat = "%02d:%02d:%02d.%03dZ";
	public static final char[] separators = {'-', '-', 'T'};
	
	public FDTime() {
		super();
	}

	public void interpret(WrappedInputStream input, Appendable output, Gson gson) throws IOException {
		StringBuilder value = new StringBuilder();
		byte[] stream;
		long subValue;
		for (int i=0; i<lengths.length; i++) {
			stream = FDType.binaryStream(input, lengths[i]);
			if (lengths[i]==1) {
				subValue = ByteBuffer.wrap(stream).get();
			} else if (lengths[i]<=2) {
				subValue = ByteBuffer.wrap(stream).getShort();
			} else if (lengths[i] <= 4) {
				subValue = ByteBuffer.wrap(stream).getInt();
			} else {
				subValue = ByteBuffer.wrap(stream).getLong();
			}
			value.append(String.format(formats[i], subValue, subValue));
			value.append(separators[i]);
		}

		stream = FDType.binaryStream(input, 4);
		// Interpret the final byte set
		subValue = ByteBuffer.wrap(stream).getInt();
		value.append(String.format(lastFormat,
			TimeUnit.MILLISECONDS.toHours(subValue),
			TimeUnit.MILLISECONDS.toMinutes(subValue) %
				TimeUnit.HOURS.toMinutes(1),
			TimeUnit.MILLISECONDS.toSeconds(subValue) %
				TimeUnit.MINUTES.toSeconds(1),
			subValue % TimeUnit.SECONDS.toMillis(1)));

		FDType.keyval(columnName, value.toString(), output);
	}
}