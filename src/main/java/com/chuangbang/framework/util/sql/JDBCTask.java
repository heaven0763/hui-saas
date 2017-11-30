/*
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

package com.chuangbang.framework.util.sql;

import java.sql.*;
import java.util.*;
import java.util.logging.*;


/**
 * ִ�� JDBC ����ĳ�����
 * @author Unmi
 */

public abstract class JDBCTask {

        private static Logger log = Logger.getLogger(JDBCTask.class.getName());
        static{
                log.setLevel(Level.WARNING);
        }

    /**
     * Autocommit flag. Default value is false
     */
    private boolean autocommit = true;

    /**
     * DB driver.
     */
    private String driver = null;

    /**
     * DB url.
     */
    private String url = null;

    /**
     * User name.
     */
    private String userId = null;

    /**
     * Password
     */
    private String password = null;

    /**
     * Class name of the JDBC driver; required.
     * @param driver The driver to set
     */
    public void setDriver(String driver) {
        this.driver = driver.trim();
    }

    /**
     * Sets the database connection URL; required.
     * @param url The url to set
     */
    public void setUrl(String url) {
        this.url = url;
    }

    /**
     * Sets the password; required.
     * @param password The password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Auto commit flag for database connection;
     * optional, default false.
     * @param autocommit The autocommit to set
     */
    public void setAutocommit(boolean autocommit) {
        this.autocommit = autocommit;
    }


    /**
     * Creates a new Connection as using the driver, url, userid and password
     * specified.
     *
     * The calling method is responsible for closing the connection.
     *
     * @return Connection the newly created connection.
     * @throws Exception if the UserId/Password/Url is not set or there
     * is no suitable driver or the driver fails to load.
     */
    protected Connection getConnection() {
        if (userId == null) {
            throw new RuntimeException("UserId attribute must be set!");
        }
        if (password == null) {
            throw new RuntimeException("Password attribute must be set!");
        }
        if (url == null) {
            throw new RuntimeException("Url attribute must be set!");
        }
        try {

            log.info("connecting to " + getUrl());
            Properties info = new Properties();
            info.put("user", getUserId());
            info.put("password", getPassword());
            Connection conn = getDriver().connect(getUrl(), info);

            if (conn == null) {
                // Driver doesn't understand the URL
                throw new SQLException("No suitable Driver for " + url);
            }

            conn.setAutoCommit(autocommit);
            return conn;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    /**
     * Gets an instance of the required driver.
     * @return Driver
     * @throws Exception
     */
    private Driver getDriver() {
        if (driver == null) {
            throw new RuntimeException("Driver attribute must be set!");
        }
        Driver driverInstance = null;
        try {
                driverInstance= (Driver)Class.forName(driver).newInstance();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                    "Class Not Found: JDBC driver " + driver + " could not be loaded",
                    e);
        } catch (IllegalAccessException e) {
            throw new RuntimeException(
                    "Illegal Access: JDBC driver " + driver + " could not be loaded",
                    e);
        } catch (InstantiationException e) {
            throw new RuntimeException(
                    "Instantiation Exception: JDBC driver " + driver + " could not be loaded",
                    e);
        }
        return driverInstance;
    }

    /**
     * Gets the autocommit.
     * @return Returns a boolean
     */
    public boolean isAutocommit() {
        return autocommit;
    }

    /**
     * Gets the url.
     * @return Returns a String
     */
    public String getUrl() {
        return url;
    }

    /**
     * Gets the userId.
     * @return Returns a String
     */
    public String getUserId() {
        return userId;
    }

    /**
     * Set the user name for the connection; required.
     * @param userId The userId to set
     */
    public void setUserid(String userId) {
        this.userId = userId;
    }

    /**
     * Gets the password.
     * @return Returns a String
     */
    public String getPassword() {
        return password;
    }
}