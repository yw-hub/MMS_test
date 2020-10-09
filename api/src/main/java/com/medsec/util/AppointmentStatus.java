package com.medsec.util;

public enum AppointmentStatus {
    UNCONFIRMED("UNCONFIRMED"),
    CONFIRMED("CONFIRMED"),
    CANCELLED("CANCELLED");

    private String value;

    AppointmentStatus(String value) {
        this.value = value.toUpperCase();
    }

    public String toString() {
        return value;
    }
}
