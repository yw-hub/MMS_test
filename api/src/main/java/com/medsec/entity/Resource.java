package com.medsec.entity;

import java.time.Instant;
import java.time.LocalDate;

public class Resource {
    private String id;
    private String uid;
    private String name;
    private String content;
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Resource id(final String id) {
        this.id = id;
        return this;
    }

    public Resource uid(final String uid) {
        this.uid = uid;
        return this;
    }

    public Resource name(final String name) {
        this.name = name;
        return this;
    }

    public Resource content(final String content) {
        this.content = content;
        return this;
    }

    public Resource date(final LocalDate date) {
        this.date = date;
        return this;
    }
}
