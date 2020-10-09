package com.medsec.dao;

import com.medsec.entity.User;

public interface UserMapper {
    User selectById(String id);
    User selectByEmail(String email);
    void updateToken(User user);
    void updatePassword(User user);
    void insertUser(User user);
    void updateUser(User user);

}
