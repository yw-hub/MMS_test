package com.medsec.entity;

public class Radiology {
    private String id;
    private String name;
    private String address;
    private String phone;
    private String fax;
    private String hours;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getFax() {
        return fax;
    }

    public void setFax(String fax) {
        this.fax = fax;
    }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
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

    public Radiology id(final String id) {
        this.id = id;
        return this;
    }

    public Radiology name(final String name) {
        this.name = name;
        return this;
    }

    public Radiology address(final String address) {
        this.address = address;
        return this;
    }

    public Radiology phone(final String phone) {
        this.phone = phone;
        return this;
    }

    public Radiology fax(final String fax) {
        this.fax = fax;
        return this;
    }

    public Radiology hours(final String hours) {
        this.hours = hours;
        return this;
    }

    public Radiology email(final String email) {
        this.email = email;
        return this;
    }

    public Radiology website(final String website) {
        this.website = website;
        return this;
    }
}
