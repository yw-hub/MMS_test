package com.medsec.util;

import com.medsec.base.Config;
import com.medsec.entity.User;
import io.jsonwebtoken.*;

import java.math.BigInteger;
import java.security.SecureRandom;
import java.time.Instant;
import java.util.Date;
import java.util.Random;

public class Token {
    private String uid;
    private String token;
    private String uuid;
    private Instant iat;
    private Instant exp;

    private Token() {
    }

    private Token(String uid, String token, String uuid, Instant iat, Instant exp) {
        this.uid = uid;
        this.token = token;
        this.uuid = uuid;
        this.iat = iat;
        this.exp = exp;
    }

    public String getUid() {
        return uid;
    }

    public String getToken() {
        return token;
    }

    public String getUuid() {
        return uuid;
    }

    public Instant getIat() {
        return iat;
    }

    public Instant getExp() {
        return exp;
    }

    private static byte[] getSecretKey() {
        return Config.TOKEN_SECRET_KEY.getBytes();
    }

    private static Instant getExpDate() {
        return Instant.now().plusSeconds(Config.TOKEN_TTL);
    }

    private static String getJTI() {
        Random random = new SecureRandom();
        return new BigInteger(130, random).toString(32);
    }

    private static Token createToken(String uid, UserRole role, Instant exp, String jti) {
        // Key
        byte[] key = getSecretKey();

        // JTI
        if (jti == null) jti = getJTI();

        // EXP
        if (exp == null) exp = getExpDate();

        //IAT
        Instant iat = Instant.now();

        // build
        String token = Jwts.builder()
                .claim("role", role)
                .setId(jti)
                .setExpiration(Date.from(exp))
                .setIssuedAt(Date.from(iat))
                .setSubject(uid)
                .signWith(SignatureAlgorithm.HS512, key)
                .compact();
        return new Token(uid, token, jti, iat, exp);
    }

    public static Token createToken(String uid, UserRole role) {
        return createToken(uid, role, null, null);
    }

    public static User createTokenForUser(User u) {
        Token token = createToken(u.getId(), u.getRole());
        u.token_expire_date(token.exp).token(token.token);
        u.token_valid_from(Instant.now());
        return u;
    }


    public static Token claimToken(String jwt) throws AuthenticationException {
        try {
            // Key
            byte[] key = getSecretKey();

            Jws<Claims> jws = Jwts.parser().setSigningKey(key).parseClaimsJws(jwt);
            String uid = jws.getBody().getSubject();
            String uuid = jws.getBody().getId();
            Instant iat = jws.getBody().getIssuedAt().toInstant();
            Instant exp = jws.getBody().getExpiration().toInstant();

            return new Token(uid, jwt, uuid, iat, exp);

            //OK, we can trust this JWT
        } catch(ExpiredJwtException e) {
            throw new AuthenticationException(AuthenticationException.TOKEN_EXPIRED);
        } catch(JwtException e) {
            throw new AuthenticationException(AuthenticationException.INVALID_TOKEN);
        }
    }


}
