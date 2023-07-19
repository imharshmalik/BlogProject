<%@page import="java.util.List"%>
<%@page import="com.blog.dao.CommentDAO"%>
<%@page import="com.blog.dao.LikeDAO"%>
<%@page import="com.blog.entities.Post"%>
<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.dao.UserDAO"%>
<%@page import="com.blog.dao.PostDAO"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>

<!-- To check active session -->
<%
       User user = (User) session.getAttribute("currentUser");
       if (user == null) {
              response.sendRedirect("login.jsp");
       }
%>

<!-- To get user object -->
<%
       UserDAO udao = new UserDAO(ConnectionProvider.getConnection());
       int userID = Integer.parseInt(request.getParameter("userID"));
       User userForCurrentPage = udao.getUserByUserID(userID);
%>

<!-- To get post object -->
<%
       PostDAO pdao = new PostDAO(ConnectionProvider.getConnection());
       List<Post> allPostsByThisUser = pdao.getPostsByUserID(userID);
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
              <title><%= userForCurrentPage.getName()%></title>
              <%@include file="bootstrap.jsp" %>
              <style>
                     body{
                            background: url(img/pexels-pixabay-235985.jpg);
                            background-size: cover;
                            background-attachment: fixed;
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
                                                                             <td><%= user.getRegistration_date().toLocaleString()%></td>
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

              <!-- Main body to display user's details starts here -->
              <div class="container-fluid">
                     <div class="row my-4">
                            <div class="col-md-6 offset-md-3">
                                   <div class="card" style="border-radius: 20px;">
                                          <div class="card-header text-center bg-dark text-white" style="border-radius: 10px;">
                                                 <h3>Your profile, <%= userForCurrentPage.getName()%></h3>
                                          </div>
                                          <div class="card-body">
                                                 <div class="container-fluid text-center">
                                                        <img src="profile_pics/<%= userForCurrentPage.getProfilePic()%>" class="img-fluid" style="border-radius: 50%; height: 220px; width: 220px;">
                                                        <br>
                                                        <br>
                                                        <table class="table table-borderless table-striped-columns">
                                                               <tbody>
                                                                      <tr>
                                                                             <th scope="row">Your User ID</th>
                                                                             <td><%= userForCurrentPage.getId()%></td> 
                                                                      </tr>                                                   
                                                                      <tr>
                                                                             <th scope="row">Your Email</th>
                                                                             <td><%= userForCurrentPage.getEmail()%></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">Your Password</th>
                                                                             <td><%= userForCurrentPage.getPassword()%></td>
                                                                      </tr>
                                                                      <tr>
                                                                             <th scope="row">You're a user since</th>
                                                                             <td><%= userForCurrentPage.getRegistration_date().toLocaleString()%></td>
                                                                      </tr>
                                                               </tbody>
                                                        </table>
                                                 </div>
                                          </div>
                                   </div>
                            </div>
                     </div>
              </div>
              <!-- Main body to display user's details ends here -->

              <!--Main body to display user's posts starts here-->
              <div class="container-fluid">
                     <div class="row my-4">
                            <div class="col-md-8 offset-md-2">
                                   <div class="card">
                                          <div class="card-header text-center bg-dark text-white">
                                                 <h3>All posts made by you:</h3>
                                          </div>
                                          <%
                                                 if (allPostsByThisUser.size() == 0) {
                                          %>
                                          <h3 class="text-center">No posts found</h3>
                                          <div class="container text-center" style="padding-bottom: 10px; padding-top: 10px;">
                                                 <button type="button" onclick="deleteUser(<%=user.getId()%>)" class="btn btn-danger btn-lg">DELETE YOUR PROFILE</button>
                                          </div>
                                          <%
                                          } else {
                                                 for (Post p : allPostsByThisUser) {
                                          %> 
                                          <div class="col-md-8 offset-2 mt-4" style="border: 2px solid;">
                                                 <div class="card">
                                                        <img class="card-img-top img-fluid" style="height: 400px; display: flex; justify-content: center; align-items: center;" src="blog_pics/<%=p.getPpic()%>" style="height: 300px; ">
                                                        <div class="card-body">
                                                               <p style="font-size: 22px; font-weight: bold;"> <%= p.getPtitle()%> </p>
                                                               <p style="height: 4em; overflow-y: hidden;"> <%= p.getPcontent()%> </p>
                                                        </div>
                                                        <div class="card-footer bg-dark text-center text-white">
                                                               <a href="show_full_blog.jsp?postID=<%= p.getPid()%>" class="btn btn-dark btn-sm">Read more...</a>
                                                               <a href="#!"class="btn btn-dark btn-sm disabled"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"> <%= likeObject.countLikesOnAPost(p.getPid())%> </span></a>
                                                               <a href="#!" class="btn btn-dark btn-sm disabled"><i class="fa fa-commenting-o"></i> <span><%= commentObject.countCommentsOnAPost(p.getPid())%></span></a>
                                                               <a href="#!" onclick="deletePost(<%= p.getPid()%>)" class="btn btn-danger btn-sm"><i class="fa fa-trash-o"></i> Delete Post</a>
                                                        </div>
                                                 </div>                                                     
                                          </div>
                                          <hr style="color: black; background-color: transparent; height: 5px;">
                                          <%
                                                 }
                                          %>                                      
                                          <div class="container text-center" style="padding-bottom: 10px; padding-top: 10px;">
                                                 <button type="button" onclick="deleteAllPosts(<%=user.getId()%>)" class="btn btn-warning btn-lg"><span class="fa fa-trash-o"></span> Delete all posts made by you</button>
                                                 <button type="button" onclick="deleteUser(<%=user.getId()%>)" class="btn btn-danger btn-lg"><span class="fa fa-remove"></span> DELETE YOUR PROFILE</button>
                                          </div>
                                          <%
                                                 }
                                          %> 

                                   </div>
                            </div>
                     </div>
              </div>
              <!--Main body to display user's posts ends here-->

        
              <!-- External Scripts -->
              <script src="js/deleteUser.js" type="text/javascript"></script>
              <script src="js/deletePost.js" type="text/javascript"></script>
             
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
       </body>
</html>
