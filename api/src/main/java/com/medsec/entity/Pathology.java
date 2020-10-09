package com.medsec.entity;

public class Pathology {
    private String id;
    private String name;
    private String address;
    private String phone;
    private String hours;
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

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public Pathology id(final String id) {
        this.id = id;
        return this;
    }

    public Pathology name(final String name) {
        this.name = name;
        return this;
    }

    public Pathology address(final String address) {
        this.address = address;
        return this;
    }

    public Pathology phone(final String phone) {
        this.phone = phone;
        return this;
    }

    public Pathology hours(final String hours) {
        this.hours = hours;
        return this;
    }

    public Pathology website(final String website) {
        this.website = website;
        return this;
    }
}
