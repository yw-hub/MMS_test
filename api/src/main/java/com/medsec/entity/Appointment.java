package com.medsec.entity;

import com.medsec.util.*;

import java.time.Instant;

public class Appointment {
    private String id;
    private String uid;
    private String did;
    private String title;
    private String detail;
    private Instant date_create;
    private Instant date_change;
    private Instant date;
    private Integer duration;
    private String note;
    private String user_note;
    private AppointmentStatus status;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getDid() {
        return did;
    }

    public void setDid(String did) {
        this.did = did;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public Instant getDate_create() {
        return date_create;
    }

    public void setDate_create(Instant date_create) {
        this.date_create = date_create;
    }

    public Instant getDate_change() {
        return date_change;
    }

    public void setDate_change(Instant date_change) {
        this.date_change = date_change;
    }

    public Instant getDate() {
        return date;
    }

    public void setDate(Instant date) {
        this.date = date;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getUser_note() {
        return user_note;
    }

    public void setUser_note(String user_note) {
        this.user_note = user_note;
    }

    public AppointmentStatus getStatus() {
        return status;
    }

    public void setStatus(AppointmentStatus status) {
        this.status = status;
    }

    public Appointment id(final String id) {
        this.id = id;
        return this;
    }

    public Appointment uid(final String uid) {
        this.uid = uid;
        return this;
    }

    public Appointment did(final String did) {
        this.did = did;
        return this;
    }

    public Appointment title(final String title) {
        this.title = title;
        return this;
    }

    public Appointment detail(final String detail) {
        this.detail = detail;
        return this;
    }

    public Appointment date_create(final Instant date_create) {
        this.date_create = date_create;
        return this;
    }

    public Appointment date_change(final Instant date_change) {
        this.date_change = date_change;
        return this;
    }

    public Appointment date(final Instant date) {
        this.date = date;
        return this;
    }

    public Appointment duration(final Integer duration) {
        this.duration = duration;
        return this;
    }

    public Appointment note(final String note) {
        this.note = note;
        return this;
    }

    public Appointment user_note(final String user_note) {
        this.user_note = user_note;
        return this;
    }

    public Appointment status(final AppointmentStatus status) {
        this.status = status;
        return this;
    }
}