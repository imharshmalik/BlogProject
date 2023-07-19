
package com.blog.dao;

import com.blog.entities.User;
import java.sql.*;

public class UserDAO {
       private Connection con;

       public UserDAO(Connection con) {
              this.con = con;
       }
       
       public boolean addNewUser(User user){
              boolean flag = false;
              try {
                     String query = "insert into users (user_name, user_email, user_password) values (?, ?, ?)";
                     
                     PreparedStatement pstmt = this.con.prepareStatement(query);
                     
                     pstmt.setString(1, user.getName());
                     pstmt.setString(2, user.getEmail());
                     pstmt.setString(3, user.getPassword());
                     
                     pstmt.executeUpdate();
                     flag =  true;
              } catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
       
       public User getUserByEmailAndPassword (String email, String password) {
              User user = null;
              try {
                     String query = "select * from users where user_email=? and user_password=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setString(1, email);
                     pstmt.setString(2, password);
                     ResultSet rs = pstmt.executeQuery();
                     
                     if (rs.next()) {
                            user = new User();
                            user.setId(rs.getInt("user_id"));
                            user.setName(rs.getString("user_name"));
                            user.setEmail(rs.getString("user_email"));
                            user.setPassword(rs.getString("user_password"));
                            user.setRegistration_date(rs.getTimestamp("user_registration_date"));
                            user.setProfilePic(rs.getString("user_profile_pic"));
                     }
              } catch (Exception e) {
                     e.printStackTrace();
              }
                                        
              return user;
       }
       
       public boolean updateUserDetails (User user) {
              boolean flag = false;
              try {
                     String query = "update users set user_name=?, user_email=?, user_password=?, user_profile_pic=? where user_id=?";     
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setString(1, user.getName());
                     pstmt.setString(2, user.getEmail());
                     pstmt.setString(3, user.getPassword());
                     pstmt.setString(4, user.getProfilePic());
                     pstmt.setInt(5, user.getId());
                     pstmt.executeUpdate();
                     flag = true;
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }
              return flag;
       }
       
       public User getUserByUserID (int userID) {
              User userObj = null;
              try {
                     String query = "SELECT * FROM users  WHERE user_id = ?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, userID);
                     ResultSet rs = pstmt.executeQuery();
                     if (rs.next()) {
                            userObj = new User ();
                            userObj.setName(rs.getString("user_name"));
                            userObj.setEmail(rs.getString("user_email"));
                            userObj.setPassword(rs.getString("user_password"));
                            userObj.setRegistration_date(rs.getTimestamp("user_registration_date"));
                            userObj.setProfilePic(rs.getString("user_profile_pic"));
                            userObj.setId(userID);
                     }
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }
       
              return userObj;
       }
       
       public boolean deleteProfile(int userID) {
              boolean flag = false;
              try {
                     String query = "DELETE FROM users WHERE user_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, userID);
                     pstmt.executeUpdate();
                     flag = true;
              } catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
}
