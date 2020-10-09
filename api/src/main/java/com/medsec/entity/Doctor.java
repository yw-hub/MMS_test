package com.medsec.entity;

public class Doctor {
    private String id;
    private String name;
    private String bio;
    private String address;
    private String phone;
    private String fax;
    private String email;
    private String website;
    private String expertise;

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

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
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

    public String getExpertise() {
        return expertise;
    }

    public void setExpertise(String expertise) {
        this.expertise = expertise;
    }

    public Doctor id(final String id) {
        this.id = id;
        return this;
    }

    public Doctor name(final String name) {
        this.name = name;
        return this;
    }

    public Doctor bio(final String bio) {
        this.bio = bio;
        return this;
    }

    public Doctor address(final String address) {
        this.address = address;
        return this;
    }

    public Doctor phone(final String phone) {
        this.phone = phone;
        return this;
    }

    public Doctor fax(final String fax) {
        this.fax = fax;
        return this;
    }

    public Doctor email(final String email) {
        this.email = email;
        return this;
    }

    public Doctor website(final String website) {
        this.website = website;
        return this;
    }

    public Doctor expertise(final String expertise) {
        this.expertise = expertise;
        return this;
    }
}
