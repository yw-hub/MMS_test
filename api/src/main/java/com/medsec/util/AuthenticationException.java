package com.medsec.util;

public class AuthenticationException extends Exception {
    public static final String BAD_CREDENTIALS = "Bad credentials";
    public static final String INVALID_TOKEN = "Invalid token";
    public static final String TOKEN_EXPIRED = "Token expired";

    public static final String REGISTRATION_NOT_MATCH = "Registered information does not match.";
    public static final String USER_ALREADY_ACTIVATED = "User is already activated.";

    public AuthenticationException() {
        super(BAD_CREDENTIALS);
    }

    public AuthenticationException(String message) {
        super(message);
    }

    public AuthenticationException(String message, Throwable cause) {
        super(message, cause);
    }
}
