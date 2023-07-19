
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>About Me</title>  
               <%@include file="bootstrap.jsp" %>
       </head>
       <body>
              <!--Nav bar-->
              <%@include file="navbar.jsp" %>

              <!--Banner starts-->
              <div class="container-fluid bg-primary-subtle p-4 m-0" style="-webkit-clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 64% 100%, 31% 92%, 0 100%, 0 0);">
                     <div class="jumbotron">
                            <div class="container">
                                   <h1 class="display-3 text-center">Hello World,</h1>
                                   <br>
                                   <h5>This is a me, Harsh. I like coding in Java. Although it has a lot of boilerplate code, but it somehow feels like home. In my spare time, I like to watch and read about a lot of new stuff.</h5> 
                                   <h5>Sometimes, I watch movies and listen to music. I have a lot of friends and I love all of them.</h5> 
                                   <br>
                                   <h4 class="text-center" style="font-family: Cinzel Decorative">Thanks for checking out my web application. Adios!</h4>
                            </div>
                     </div>
              </div>
              <!--Banner ends-->
              
              <div class="container text-center" style="padding-top: 20px;">
                     <img src="img/about-me.jpg" class="img-fluid" style="border-radius: 40%; height: 420px; width: 420px;">
              </div>
                            
       </body>
</html>
