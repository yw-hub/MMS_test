package com.medsec.dao;

import com.medsec.entity.Resource;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ResourceMapper {
    Resource getResourceById(String ResourceID);

    List<Resource> getResourcesByUserId(@Param("uid")  String uid);

    void insertResource(Resource resource);

    void deleteResource(String ResourceID);

    void updateResource(Resource resource);
}
