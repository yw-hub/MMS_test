package Interpretation.FDType;

import java.io.IOException;

import Interpretation.WrappedInputStream;

public class FDLong extends FDIntegral {
	public static final String identifier = "VK_LONG";
	public static final int typeLength = 4;
	
	public FDLong() {
		super(typeLength);
	}
	
	public static int value(WrappedInputStream input) throws IOException {
		FDLong instance = new FDLong();
		return (int) instance.val(input);
	}
}