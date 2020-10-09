package com.medsec.dao;

import com.medsec.entity.Patient;

public interface PatientMapper {
    String getTokenByUid(String id);

    //patient sign up
    void signUp(Patient patient);

    //select patient by email
    Patient selectbyEmail(String email);

    //patient log in
    void logIn(Patient patient);

}
