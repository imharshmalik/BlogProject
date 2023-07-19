<%@page import="com.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blog.entities.Category"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDAO"%>
<%@page import="com.blog.entities.Message"%>
<%@page import="com.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
       User user = (User) session.getAttribute("currentUser");
       if (user == null) {
              response.sendRedirect("login.jsp");
       }
%>

<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>Profile</title>
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
                                                 <a class="nav-link" href="about.jsp"> <span class="fa fa-book"></span> About</a>
                                          </li>
                                          <li class="nav-item">
                                                 <a class="nav-link" href="contact.jsp"><span class="fa fa-envelope-open-o"></span> Contact</a>
                                          </li>
                                   </ul>
                                   <ul class="navbar-nav mr-right">
                                          <form action="SearchPostServlet" method="post" class="d-flex" role="search">
                                                 <input class="form-control me-2" name="search_string" type="search" placeholder="Search" aria-label="Search">
                                                 <button class="btn btn-outline-light me-3" type="submit">Search</button>
                                          </form>
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

              <!--Welcome banner starts here -->
              <div class="container-fluid bg-primary-subtle p-4 m-0 text-center" style="-webkit-clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 79%, 64% 100%, 30% 78%, 0 100%, 0 0);">
                     <h3 class="display-3">Welcome, <a href="my-home.jsp?userID=<%= user.getId() %>"><%=user.getName()%></a></h3>
                     <br/>
                     <a href="#" class="btn btn-outline-dark btn-lg" data-bs-toggle="modal" data-bs-target="#postModal">Post Something <span class="fa fa-pencil"></span></a>
                     <br>
                     <br>
              </div>
              <!--Welcome banner ends here -->

              <%
                     Message m = (Message) session.getAttribute("msg");
                     if (m != null) {
              %>
              <div class="alert text-center <%= m.getCssclass()%>" role="alert">
                     <%= m.getContent()%>
              </div>
              <%
                            session.removeAttribute("msg");
                     }
              %>

              <!-- Main body for displaying categories and posts starts here-->
              <main>
                     <div class="container">
                            <div class="row mt-3">
                                   <div class="col-md-4" >
                                          <div class="list-group" style="border: 2px solid;">
                                                 <a href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action active" aria-current="true">All Posts</a>
                                                 <%
                                                        PostDAO pdao = new PostDAO(ConnectionProvider.getConnection());
                                                        ArrayList<Category> categoryList = pdao.getAllCategories();
                                                        for (Category c : categoryList) {
                                                 %>
                                                 <a href="#" onclick="getPosts(<%=c.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%= c.getCname() %></a>
                                                 <%
                                                         }
                                                  %>
                                          </div>
                                   </div>
                                   <div class="col-md-8">
                                          <div class="container text-center" id="loader">
                                                 <i class="fa fa-refresh fa-2x fa-spin"></i>
                                                 <h4 class="mt-2">Loading...</h4>
                                          </div>
                                          <div class="container-fluid" id="post_container">
                                                 
                                          </div>
                                   </div>
                            </div>
                     </div>
              </main>
              <!-- Main body for displaying categories and posts ends here-->

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

              <!-- Add-Post Modal starts-->
              <div class="modal fade" id="postModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                     <div class="modal-dialog">
                            <div class="modal-content">
                                   <div class="modal-header  bg-dark text-white">
                                          <h2 class="modal-title" style="display:block; margin: auto;" id="staticBackdropLabel"><span class="fa fa-plus-square-o-2x"></span> Create new post</h2>
                                   </div>
                                   <div class="modal-body">
                                          <form id="addPostForm" action="AddPostServlet" method="post">
                                                 <div class="form-group">
                                                        <select class="form-control" name="cid" required>
                                                               <option selected disabled>---Choose category---</option>
                                                               <%                                                                     
                                                                      for (Category c : categoryList) {
                                                               %>   
                                                               <option value="<%= c.getCid()%>"><%= c.getCname()%></option>
                                                               <%
                                                                      }
                                                               %>

                                                        </select>
                                                 </div>
                                                 <br>
                                                 <div class="form-group">
                                                        <input type="text" name="ptitle" placeholder="Enter post title" class="form-control" required/>
                                                 </div>
                                                 <br>
                                                 <div class="form-group">
                                                        <textarea name="pcontent" placeholder="Say something..." class="form-control" style="height: 200px;"></textarea>
                                                 </div>
                                                 <br>
                                                 <div class="form-group">
                                                        <%="Add picture:"%>
                                                        <input type="file" name="ppic"/>
                                                 </div>
                                                 <br>
                                                 <div class="text-center">
                                                        <button type="submit" id="post_button" class="btn btn-outline-primary" >Post</button>
                                                        <button type="button" id="cancel_post_button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                 </div>      
                                          </form>
                                   </div>
                            </div>
                     </div>
              </div>
              <!-- Add-Post Modal ends-->

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

              <!-- Script for adding new post -->
              <script>
                     $(document).ready(function (e) {
                            $("#addPostForm").on("submit", function (event) {
                                   event.preventDefault();
                                   let form = new FormData(this);
                                   $.ajax({
                                          url: "AddPostServlet",
                                          type: "POST",
                                          data: form,
                                          processData: false,
                                          contentType: false,
                                          success: function (data, textStatus, jqXHR) {
                                                 if (data.trim() === 'done') {
                                                        swal("Great!", "New Post Added!", "success")
                                                                .then((value) => {
                                                                       window.location = "profile.jsp";
                                                                });
                                                 } else {
                                                        swal("Oops!", "Something Went Wrong!", "error");
                                                 }
                                          }
                                   });
                            });
                     });
              </script>
                        
              <!-- Script to display posts -->
              <script>
                     function getPosts (catID, temp) {
                            $('#loader').show();
                            $('#post_container').hide();
                            $(".c-link").removeClass("active");
                            
                            $.ajax ({
                                   url: "load_posts.jsp",
                                   data: {cID: catID},
                                   success: function (data, textStatus, jqXHR) {
                                          $('#loader').hide();
                                          $('#post_container').show();
                                          $('#post_container').html(data);
                                          $(temp).addClass("active");
                                   }
                            });
                     }
                     
                     $(document).ready(function (e) {
                            let allPostsReference = $(".c-link")[0];
                            getPosts(0, allPostsReference);
                     });
              </script>

       </body>
</html>
