package com.medsec.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;

import com.medsec.entity.ResourceFile;

public interface ResourceFileMapper {
    ResourceFile selectRFileById(String id);
    List<ResourceFile> getResourcefilesByUserId(@Param("uid")  String uid);
    String getresourceLink(String id);
    String maxID();
    String getRFileLink(String id);
    void insertRFile(ResourceFile file);
    void updateRFile(ResourceFile file);
}
