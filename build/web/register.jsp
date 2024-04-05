<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
       <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
              <title>Register</title>
              <%@include file="bootstrap.jsp" %>
       </head>
       <body>

              <!--Nav bar-->
              <%@include file="navbar.jsp" %>
              
              <!-- main part to display register box starts here -->
              <main class="d-flex align-items-center bg-primary-subtle" style="height: 89vh; -webkit-clip-path: polygon(50% 0% , 78% 0, 100% 0, 100% 100%, 80% 95%, 50% 100%, 20% 95%, 0 100%, 0 0, 26% 0);">
                     <div class="container" >
                            <div class="row-md-4">
                                   <div class="col-md-4 offset-md-4">
                                          <div class="card" style="outline-style: ridge;">
                                                 <div class="card-header text-center bg-dark text-white">
                                                        <span class="fa fa-user-plus fa-2x"></span>
                                                        <h3>Register new user</h3>
                                                 </div>
                                                 <div class="card-body">
                                                        <form id="reg_form" action="RegisterServlet" method="POST">
                                                               <div class="mb-3">
                                                                      <label for="inputUserName" class="form-label">Name</label>
                                                                      <input type="username" name="name" required class="form-control" id="inputUserName" placeholder="Enter your name" aria-describedby="userNameHelp">
                                                               </div>
                                                               <div class="mb-3">
                                                                      <label for="exampleInputEmail1" class="form-label">Email address</label>
                                                                      <input type="email" name="email" required class="form-control" id="exampleInputEmail1" placeholder="Enter your email address" aria-describedby="emailHelp">
                                                                      <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                                                               </div>
                                                               <div class="mb-3">
                                                                      <label for="exampleInputPassword1" class="form-label">Password</label>
                                                                      <input type="password" name="password" required class="form-control" placeholder="Enter your password" id="exampleInputPassword1">
                                                               </div>
                                                               </br>
                                                               <div class="mb-3 form-check">
                                                                      <input type="checkbox" required name="checkbox" class="form-check-input" id="exampleCheck1">
                                                                      <label class="form-check-label" for="exampleCheck1">Agree to Terms and Conditions</label>
                                                               </div>
                                                               <button type="submit" class="btn btn-primary" style="display:block; margin: auto;">Submit</button>
                                                        </form>
                                                 </div>
                                          </div>
                                   </div>
                            </div>
                     </div>
              </main>
              <!-- main part to display register box ends here -->
              
              
              <script>
                     $(document).ready(function () {                  
                            $('#reg_form').on('submit', function (event) {
                                   event.preventDefault();
                                   let form = new FormData(this);
                                  
                                   $.ajax({
                                          url: "RegisterServlet",
                                          type: "POST",
                                          data: form,
                                          processData: false,
                                          contentType: false,
                                          success: function (data, textStatus, jqXHR) {
                                                 if (data.trim() === 'added') {
                                                 swal("Success! New User Registered. Redirecting to login page")
                                                         .then((value) => {
                                                                window.location = "login.jsp";
                                                        });
                                                 }
                                                 else {                                            
                                                        swal("Something went wrong! Try again");
                                                 }
                                          }                  
                                   });
                            });
                     });
              </script>

       </body>
</html>
