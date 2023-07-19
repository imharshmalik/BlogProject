<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>Home Page</title>
              <%@include file="bootstrap.jsp" %>
       </head>

       <body>
              <!--Nav bar-->
              <%@include file="navbar.jsp" %>

              <!--Banner starts-->
              <div class="container-fluid bg-primary-subtle p-4 m-0" style="-webkit-clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 64% 100%, 31% 92%, 0 100%, 0 0);">
                     <div class="jumbotron">
                            <div class="container">
                                   <h1 class="display-3">Welcome,</h1>
                                   <h4 class="display-8">This is a Blog Project I created using Servlets and JSP with MySQL database. I plan on making a simple web application with this.</h4>
                                   <br>
                                   <a href="login.jsp" class="btn btn-primary btn-lg" style="display:block; margin: auto; width: 180px;"> <span class="fa fa-refresh fa-spin"></span> Start</a>
                            </div>
                     </div>
              </div>
              <!--Banner ends-->
              
              <br/>
              
              <!--Cards start-->
              <div class="container">
                     <div class="row">
                            <div class="col-md-4">
                                   <div class="card text-white bg-dark" style="border-radius: 50px;">                  
                                          <div class="card-body">
                                                 <h5 class="card-title text-center" style="text-decoration: underline;">Servlet</h5>
                                                 <p class="card-text" style="text-align: justify">Imagine you have a website, and you want it to do some special things when someone visits it. A servlet is like a superhero that helps your website do those special things. It's a program that runs on a web server and responds to requests from web browsers. It can do tasks like taking data from a form, saving it, and showing it on a webpage.</p>
                                                 <a href="https://www.javatpoint.com/servlet-tutorial" class="btn btn-primary" style="display:block; margin: auto; width: 130px;">Read more</a>
                                          </div>
                                   </div
                            </div>
                     </div>
                     <div class="col-md-4">
                            <div class="card text-white bg-dark"  style="border-radius: 50px;">                  
                                   <div class="card-body">
                                          <h5 class="card-title text-center" style="text-decoration: underline;">JSP (JavaServer Pages)</h5>
                                          <p class="card-text" style="text-align: justify">JSP is like a special type of web page that uses Java programming language. It's a way to make your web pages more dynamic and interactive. With JSP, you can mix regular HTML code with special Java code that can do things like calculating numbers, showing different content based on user input, or connecting to a database.</p>
                                          <a href="https://www.javatpoint.com/jsp-tutorial" class="btn btn-primary" style="display:block; margin: auto; width: 130px;">Read more</a>
                                   </div>
                            </div
                     </div>
              </div>
              <div class="col-md-4">
                     <div class="card text-white bg-dark"  style="border-radius: 50px;">                  
                            <div class="card-body">
                                   <h5 class="card-title text-center" style="text-decoration: underline;">MySQL database</h5>
                                   <p class="card-text" style="text-align: justify">It's like a virtual storage space where you can put lots of data. MySQL is a specific type of database that is very popular and commonly used. It's like a big filing cabinet where you can store information in tables. Each table is like a separate sheet in the cabinet, and each row in the table is like a different piece of information.</p>
                                   <a href="https://www.javatpoint.com/mysql-tutorial" class="btn btn-primary" style="display:block; margin: auto; width: 130px;">Read more</a>
                            </div>
                     </div>
              </div>
       </div>
<br>
</div>
              <!--Cards end-->

</body>
</html>
