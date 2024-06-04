package model;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class GravatarUtil {
    public static String getGravatarUrl(String email) {
        String hash = md5Hex(email.trim().toLowerCase());
        return "https://www.gravatar.com/avatar/" + hash + "?d=identicon";
    }

    private static String md5Hex(String message) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            return String.format("%032x", new BigInteger(1, md.digest(message.getBytes())));
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
}
