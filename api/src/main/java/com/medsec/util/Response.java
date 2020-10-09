package com.medsec.util;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;


/**
 * This class provides methods to generate JSON response.
 * @author Wenzhuo Mi
 */
@Deprecated
public class Response {

    /**
     * Generates a simple success response with no content.
     * @return Composed JSON response message.
     */
    public static String success() {
        return composeResponse(true, null);
    }

    /**
     * Generates a success response with a message.
     * @param msg The message to be composed in the response.
     * @return Composed JSON response message.
     */
    public static String success(String msg) {
        return composeResponse(true, msg);
    }

    /**
     * Generates a success response with customised JSON Object.
     * @param result The content to be composed in the response.
     * @return Composed JSON response message.
     */
    public static String success(JSONObject result) {
        return composeResponse(true, result);
    }

    /**
     * Generates a success response with customised JSON Array.
     * @param result The content to be composed in the response.
     * @return Composed JSON response message.
     */
    public static String success(JSONArray result) {
        return composeResponse(true, result);
    }

    /**
     * Generates a simple error response with no content.
     * @return Composed JSON response message.
     */
    public static String error() {
        return composeResponse(false, null);
    }

    /**
     * Generates a error response with a message.
     * @param msg The message to be composed in the response.
     * @return Composed JSON response message.
     */
    public static String error(String msg) {
        return  composeResponse(false, msg);
    }

    /**
     * Generates a fully customised response.
     * @param success The response (success or not).
     * @param body The result.
     * @return Composed JSON response message.
     */
    @SuppressWarnings("unchecked")
    private static String composeResponse(boolean success, Object body) {
        JSONObject response = new JSONObject();
        String status = success ? "success" : "error";
        response.put("response", status);
        if (body != null)
            response.put("result", body);
        return response.toJSONString();
    }
}
