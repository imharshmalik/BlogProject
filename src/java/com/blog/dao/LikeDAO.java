
package com.blog.dao;

import java.sql.*;

public class LikeDAO {
       Connection con;

       // Constructor 
       public LikeDAO(Connection con) {
              this.con = con;
       }
       
       // Method to Add a Like to Post
       public boolean addLike (int postID, int userID) {
              boolean flag = false;
              try {
                     String query = "INSERT INTO likes(post_id, user_id) VALUES(?, ?)";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     pstmt.setInt(2, userID);
                     pstmt.executeUpdate();
                     flag = true;
              }
              catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
       
       public int countLikesOnAPost (int postID) {
              int numberOfLikes = 0;
              try {
                     String query = "SELECT COUNT(*) FROM likes WHERE post_id = ?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     ResultSet rs = pstmt.executeQuery();
                     if (rs.next()) {
                            numberOfLikes = rs.getInt(1);
                     }
              } catch (Exception e) {
              }
              
              return numberOfLikes;
       }
       
       public boolean isLikedByUser (int postID, int userID) {
              boolean flag = false;
              try {
                     String query = "SELECT * from likes WHERE post_id=? AND user_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     pstmt.setInt(2, userID);
                     ResultSet rs = pstmt.executeQuery();
                     if (rs.next()) {
                            flag = true;
                     }
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
       
       public boolean deleteLike (int postID, int userID) {
              boolean flag = true;
              try {
                     String query = "DELETE FROM likes WHERE post_id=? AND user_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     pstmt.setInt(2, userID);
                     pstmt.executeUpdate();
                     flag = false;
              } 
              catch (Exception e) {
                     e.printStackTrace();;
              }
              
              return flag;
       }
       
}
