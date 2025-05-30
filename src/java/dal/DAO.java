/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.User;

/**
 *
 * @author HA DUC
 */
public class DAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public User login(String email, String password) {
        String query = "select * from Users\n"
                + "where username = ?\n"
                + "and password_hash = ?";
        try {
            System.out.println("Connecting to database for login...");
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            System.out.println("Executing query: " + ps);
            rs = ps.executeQuery();
            while (rs.next()) {
                System.out.println("Login successful for user: " + email);
                return new User(rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password_hash"),
                        rs.getString("role"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getDate("created_at"));
            }
            System.out.println("Login failed for user: " + email);
        } catch (SQLException e) {
            System.out.println("SQL Exception during login: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                // Handle closing errors
                ex.printStackTrace();
            }
        }
        return null;
    }
//     public User checkAccountExists(String email) {
//        String query = "select * from Users\n"
//                + "where email = ?";
//        try {
//            System.out.println("Checking if account exists for user: " + email);
//            conn = DBContext.getConnection();
//            ps = conn.prepareStatement(query);
//            ps.setString(1, email);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                System.out.println("Account found for user: " + email);
//                return new User( rs.getInt("user_id"),
//                        rs.getString("username"),
//                        rs.getString("password_hash"),
//                        rs.getString("role"),
//                        rs.getString("full_name"),
//                        rs.getString("email"),
//                        rs.getDate("created_at"));
//            }
//            System.out.println("No account found for user: " + email);
//        } catch (SQLException e) {
//            e.printStackTrace();
//        } finally {
//            try {
//                if (rs != null) {
//                    rs.close();
//                }
//                if (ps != null) {
//                    ps.close();
//                }
//                if (conn != null) {
//                    conn.close();
//                }
//            } catch (SQLException ex) {
//                // Handle closing errors
//                ex.printStackTrace();
//            }
//        }
//        return null;
//    }
    public boolean register(String username, String password, String role, String fullName, String email){
        String sql = "insert into Users(username, password_hash, role, full_name, email) VALUES (?, ?, ?, ?, ?)";
        try{
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ps.setString(3, role);
            ps.setString(4, fullName);
            ps.setString(5,email);
            return ps.executeUpdate() > 0;
            
           
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            close();
        }
        return false;
    }
    public int countUsers(){
        String sql = "select count(*) from Users";
        try{
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        }catch(SQLException e){
            e.printStackTrace();
        }finally{
            close();
        }
        return 0;
    }
    private void close(){
        try{
            if(rs!= null) ps.close();
            if(ps!= null) ps.close();
            if(conn != null) conn.close();
        }catch(SQLException e){
            e.printStackTrace();
        }
    }
    public void updateUser(int user_id, String field, String value){
        String sql = "update User\n" 
                +"set "+ field + " = ?\n"
                +"where user_id = ?";
        try{
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, value);
            ps.setInt(2, user_id);
            ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try{
                if(ps!=null){
                    ps.close();
                }
                if(conn!= null){
                    conn.close();
                }
            }catch(SQLException e){
                e.printStackTrace();
            }
        }
    }

}

