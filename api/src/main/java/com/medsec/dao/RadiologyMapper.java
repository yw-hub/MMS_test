package com.medsec.dao;

import com.medsec.entity.Radiology;

import java.util.List;

public interface RadiologyMapper {
    List<Radiology> selectAllRadiologies();
    Radiology selectOneRadiology(String radiologyID);
    void addRadiology(Radiology radiology);
    void deleteRadiology(String radiologyID);
    void updateRadiology(Radiology radiology);
}
