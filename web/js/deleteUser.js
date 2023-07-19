function deleteUser(userID) {
       swal({
              title: "Are you sure?",
              text: "Once deleted, you will not be able to recover your profile!",
              icon: "warning",
              buttons: true,
              dangerMode: true
       })
               .then((willDelete) => {
                      if (willDelete) {
                             $.ajax({
                                    url: "DeleteUserServlet",
                                    data: {userID: userID},
                                    success: function (data, textStatus, jqXHR) {
                                           window.location = "login.jsp";
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                           alert("Something is wrong");
                                    }
                             });
                      } else {
                             
                      }
               });

}

