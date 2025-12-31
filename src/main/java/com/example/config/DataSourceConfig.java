package com.example.config;

import org.postgresql.ds.PGSimpleDataSource;
import javax.sql.DataSource;

/**
 * Centralized database configuration.
 * Implements a Singleton pattern to provide a single DataSource instance.
 * Replaces the traditional DriverManager approach.
 */
public class DataSourceConfig {

    private static DataSource dataSource;

    // Private constructor to prevent instantiation
    private DataSourceConfig() {
    }

    /**
     * Returns the singleton DataSource instance.
     * Configured for PostgreSQL.
     *
     * @return DataSource instance
     */
    public static synchronized DataSource getDataSource() {
        if (dataSource == null) {
            PGSimpleDataSource ds = new PGSimpleDataSource();
            ds.setServerNames(new String[] { "localhost" });
            ds.setPortNumbers(new int[] { 5432 });
            ds.setDatabaseName("techstore"); // Change to your DB name
            ds.setUser("postgres"); // Change to your DB user
            ds.setPassword("0000"); // Change to your DB password

            dataSource = ds;
        }
        return dataSource;
    }
}
