package com.medsec.dao;

import com.medsec.entity.Doctor;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface DoctorMapper {
    List<Doctor> selectAllDoctors();
    Doctor selectOneDoctor(String doctorID);
	
    List<Doctor> getDoctorsByUserId(
            @Param("uid")  String uid);	//new doctor list
			
    void deleteDoctor(String doctorID);
    void updateDoctor(Doctor doctor);
    void addDoctor(Doctor doctor);
}
