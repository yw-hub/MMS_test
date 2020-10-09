package com.medsec.util;

import com.medsec.dao.PatientMapper;
import org.apache.ibatis.session.SqlSession;

@Deprecated
public class Authentication {
    public static boolean auth(String uid, String token) {
        boolean result = false;

        try (SqlSession session = ConfigListener.sqlSessionFactory.openSession()) {
            PatientMapper mapper = session.getMapper(PatientMapper.class);
            String genuine_token = mapper.getTokenByUid(uid);
            if (genuine_token != null && genuine_token.equals(token))
                result = true;
        }

        return result;
    }
}
