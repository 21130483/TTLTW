package model;


import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;

public class User {
    private int userID;
    private String email;
    private String phoneNumbers;
    private String fullName;
    private String password;
    private Date dob;
    private String gender;
    private boolean role;
    private boolean access;

    public User() {
    }

    public User(int userID, String email, String phoneNumbers, String fullName, String password, Date dob, String gender) {
        this.userID = userID;
        this.email = email;
        this.phoneNumbers = phoneNumbers;
        this.fullName = fullName;
        this.password = password;
        this.dob = dob;
        this.gender = gender;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumbers() {
        return phoneNumbers;
    }

    public void setPhoneNumbers(String phoneNumbers) {
        this.phoneNumbers = phoneNumbers;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Date getDob() {
        return dob;
    }

    public String getDobString() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String formattedDate = sdf.format(dob);
        return formattedDate;


    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public boolean getRole() {
        return role;
    }

    public void setRole(boolean role) {
        this.role = role;
    }

    public boolean getAccess() {
        return access;
    }

    public void setAccess(boolean access) {
        this.access = access;
    }




    @Override
    public String toString() {
        return "User{" +
                "userID=" + userID +
                ", email='" + email + '\'' +
                ", phoneNumbers=" + phoneNumbers +
                ", fullName='" + fullName + '\'' +
                ", password='" + password + '\'' +
                ", dob=" + dob +
                ", gender='" + gender + '\'' +
                ", role='" + role + '\'' +
                ", access='" + access + '\'' +
                '}';
    }

    public static void main(String[] args) {

    }

}