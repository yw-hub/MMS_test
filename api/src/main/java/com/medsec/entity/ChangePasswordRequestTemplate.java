package com.medsec.entity;

public class ChangePasswordRequestTemplate extends User {
    private String new_password;

    public ChangePasswordRequestTemplate() {}

    public String getNew_password() {
        return new_password;
    }

    public void setNew_password(String new_password) {
        this.new_password = new_password;
    }
}