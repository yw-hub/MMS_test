package SocketConnection;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.util.Base64;

public class SymmetricEncrypt {

    private static SymmetricEncrypt instance = null;
    private final String ALGORITHM = "AES";
    private final String SEC_KEY_STRING =
            "Bar12345Bar12345";
    private final SecretKey SECRET_KEY_SPEC = new SecretKeySpec(SEC_KEY_STRING
            .getBytes("UTF-8"),
            "AES");;

    private final String INIT_VECTOR = "RandomInitVector";
    private final IvParameterSpec IV_SPEC = new IvParameterSpec(INIT_VECTOR.getBytes("UTF-8"));


    protected SymmetricEncrypt() throws Exception {
        // Exists only to defeat instantiation.
    }

    public static SymmetricEncrypt getInstance() throws Exception {
        if(instance == null) {
            instance = new SymmetricEncrypt();
        }
        return instance;
    }

    public String encrypt(String valueEnc) throws Exception {

        Cipher cipher = Cipher.getInstance(ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, SECRET_KEY_SPEC);

        byte[] encryptedValue = cipher.doFinal(valueEnc.getBytes());

        return Base64.getEncoder().encodeToString(encryptedValue);
    }

    public String decrypt(String encryptedValue) {

        String decryptedValue = null;

        try {
            Cipher cipher = Cipher.getInstance(ALGORITHM);
            cipher.init(Cipher.DECRYPT_MODE, SECRET_KEY_SPEC);

            byte[] decVal = Base64.getDecoder().decode(encryptedValue);
            byte[] decValue = cipher.doFinal(decVal);

            decryptedValue = new String(decValue);
        } catch(Exception ex) {
            ex.printStackTrace();
        }

        return decryptedValue;
    }
}