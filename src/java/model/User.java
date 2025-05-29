/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author HA DUC
 */
public class User {
    private int user_id;
    private String username;
    private String password_hash;
    private String role;
    private String full_name;
    private String email;
    private Date created_at;

    public User() {
    }

    public User(int user_id, String username, String password_hash, String role, String full_name, String email, Date created_at) {
        this.user_id = user_id;
        this.username = username;
        this.password_hash = password_hash;
        this.role = role;
        this.full_name = full_name;
        this.email = email;
        this.created_at = created_at;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword_hash() {
        return password_hash;
    }

    public void setPassword_hash(String password_hash) {
        this.password_hash = password_hash;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Date created_at) {
        this.created_at = created_at;
    }

    @Override
    public String toString() {
        return "User{" + "user_id=" + user_id + ", username=" + username + ", password_hash=" + password_hash + ", role=" + role + ", full_name=" + full_name + ", email=" + email + ", created_at=" + created_at + '}';
    }
    
}

