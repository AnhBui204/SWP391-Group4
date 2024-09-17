package Model;

import java.io.Serializable;

public class User implements Serializable {

    private String userID;
    private String username;
    private String password;
    private String email;
    private String role;
    private String phone;
    private String sex;
    private String dob;
    private String money;

    public User() {
    }

    public User(String username, String password, String role, String email, String userID) {
        this.username = username;
        this.password = password;
        this.role = role;
        this.email = email;
        this.userID = userID;
    }

    public User(String userID, String username, String password, String email) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.email = email;
    }

    public User(String userID, String username, String password, String email, String role, String phone, String sex, String dob, String money) {
        this.userID = userID;
        this.username = username;
        this.password = password;
        this.email = email;
        this.role = role;
        this.phone = phone;
        this.sex = sex;
        this.dob = dob;
        this.money = money;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    @Override
    public String toString() {
        return "UserID: " + userID + ", Username: " + username + ", Email: " + email + ", Role: " + role;
    }

}