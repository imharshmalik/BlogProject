function deletePost(postID) {
       swal({
              title: "Are you sure?",
              text: "This posts will be deleted",
              icon: "warning",
              buttons: true,
              dangerMode: true
       })
               .then((willDelete) => {
                      if (willDelete) {
                             $.ajax({
                                    url: "DeletePostServlet",
                                    data: {pid: postID},
                                    success: function (data, textStatus, jqXHR) {
                                           location.reload();
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                           alert("Something is wrong");
                                    }
                             });
                      } else {

                      }
               });
}

function deleteAllPosts(userID) {
       swal({
              title: "Are you sure?",
              text: "All your posts will be deleted",
              icon: "warning",
              buttons: true,
              dangerMode: true
       })
               .then((willDelete) => {
                      if (willDelete) {
                             $.ajax({
                                    url: "DeletePostServlet",
                                    data: {uid: userID},
                                    success: function (data, textStatus, jqXHR) {
                                           window.location = "my-home.jsp?userID=" + userID;
                                    },
                                    error: function (jqXHR, textStatus, errorThrown) {
                                           alert("Something is wrong");
                                    }
                             });
                      } else {

                      }
               });
}

