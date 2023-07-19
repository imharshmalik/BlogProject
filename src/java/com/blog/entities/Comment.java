package com.blog.entities;

import java.util.Date;

public class Comment {

       private int commentID;
       private String commentContent;
       private int postID;
       private int userID;
       private Date commentdate;

       public int getCommentID() {
              return commentID;
       }

       public void setCommentID(int commentID) {
              this.commentID = commentID;
       }

       public String getCommentContent() {
              return commentContent;
       }

       public void setCommentContent(String commentContent) {
              this.commentContent = commentContent;
       }

       public int getPostID() {
              return postID;
       }

       public void setPostID(int postID) {
              this.postID = postID;
       }

       public int getUserID() {
              return userID;
       }

       public void setUserID(int userID) {
              this.userID = userID;
       }

       public Date getDate() {
              return commentdate;
       }

       public void setDate(Date date) {
              this.commentdate = date;
       }

             
       public Comment() {
       }

       public Comment(int commentID, String commentContent, int postID, int userID) {
              this.commentID = commentID;
              this.commentContent = commentContent;
              this.postID = postID;
              this.userID = userID;
       }

       public Comment(String commentContent, int postID, int userID) {
              this.commentContent = commentContent;
              this.postID = postID;
              this.userID = userID;
       }

       public Comment(String commentContent, int postID, int userID, Date commentdate) {
              this.commentContent = commentContent;
              this.postID = postID;
              this.userID = userID;
              this.commentdate = commentdate;
       }

       
       
}
