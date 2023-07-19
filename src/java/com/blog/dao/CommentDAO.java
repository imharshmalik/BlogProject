package com.blog.dao;

import com.blog.entities.Comment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
       Connection con;

       public CommentDAO(Connection con) {
              this.con = con;
       }
       
       public boolean addComment (int postID, int userID, String comment) {
              boolean flag = false;
              try {
                     String query = "INSERT INTO comments(post_id, user_id, comment_content) VALUES(?, ?, ?)";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     pstmt.setInt(2, userID);
                     pstmt.setString(3, comment);
                     pstmt.executeUpdate();
                     flag = true;
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
       
       public int countCommentsOnAPost (int postID) {
              int totalComments = 0;
              try {
                     String query = "SELECT COUNT(*) FROM comments WHERE post_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     ResultSet rs = pstmt.executeQuery();
                     if (rs.next()) {
                            totalComments = rs.getInt(1);
                     }
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }
              
              return totalComments;
       }
       
       public boolean deleteComment (int postID, int userID) {
              boolean flag = false;
              try {
                     String query = "DELETE FROM comments WHERE post_id=? AND user_id=?";
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
       
       public List<Comment> getAllComments(int postID) {
              List<Comment> allComments = new ArrayList();
              try {
                     String query = "SELECT * FROM comments WHERE post_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     ResultSet rs = pstmt.executeQuery();
                     while(rs.next()) {
                            String commentContent = rs.getString("comment_content");
                            int userID = rs.getInt("user_id");
                            Timestamp commentDate = rs.getTimestamp("comment_date");
                            Comment commentObject = new Comment(commentContent, postID, userID, commentDate);
                            allComments.add(commentObject);
                     }
                                       
              } catch (Exception e) {
              }
              
              return allComments;
       }
       
}
