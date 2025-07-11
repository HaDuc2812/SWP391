/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import entity.User;

/**
 *
 * @author HA DUC
 */
public class Accounts extends User {

    private int UsersId;
    private String email;
    private String password;
    private String fullName;
    private String role;

    public Accounts() {
        super();
    }

    public Accounts(int UsersId, String email, String password, String fullName, String role) {
        this.UsersId = UsersId;
        this.email = email;
        this.password = password;
        this.fullName = fullName;
        this.role = role;
    }

    public int getUsersId() {
        return UsersId;
    }

    public void setUsersId(int UsersId) {
        this.UsersId = UsersId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

}
