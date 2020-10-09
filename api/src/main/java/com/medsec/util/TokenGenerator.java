package com.medsec.util;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.UUID;

@Deprecated
public class TokenGenerator {
	public static String generateToken(String password){
		return UUID.fromString(UUID.nameUUIDFromBytes(password.getBytes()).toString()).toString();
	}
	public static Timestamp setTokenExpireTime(int expiretime_in_minutes){
		long nowMillis =System.currentTimeMillis();
		Timestamp timestamp=new Timestamp(nowMillis+expiretime_in_minutes*60*1000);
		return timestamp;
	}

	public static Timestamp setTokenExpireTime() {
	    return new Timestamp(new Date(2099, 12, 31).getTime());
    }
}
