package com.medsec.base;

/**
 * This class stores runtime variable configuration.
 * @author Wenzhuo Mi
 */
public class Config {
    public static boolean USE_DEV_DATABASE_PROFILE = false;
    public static String TOKEN_SECRET_KEY = "top-secret-key";
    public static long TOKEN_TTL = 24*60*60;
}
