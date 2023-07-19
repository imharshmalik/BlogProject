<%@page import="com.blog.entities.Message"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>Login</title>
              <%@include file="bootstrap.jsp" %>
       </head>
       <body>
              
              <!--Nav bar-->
              <%@include file="navbar.jsp" %>
              
              <!-- main part to display logon box starts here -->
              <main class="d-flex align-items-center bg-primary-subtle" style="-webkit-clip-path: polygon(50% 0%, 78% 0, 100% 0, 100% 100%, 80% 95%, 50% 100%, 20% 95%, 0 100%, 0 0, 26% 0); height: 80vh; ">
                     <div class="container" >
                            <div class="row">
                                   <div class="col-md-4 offset-md-4">
                                          <div class="card"style="outline-style: ridge;">
                                                 <div class="card-header text-center bg-dark text-white">
                                                        <span class="fa fa-user-circle fa-2x"></span>
                                                        <h3>Login</h3>
                                                 </div>
                                                 
                                                 <% 
                                                         Message m = (Message) session.getAttribute("msg");
                                                         if (m != null) {
                                                  %>
                                                  <div class="alert <%= m.getCssclass() %>" role="alert">
                                                         <%= m.getContent() %>
                                                  </div>
                                                  <%
                                                          session.removeAttribute("msg");
                                                        }           
                                                   %>
                                                 
                                                 <div class="card-body">
                                                        <form action="LoginServlet" method="post">
                                                               <div class="mb-3">
                                                                      <label for="exampleInputEmail1" class="form-label">Email address</label>
                                                                      <input type="email" name="email" required class="form-control" id="exampleInputEmail1" placeholder="Enter your email address" aria-describedby="emailHelp">
                                                               </div>
                                                               <div class="mb-3">
                                                                      <label for="exampleInputPassword1" class="form-label">Password</label>
                                                                      <input type="password" name="password" required class="form-control" placeholder="Enter your password" id="exampleInputPassword1">
                                                               </div>
                                                               <br/>
                                                               <button type="submit" class="btn btn-primary" style="display:block; margin: auto;">Submit</button>
                                                        </form>
                                                 </div>
                                          </div>
                                          </br>
                                          <h5 class="text-center">New user? <a href="register.jsp">Register here</a></h5>
                                   </div>
                            </div>
                     </div>
              </main>
              <!-- main part to display logon box ends here -->
                                                   
       </body>
</html>
