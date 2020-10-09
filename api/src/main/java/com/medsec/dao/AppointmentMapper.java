package com.medsec.dao;

import com.medsec.entity.Appointment;
import com.medsec.util.AppointmentStatus;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AppointmentMapper {

    /*
        You can pass multiple parameters to a mapper method.
        If you do, they will be named by the literal "param" followed
        by their position in the parameter list by default,
        for example: #{param1}, #{param2} etc.
        If you wish to change the name of the parameters (multiple only),
        then you can use the @Param("paramName") annotation on the parameter.
     */
    Appointment getAppointmentById(String id);

    List<Appointment> getAppointmentsByUserId(
            @Param("uid")  String uid,
            @Param("since")  String since,
            @Param("until")  String until,
            @Param("status") AppointmentStatus status);

    void updateUserNoteById(Appointment appointment);

    void updateStatusById(Appointment appointment);

    void insertAppointment(Appointment appointment);

    void updateAppointment(Appointment appointment);
}
