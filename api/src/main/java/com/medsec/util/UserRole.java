package com.medsec.util;

public enum UserRole {
    PATIENT("Patient"),
    ADMIN("Admin");

    private String value;

    UserRole (String value) {
        this.value = value;
    }

    public String toString() {
        return value;
    }
}