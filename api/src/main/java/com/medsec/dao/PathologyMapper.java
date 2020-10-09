package com.medsec.dao;

import com.medsec.entity.Pathology;

import java.util.List;

public interface PathologyMapper {
    List<Pathology> selectAllPathologies();
    Pathology selectOnePathology(String pathologyID);
    void addPathology(Pathology pathology);
    void deletePathology(String pathologyID);
    void updatePathology(Pathology pathology);

}
