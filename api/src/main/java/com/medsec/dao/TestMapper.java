package com.medsec.dao;

import com.medsec.entity.TestType;

public interface TestMapper {
    TestType selectFile(int id);
}
