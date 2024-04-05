<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.dao.UserDAO"%>
<%@page import="com.blog.entities.Comment"%>
<%@page import="java.util.List"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.CommentDAO"%>
<%@page errorPage="error_page.jsp" %>

<!-- To get user object -->
<%
       UserDAO udao = new UserDAO(ConnectionProvider.getConnection());
%>

<div class="row" style="border: 1px solid #ccc; border-radius: 10px; border-width: 15px; padding-bottom: 20px">
       <h5>Comments:</h5>
       <%
              CommentDAO cdao = new CommentDAO(ConnectionProvider.getConnection());
              int postID = Integer.parseInt(request.getParameter("pID"));
              List<Comment> allComments = cdao.getAllComments(postID);
              if (allComments.size() == 0) {
                     out.println("<h5 class='text-center mt-4'>No comments on this post yet.</h5>");
                     return;
              }
              String commentContent;
              int userID;
              for (Comment c : allComments) {
                     commentContent = c.getCommentContent();
                     userID = c.getUserID();
                     User userWhoCommentedOnThePost = udao.getUserByUserID(userID);
       %>
       <div class="col-md-2 mt-4 text-center">
              <img class="img-fluid top my-2" style="border-radius: 50%; height: 50px; width: 50px;" src="user_profile_pics/<%=userWhoCommentedOnThePost.getProfilePic()%>">
              <p style="font-weight: bold;"><a href="user_home.jsp?userID=<%= userWhoCommentedOnThePost.getId() %>"><%= userWhoCommentedOnThePost.getName()%></a></p>
              <p style="font-size: 13px;">on <%= c.getDate().toLocaleString() %></p>
       </div>
       <div class="col-md-8 offset-md-1 mt-4" style="border: 1px solid #ccc; border-radius: 10px; padding-bottom: 20px;">
              <p style="font-style: italic;"><%=commentContent%></p>
       </div>
       <%
              }
       %>
</div>