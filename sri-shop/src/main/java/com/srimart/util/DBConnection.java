package com.srimart.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DBConnection {

    private static final String URL =
            "jdbc:postgresql://localhost:5432/srimart";

    private static final String USER =
            "postgres";

    /*
     * PostgreSQL password is read from the
     * SRIMART_DB_PASSWORD environment variable.
     *
     * Do NOT put the real password directly in this file.
     */
    private static final String PASSWORD =
            System.getenv("SRIMART_DB_PASSWORD");

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {

        if (PASSWORD == null || PASSWORD.isBlank()) {
            throw new SQLException(
                    "Database password is not configured. " +
                    "Please set the SRIMART_DB_PASSWORD environment variable."
            );
        }

        try {
            Class.forName("org.postgresql.Driver");

        } catch (ClassNotFoundException e) {

            throw new SQLException(
                    "PostgreSQL JDBC Driver not found.",
                    e
            );
        }

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }

    public static void close() {
        /*
         * No connection pool to close.
         *
         * Each DAO class uses try-with-resources,
         * so database connections are closed automatically.
         */
    }
}