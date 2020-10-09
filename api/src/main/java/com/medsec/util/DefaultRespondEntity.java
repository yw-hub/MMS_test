package com.medsec.util;

public class DefaultRespondEntity {
    public static final String SUCCESS = "Success";
    private String message = SUCCESS;

    public DefaultRespondEntity() {
    }

    public DefaultRespondEntity(String message) {
        this.message = message;
    }

    public String getMessage() {
        return this.message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public DefaultRespondEntity message(final String message) {
        setMessage(message);
        return this;
    }

}
