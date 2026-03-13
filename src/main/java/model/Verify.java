package model;

import java.sql.Time;

public class Verify {
    private int userID;
    private int code;
    private Time expiredTime;

    public Verify() {
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Time getExpiredTime() {
        return expiredTime;
    }

    public void setExpiredTime(Time expiredTime) {
        this.expiredTime = expiredTime;
    }
}
