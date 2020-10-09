package com.medsec.dao;

import com.medsec.entity.File;

public interface FileMapper {
    File selectFileById(String id);
    String getLink(String id);
    void insertFile(File file);
    void updateFile(File file);
}
