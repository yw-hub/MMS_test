import SocketConnection.SymmetricEncrypt;
import org.junit.Test;

import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

/**
 * Tests symmetric encrption
 */
public class SymmetricEncryptTest {
    @Test
    public void testEncrypt() throws Exception {
        String testMessage = "testMessage";
        String encryptedTestMessage = SymmetricEncrypt.getInstance().encrypt
                (testMessage);
        assertFalse(encryptedTestMessage.equals(testMessage));
    }

    @Test
    public void testDecrypt() throws Exception {
        String testMessage = "sOO26BfjoHLEL9XctAYvsQ==";
        String decryptedTestMessage = SymmetricEncrypt.getInstance().decrypt
                (testMessage);
        assertFalse(decryptedTestMessage.equals(testMessage));
    }

    private String readFile(String path, Charset encoding) throws IOException {
        byte[] encoded = Files.readAllBytes(Paths.get(path).toAbsolutePath());
        return new String(encoded, encoding);
    }

    @Test
    public void testEncryptDecrypt() throws Exception {
        String testMessage = readFile
                ("test/main/java/Encryption/appointment_test_data.txt",
                StandardCharsets.UTF_8);
        String encryptedTestMessage = SymmetricEncrypt.getInstance().encrypt
                (testMessage);
        String decryptedTestMessage = SymmetricEncrypt.getInstance().decrypt
                (encryptedTestMessage);
        assertTrue(decryptedTestMessage.equals(testMessage));
    }
}
