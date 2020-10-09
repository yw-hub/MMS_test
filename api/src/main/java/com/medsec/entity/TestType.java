package com.medsec.entity;

public class TestType {

    private Integer FileId;
    private String FileTitle;
    private String FileLink;
    private String Patient_UserName;

    public Integer getFileId() {
        return FileId;
    }

    public void setFileId(Integer fileId) {
        FileId = fileId;
    }

    public String getFileTitle() {
        return FileTitle;
    }

    public void setFileTitle(String fileTitle) {
        FileTitle = fileTitle;
    }

    public String getFileLink() {
        return FileLink;
    }

    public void setFileLink(String fileLink) {
        FileLink = fileLink;
    }

    public String getPatient_UserName() {
        return Patient_UserName;
    }

    public void setPatient_UserName(String patient_UserName) {
        Patient_UserName = patient_UserName;
    }
}
