package com.medsec.util;

public class ArgumentException extends Exception {
    public static final String MISSING_FIELD = "Missing mandatory field";

    public ArgumentException() {
        super(MISSING_FIELD);
    }
    public ArgumentException(String message) {
        super(message);
    }

    public ArgumentException(String message, Throwable cause) {
        super(message, cause);
    }
}
