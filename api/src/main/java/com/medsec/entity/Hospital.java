package com.medsec.entity;

public class Hospital {
    private String id;
    private String name;
    private String address;
    private String emergencyDept;
    private String phone;
    private String aftPhone;
    private String fax;
    private String email;
    private String website;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmergencyDept() {
        return emergencyDept;
    }

    public void setEmergencyDept(String emergencyDept) {
        this.emergencyDept = emergencyDept;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAftPhone() {
        return aftPhone;
    }

    public void setAftPhone(String aftPhone) {
        this.aftPhone = aftPhone;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public Hospital id(final String id) {
        this.id = id;
        return this;
    }

    public Hospital name(final String name) {
        this.name = name;
        return this;
    }

    public Hospital address(final String address) {
        this.address = address;
        return this;
    }

    public Hospital emergencyDept(final String emergencyDept) {
        this.emergencyDept = emergencyDept;
        return this;
    }

    public Hospital phone(final String phone) {
        this.phone = phone;
        return this;
    }

    public Hospital aftPhone(final String aftPhone) {
        this.aftPhone = aftPhone;
        return this;
    }

    public Hospital fax(final String fax) {
        this.fax = fax;
        return this;
    }

    public Hospital email(final String email) {
        this.email = email;
        return this;
    }

    public Hospital website(final String website) {
        this.website = website;
        return this;
    }
}
