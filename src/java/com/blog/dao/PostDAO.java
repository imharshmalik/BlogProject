package com.blog.dao;

import com.blog.entities.Category;
import com.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDAO {

       Connection con;

       public PostDAO(Connection con) {
              this.con = con;
       }

       public ArrayList<Category> getAllCategories() {
              ArrayList<Category> categoryList = new ArrayList();
              try {
                     String query = "select * from categories";
                     Statement stmt = con.createStatement();
                     ResultSet rs = stmt.executeQuery(query);

                     while (rs.next()) {
                            int cid = rs.getInt("category_id");
                            String cname = rs.getString("category_name");
                            String cdescription = rs.getString("category_description");
                            Category catObj = new Category(cid, cname, cdescription);
                            categoryList.add(catObj);
                     }
              } catch (Exception e) {
                     e.printStackTrace();
              }
              return categoryList;
       }

       public boolean addNewPost(Post post) {
              boolean flag = false;
              try {
                     String query = "INSERT INTO posts(post_title, post_content, post_pic, category_ID, user_ID) values(?, ?, ?, ?, ?)";
                     PreparedStatement pstmt = con.prepareCall(query);
                     pstmt.setString(1, post.getPtitle());
                     pstmt.setString(2, post.getPcontent());
                     pstmt.setString(3, post.getPpic());
                     pstmt.setInt(4, post.getCatid());
                     pstmt.setInt(5, post.getUid());
                     pstmt.executeUpdate();
                     flag = true;
              } catch (Exception e) {
                     e.printStackTrace();
              }
              return flag;
       }

       public List<Post> getAllPosts() {
              List<Post> allPosts = new ArrayList();
              try {
                     String query = "SELECT * from posts ORDER BY post_id DESC";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     ResultSet rs = pstmt.executeQuery();

                     while (rs.next()) {
                            int pid = rs.getInt("post_id");
                            String ptitle = rs.getString("post_title");
                            String pcontent = rs.getString("post_content");
                            String ppic = rs.getString("post_pic");
                            Timestamp pdate = rs.getTimestamp("post_date");
                            int catID = rs.getInt("category_ID");
                            int uID = rs.getInt("user_ID");

                            Post postObj = new Post(pid, ptitle, pcontent, ppic, pdate, catID, uID);
                            allPosts.add(postObj);
                     }
              } catch (Exception e) {
                     e.printStackTrace();
              }

              return allPosts;
       }

       public List<Post> getPostsByCategoryID(int categoryID) {
              List<Post> allPostsByCatID = new ArrayList();
              try {
                     String query = "SELECT * from posts WHERE category_ID=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, categoryID);
                     ResultSet rs = pstmt.executeQuery();

                     while (rs.next()) {
                            int pid = rs.getInt("post_id");
                            String ptitle = rs.getString("post_title");
                            String pcontent = rs.getString("post_content");
                            String ppic = rs.getString("post_pic");
                            Timestamp pdate = rs.getTimestamp("post_date");
                            int uID = rs.getInt("user_ID");

                            Post postObj = new Post(pid, ptitle, pcontent, ppic, pdate, categoryID, uID);
                            allPostsByCatID.add(postObj);
                     }
              } catch (Exception e) {
                     e.printStackTrace();
              }

              return allPostsByCatID;
       }

       public Post getPostByPostID(int postID) {
              Post postByPostID = null;
              try {
                     String query = "SELECT * from posts WHERE post_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     ResultSet rs = pstmt.executeQuery();

                     if (rs.next()) {
                            String ptitle = rs.getString("post_title");
                            String pcontent = rs.getString("post_content");
                            String ppic = rs.getString("post_pic");
                            Timestamp pdate = rs.getTimestamp("post_date");
                            int catID = rs.getInt("category_ID");
                            int uID = rs.getInt("user_ID");

                            postByPostID = new Post(postID, ptitle, pcontent, ppic, pdate, catID, uID);
                     }
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }

              return postByPostID;

       }
       
       public List<Post> getPostsByUserID(int userID) {
              List<Post> allPostsByThisUser = new ArrayList();
              try {
                     String query = "SELECT * FROM posts WHERE user_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, userID);
                     ResultSet rs = pstmt.executeQuery();
                     
                     while(rs.next()) {
                            int pid = rs.getInt("post_id");
                            String ptitle = rs.getString("post_title");
                            String pcontent = rs.getString("post_content");
                            String ppic = rs.getString("post_pic");
                            Timestamp pdate = rs.getTimestamp("post_date");
                            int catID = rs.getInt("category_ID");
                            int uID = rs.getInt("user_ID");

                            Post postObj = new Post(pid, ptitle, pcontent, ppic, pdate, catID, uID);
                            allPostsByThisUser.add(postObj);
                     }
              } 
              catch (Exception e) {
                     e.printStackTrace();
              }
              return allPostsByThisUser;
       }

       public List<Post> searchPost(String searchString) {
              List<Post> searchList = new ArrayList();
              String fullSearchString = "%"+searchString+"%";
              try {
                     String query = "SELECT * FROM posts WHERE post_title LIKE ?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setString(1, fullSearchString);
                     ResultSet rs = pstmt.executeQuery();

                     while (rs.next()) {
                            int pid = rs.getInt("post_id");
                            String ptitle = rs.getString("post_title");
                            String pcontent = rs.getString("post_content");
                            String ppic = rs.getString("post_pic");
                            Timestamp pdate = rs.getTimestamp("post_date");
                            int catID = rs.getInt("category_ID");
                            int uID = rs.getInt("user_ID");

                            Post postObj = new Post(pid, ptitle, pcontent, ppic, pdate, catID, uID);
                            searchList.add(postObj);
                     }
              } catch (Exception e) {
                     e.printStackTrace();
              }
              
              return searchList;
       }
       
       public boolean deletePostByID(int postID) {
              boolean flag = false;
              try {
                     String query = "DELETE FROM posts WHERE post_id=?";
                     PreparedStatement pstmt = con.prepareStatement(query);
                     pstmt.setInt(1, postID);
                     pstmt.executeUpdate();
                     flag = true;
              } catch (Exception e) {
                     e.printStackTrace();
              }
              
              return flag;
       }
       
       public boolean deleteAllPostsFromUser(int userID) {
              boolean  flag = false;
              try {
                     String query = "DELETE FROM posts WHERE user_id=?";
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
