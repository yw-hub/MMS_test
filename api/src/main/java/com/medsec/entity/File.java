package com.medsec.entity;

public class File {
    private String id;
    private String apptid;
    private String title;
    private String link;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getApptid() {
        return apptid;
    }

    public void setApptid(String apptid) {
        this.apptid = apptid;
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

    public File id(final String id) {
        this.id = id;
        return this;
    }

    public File apptid(final String apptid) {
        this.apptid = apptid;
        return this;
    }

    public File title(final String title) {
        this.title = title;
        return this;
    }

    public File link(final String link) {
        this.link = link;
        return this;
    }
}
