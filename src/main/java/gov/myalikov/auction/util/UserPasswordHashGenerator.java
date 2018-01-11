package gov.myalikov.auction.util;

import org.mindrot.jbcrypt.BCrypt;

public class UserPasswordHashGenerator {
    private static final int WORKLOAD = 17;

    public static String hash(String password_plaintext) {
        String salt = BCrypt.gensalt(WORKLOAD);
        return (BCrypt.hashpw(password_plaintext, salt));
    }

    public static boolean check(String password_plaintext, String stored_hash) {
        boolean password_verified = false;
        if (null == stored_hash || !stored_hash.startsWith("$2a$")) {
            throw new java.lang.IllegalArgumentException("Invalid hash provided for comparison");
        }
        return (BCrypt.checkpw(password_plaintext, stored_hash));
    }
}
