function doLike(postID, userID) {
       const d = {
              pid: postID,
              uid: userID,
              operation: "like"
       };

       $.ajax({
              url: "LikeServlet",
              data: d,
              success: function (data, textStatus, jqXHR) {
                     let counter = parseInt($(".like-counter").html());
                     if (data.trim() === 'true') {
                            $(".like-counter").html(++counter);
                            $("#like_button").addClass('highlight');
                     } else {
                            $(".like-counter").html(--counter);
                            $("#like_button").removeClass('highlight');
                     }
              },
              error: function (jqXHR, textStatus, errorThrown) {
                     alert("Something is wrong");
              }
       });
}

function checkIfLiked(postID, userID) {
       const d = {
              pid: postID,
              uid: userID,
              operation: "checkLike"
       };

       $.ajax({
              url: "LikeServlet",
              data: d,
              success: function (data, textStatus, jqXHR) {
                     if (data.trim() === 'true') {
                            $("#like_button").addClass('highlight');
                     } 
                     else {
                            $("#like_button").removeClass('highlight');
                     }
              },
              error: function (jqXHR, textStatus, errorThrown) {
                     alert("Something is wrong");
              }
       });
}

