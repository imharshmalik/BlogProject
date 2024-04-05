
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true" %>
<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>Error</title>
               <%@include file="bootstrap.jsp" %>
       </head>
       <body>
              <div class="container text-center">
                     <img src="img/system.png" class="img-fluid mt-2" style="height: 400px;"/>
                     <h1 class="display-3">Something went wrong</h1>
                     <%=exception %>
                     <br>
                     <a href="index.jsp" class="btn btn-primary mt-3">Home</a>
              </div>
              
       </body>
</html>
