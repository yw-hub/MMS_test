package com.medsec.util;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 * Takes raw JSON string data and updates the local DB accordingly
 */
public class JSONReader{

    private static com.medsec.util.JSONReader instance = null;

    protected JSONReader() {
        // Exists only to defeat instantiation.
    }

    public static com.medsec.util.JSONReader getInstance() {
        if(instance == null) {
            instance = new com.medsec.util.JSONReader();
        }
        return instance;
    }


    /*
    TODO : Parse JSON, update Database
     */
    public JSONObject parse(String jsonString){
        try {
            JSONObject json = (JSONObject) new JSONParser().parse(jsonString);
            return json;
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
}
