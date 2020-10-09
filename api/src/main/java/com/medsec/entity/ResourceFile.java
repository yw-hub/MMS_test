package com.medsec.entity;

import java.time.Instant;
import java.time.LocalDate;

public class ResourceFile {
    private String id;
    private String uid;
    private String title;
    private String link;
    private LocalDate date;

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public ResourceFile id(final String id) {
        this.id = id;
        return this;
    }

    public ResourceFile uid(final String uid) {
        this.uid = uid;
        return this;
    }

    public ResourceFile title(final String title) {
        this.title = title;
        return this;
    }

    public ResourceFile link(final String link) {
        this.link = link;
        return this;
    }

    public ResourceFile date(final LocalDate date) {
        this.date = date;
        return this;
    }
}
