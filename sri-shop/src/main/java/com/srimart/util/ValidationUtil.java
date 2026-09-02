package com.srimart.util;

import java.util.regex.Pattern;

public final class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^[0-9]{10,15}$");

    private ValidationUtil() {
        // Utility class
    }

    public static boolean isValidName(String name) {
        return name != null
                && !name.trim().isEmpty()
                && name.trim().length() >= 2
                && name.trim().length() <= 100;
    }

    public static boolean isValidEmail(String email) {
        return email != null
                && EMAIL_PATTERN.matcher(email.trim()).matches();
    }

    public static boolean isValidPassword(String password) {
        return password != null
                && password.length() >= 8
                && password.length() <= 100;
    }

    public static boolean isValidPhone(String phone) {
        return phone == null
                || phone.trim().isEmpty()
                || PHONE_PATTERN.matcher(phone.trim()).matches();
    }

    public static boolean isValidRole(String role) {
        return "BUYER".equalsIgnoreCase(role)
                || "SELLER".equalsIgnoreCase(role);
    }
}