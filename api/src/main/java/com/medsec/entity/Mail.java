package com.medsec.entity;

public class Mail {
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMailto() {
        return mailto;
    }

    public void setMailto(String mailto) {
        this.mailto = mailto;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    private String id;
    private String mailto;
    private String content;



    public Mail id(final String _id) {
        setId(_id);
        return this;
    }

    public Mail mailto(final String _mailto) {
        setId(mailto);
        return this;
    }

    public Mail content(final String _content) {
        setContent(_content);
        return this;
    }
}
