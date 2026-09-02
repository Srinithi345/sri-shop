package com.srimart.util;

import java.sql.Connection;

public class DBTest {

    public static void main(String[] args) {

        try {
            Connection connection = DBConnection.getConnection();

            System.out.println("=================================");
            System.out.println("Database connection successful!");
            System.out.println("Connected to: srimart");
            System.out.println("=================================");

            connection.close();

        } catch (Exception e) {

            System.out.println("Database connection failed!");
            e.printStackTrace();
        }
    }
}