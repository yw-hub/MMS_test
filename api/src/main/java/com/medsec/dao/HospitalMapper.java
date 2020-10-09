package com.medsec.dao;

import com.medsec.entity.Hospital;

import java.util.List;

public interface HospitalMapper {
    List<Hospital> selectAllHospitals();
    Hospital selectOneHospital(String hospitalID);
    void deleteHospital(String hospitalID);
    void updateHospital(Hospital hospital);
    void addHospital(Hospital hospital);
}
