package com.medsec.dao;

import com.medsec.entity.NotificationToken;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;

public interface NotificationTokenMapper {

    ArrayList<String> getTokensByUserId(
            @Param("uid") String uid
    );

    NotificationToken getUserByToken(@Param("fcm_token") String fcm_token);
    void insertUserToken(NotificationToken token);

    void deleteUserToken(NotificationToken token);

}
