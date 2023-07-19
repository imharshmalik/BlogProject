
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>Contact Me</title>
              <%@include file="bootstrap.jsp" %>
              <style>
                     body{
                            background: url(img/contact2.jpg);
                            background-size: 300px;
                            background-attachment: fixed;
                     }
              </style>

       </head>
       <body>
              <!--Nav bar-->
              <%@include file="navbar.jsp" %>

              <!--Banner starts-->
              <div class="container-fluid bg-primary-subtle p-4 m-0" style="-webkit-clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 64% 100%, 31% 92%, 0 100%, 0 0);">
                     <div class="jumbotron">
                            <div class="container text-center">
                                   <h2>Looks like you want to get in touch, huh!</h2>
                                   <br>
                                   <h5>Well, if you must...shoot me an email at</h5> 
                                   <h5 style="font-weight: bold;">imharshmalik@gmail.com</h5> 
                                   <h5>I don't take much time to reply. Looking forward to hearing from you.</h5> 
                                   <br>
                                   <h4 class="text-center" style="font-family: Cinzel Decorative">Your friend in time, Harsh</h4>
                            </div>
                     </div>
              </div>
              <!-- Banner ends-->

       </body>
</html>
