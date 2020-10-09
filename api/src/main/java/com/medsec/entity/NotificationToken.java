package com.medsec.entity;

public class NotificationToken {
    private String id;
    private String uid;
    private String fcm_token;

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

    public String getFcmToken() {
        return fcm_token;
    }

    public void setFcmToken(String fcm_token) {
        this.fcm_token = fcm_token;
    }

    public NotificationToken uid(final String uid) {
        setUid(uid);
        return this;
    }

    public NotificationToken fcm_token(final String fcm_token) {
        setFcmToken(fcm_token);
        return this;
    }

}
