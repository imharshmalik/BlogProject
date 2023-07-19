<%@page import="com.blog.dao.CommentDAO"%>
<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.dao.UserDAO"%>
<%@page import="com.blog.dao.LikeDAO"%>
<%@page import="com.blog.dao.PostDAO"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="java.util.List"%>
<%@page import="com.blog.entities.Post"%>

<!-- To get likes and comments on the posts -->
 <%
       LikeDAO likeObject = new LikeDAO (ConnectionProvider.getConnection());
       CommentDAO commentObject = new CommentDAO(ConnectionProvider.getConnection());
 %>

<div class="row">
       <%
              Thread.sleep(100);
              PostDAO pdao = new PostDAO(ConnectionProvider.getConnection());
              List<Post> allPosts = null;
              int categoryID = Integer.parseInt(request.getParameter("cID"));
              if (categoryID == 0) {
                     allPosts = pdao.getAllPosts();
              } else {
                     allPosts = pdao.getPostsByCategoryID(categoryID);
              }
              if (allPosts.size() == 0) {
                     out.println("<h3 class='text-center mt-4'>No posts in this category yet.</h3>");
                     return;
              }
              for (Post p : allPosts) {
       %> 
       <div class="col-md-6 mb-4" >
              <div class="card" style="border: 2px solid;">
                     <img class="card-img-top" src="blog_pics/<%=p.getPpic()%>" style="height: 300px; ">
                     <div class="card-body">
                            <b> <%= p.getPtitle()%> </b>
                            <p style="height: 4em; overflow-y: hidden; text-align: justify"> <%= p.getPcontent()%> </p>
                     </div>
                     <div class="card-footer bg-dark text-center text-white">
                            <a href="#!"class="btn btn-dark btn-sm disabled"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"> <%= likeObject.countLikesOnAPost(p.getPid()) %> </span></a>
                            <a href="show_full_blog.jsp?postID=<%= p.getPid() %>" class="btn btn-dark btn-sm">Read more...</a>
                            <a href="#!" class="btn btn-dark btn-sm disabled"><i class="fa fa-commenting-o"></i> <span><%= commentObject.countCommentsOnAPost(p.getPid())%></span></a>
                     </div>
              </div>
       </div>
       <%
              }
       %>
</div>