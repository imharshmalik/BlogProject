<%@page import="com.blog.entities.Message"%>
<%@page import="com.blog.dao.CommentDAO"%>
<%@page import="com.blog.dao.LikeDAO"%>
<%@page import="com.blog.dao.UserDAO"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDAO"%>
<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.entities.Post"%>
<%@page errorPage="error_page.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- To confirm user session -->
<%
       User user = (User) session.getAttribute("currentUser");
       if (user == null) {
              response.sendRedirect("login.jsp");
       }
%>

<!-- To get post object -->
<%
       int postID = Integer.parseInt(request.getParameter("postID"));
       PostDAO pdao = new PostDAO(ConnectionProvider.getConnection());
       Post fullPost = pdao.getPostByPostID(postID);
%>

<!-- To get user object for the current post-->
<%
       UserDAO udao = new UserDAO(ConnectionProvider.getConnection());
       int userID = fullPost.getUid();
       User userForCurrentPost = udao.getUserByUserID(userID);
%>

<!-- To get likes and comments on the posts -->
<%
       LikeDAO likeObject = new LikeDAO(ConnectionProvider.getConnection());
       CommentDAO commentObject = new CommentDAO(ConnectionProvider.getConnection());
%>

<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title> <%= fullPost.getPtitle()%> </title>
              <%@include file="bootstrap.jsp" %>

              <style>
                     body{
                            background: url(img/pexels-pixabay-235985.jpg);
                            background-size: cover;
                            background-attachment: fixed;
                     }
                     .highlight {
                            background-color: transparent;
                            color: black;
                            border: 2px solid black;
                            border-radius: 20px;
                            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.4);
                     }

              </style>


       </head>
       <body>

              <!--Nav bar starts-->
              <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
                     <div class="container-fluid">
                            <a class="navbar-brand" href="#"> <span class="fa fa-code"></span> Harsh</a>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                                   <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                                   <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                                          <li class="nav-item">
                                                 <a class="nav-link active" aria-current="page" href="index.jsp"> <span class="fa fa-home"></span> Home</a>
                                          </li>
                                          <li class="nav-item">
                                                 <a class="nav-link" href="profile.jsp"> <span class="fa fa-mail-reply"></span> Back to Feed</a>
                                          </li>
                                   </ul>
                                   <ul class="navbar-nav mr-right">
                                          <li class="nav-item">
                                                 <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#profileModal"><span class="fa fa-user-circle-o"></span> <%=user.getName()%></a>
                                          </li>
                                          <li class="nav-item">
                                                 <a class="nav-link" href="LogoutServlet"><span class="fa fa-power-off"></span> Logout</a>
                                          </li>
                                   </ul>
                            </div>
                     </div>
              </nav>
              <!--Nav bar ends-->

              <!-- Main body of the post starts here -->
              <div class="container">
                     <div class="row my-4">
                            <div class="col-md-8 offset-md-2">
                                   <div class="card">
                                          <div class="card-header text-center bg-dark text-white">
                                                 <h3 class="post-title"> <%=fullPost.getPtitle()%> </h3>
                                          </div>
                                          <div class="card-body">
                                                 <img class="card-img-top my-2" src="blog_pics/<%=fullPost.getPpic()%>">
                                                 <br>
                                                 <div class="row my-3" style="border: 1px solid; padding-top: 15px;">
                                                        <div class="col-md-8">
                                                               <%
                                                                      if(user.getName().equals(userForCurrentPost.getName())) {
                                                                %>
                                                                          <p style="font-weight: bold;"> Author: <a href="my-home.jsp?userID=<%= userForCurrentPost.getId() %>" name="userID"> <%= userForCurrentPost.getName()%> </a></p>
                                                               <%
                                                                      } else {
                                                                %>
                                                                          <p style="font-weight: bold;"> Author: <a href="user_home.jsp?userID=<%= userForCurrentPost.getId() %>" name="userID"> <%= userForCurrentPost.getName()%> </a></p>
                                                                <%  
                                                                       } 
                                                                %>
                                                        </div>
                                                        <div class="col-md-4">
                                                               <p style="text-align: right; font-weight: bold; font-style: italic;"> <%= fullPost.getPdate().toLocaleString()%> </p> 
                                                        </div>
                                                 </div>

                                                 <p class="post-content" style="font-size: 20px; text-align: justify"> <%= fullPost.getPcontent()%> </p>
                                          </div>
                                          <div class="card-footer text-center bg-light text-dark">
                                                 <a href="#!" id="like_button" onclick="doLike(<%= fullPost.getPid()%>, <%= user.getId()%>)" class="btn btn-sm"> <i class="fa fa-thumbs-o-up fa-2x"></i> <span class="like-counter"> <%= likeObject.countLikesOnAPost(postID)%> </span></a>
                                                 <a href="#!" class="btn btn-sm"><i class="fa fa-commenting-o fa-2x"></i> <span> <%= commentObject.countCommentsOnAPost(postID)%></span></a>
                                          </div>
                                          <form action="AddCommentServlet?postID=<%= fullPost.getPid()%>" method="post" >
                                                 <div class="form-group" style="padding-top: 20px; padding-bottom: 20px">
                                                        <div class="text-center">
                                                               <textarea name="commentContent" rows="4" cols="45" placeholder="Type your comment"></textarea>
                                                               <br>
                                                               <br>
                                                               <input type="submit" class="btn btn-outline-primary" value="Post Comment as <%= user.getName()%>">
                                                        </div>
                                                 </div>
                                          </form>
                                          <div class="container-fluid" id="comment_container">
                                                 <div class="container-fluid" id="add_comment_container">

                                                 </div>
                                          </div>
                                   </div>
                            </div>
                     </div>
              </div>
              <!-- Main body of the post ends here -->

              <!-- Edit-Details Modal starts-->
              <div class="modal fade" id="profileModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                     <div class="modal-dialog">
                            <div class="modal-content">
                                   <div class="modal-header">
                                          <!-- <h1 class="modal-title" style="display:block; margin: auto;" id="staticBackdropLabel"><span class="fa fa-user-circle-o fa-2x"></span></h1>-->
                                          <div class="container text-center">
                                                 <img src="profile_pics/<%= user.getProfilePic()%>" class="img-fluid" style="border-radius: 50%; height: 120px; width: 120px;">
                                                 <h3 class="text-center"><%= user.getName()%></h3>
                                          </div>

                                   </div>
                                   <div class="modal-body">
                                          <div class="container text-center">

                                                 <div id="profile_details">
                                                        <table class="table">
                                                               <tbody>
                                                                      <tr>
                                                                             <th scope="row">ID</th>
                                                                             <td><%= user.getId()%></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">Email</th>
                                                                             <td><%= user.getEmail()%></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">Password</th>
                                                                             <td><%= user.getPassword()%></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">Registration date</th>
                                                                             <td><%= user.getRegistration_date().toLocaleString() %></td>
                                                                      </tr>
                                                               </tbody>
                                                        </table>
                                                 </div>
                                                 <div id="table_edit" style="display: none;">
                                                        <h5>Edit Details:</h5>
                                                        <form action="EditServlet" method="post" enctype="multipart/form-data">
                                                               <table class="table">
                                                                      <tr>
                                                                             <th scope="row">ID</th>
                                                                             <td><%= user.getId()%></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">Name</th>
                                                                             <td><input type="text" class="form-control" name="name" value="<%= user.getName()%>"></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">Email</th>
                                                                             <td><input type="email" class="form-control" name="email" value="<%= user.getEmail()%>"></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">Password</th>
                                                                             <td><input type="text" class="form-control" name="password" value="<%= user.getPassword()%>"></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">New profile picture: </th>
                                                                             <td><input type="file" class="form-control" name="new_profile_pic"></td>
                                                                      </tr>
                                                               </table>
                                                               <div class="container text-center">
                                                                      <button type="submit" id="save_button" class="btn btn-outline-primary" >Save</button>
                                                               </div>        
                                                        </form>
                                                 </div>                    
                                          </div>
                                   </div>
                                   <div class="modal-footer text-center">
                                          <button type="button" id="edit_button" class="btn btn-primary" >Edit</button>
                                          <button type="button" id="close_button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                   </div>
                            </div>
                     </div>
              </div>
              <!-- Edit-Details Modal ends-->

              <!-- Adding external js -->
              <script src="js/likeSystem.js" type="text/javascript"></script>
              <script src="js/commentSystem.js" type="text/javascript"></script>

              <!-- Script for editing profile -->
              <script>
                                                        $(document).ready(function () {
                                                               let editStatus = false;
                                                               $('#edit_button').click(function () {
                                                                      if (editStatus === false) {
                                                                             $("#profile_details").hide();
                                                                             $("#table_edit").show();
                                                                             $("#close_button").hide();
                                                                             editStatus = true;
                                                                             $(this).text("Back");
                                                                      } else {
                                                                             $("#profile_details").show();
                                                                             $("#table_edit").hide();
                                                                             $("#close_button").show();
                                                                             editStatus = false;
                                                                             $(this).text("Edit");
                                                                      }

                                                               });
                                                        });
              </script>

              <!--Script to check if the post is liked or not (every time page loads) -->
              <script>
                     document.addEventListener('DOMContentLoaded', function () {
                            checkIfLiked(<%= fullPost.getPid()%>, <%= user.getId()%>);
                     });
              </script>

              <!-- Script to display comment box -->
              <script>
                     $(document).ready(function () {
                            $.ajax({
                                   url: "load_comments.jsp",
                                   data: {pID: <%=postID%>},
                                   success: function (data, textStatus, jqXHR) {
                                          $('#comment_container').html(data);
                                   }
                            });
                     });
              </script>

       </body>
</html>
