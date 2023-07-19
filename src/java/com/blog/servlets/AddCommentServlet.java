
package com.blog.servlets;

import com.blog.dao.CommentDAO;
import com.blog.entities.Comment;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class AddCommentServlet extends HttpServlet {
       protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              response.setContentType("text/html;charset=UTF-8");
              try (PrintWriter out = response.getWriter()) {
                     String comment_content = request.getParameter("commentContent");
                     
                     HttpSession s = request.getSession();
                     User current_user = (User) s.getAttribute("currentUser");
                     int user_id = current_user.getId();
                     
                     int post_ID = Integer.parseInt(request.getParameter("postID"));
                      
                     CommentDAO cdao = new CommentDAO(ConnectionProvider.getConnection());
                     boolean ifCommentAdded = cdao.addComment(post_ID, user_id, comment_content);
                     
                     if(ifCommentAdded) {
                            out.println("<h3>done</h3>");
                            response.sendRedirect("show_full_blog.jsp?postID="+post_ID);
                     }
                     else {
                            System.out.println("<h3>Something went wrong</h3>");
                     }
                     
                     
                     
              }
       }

       // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
       /**
        * Handles the HTTP <code>GET</code>
        * method.
        *
        * @param request servlet request
        * @param response servlet response
        * @throws ServletException if a
        * servlet-specific error occurs
        * @throws IOException if an I/O error
        * occurs
        */
       @Override
       protected void doGet(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              processRequest(request, response);
       }

       /**
        * Handles the HTTP <code>POST</code>
        * method.
        *
        * @param request servlet request
        * @param response servlet response
        * @throws ServletException if a
        * servlet-specific error occurs
        * @throws IOException if an I/O error
        * occurs
        */
       @Override
       protected void doPost(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              processRequest(request, response);
       }

       /**
        * Returns a short description of the
        * servlet.
        *
        * @return a String containing servlet
        * description
        */
       @Override
       public String getServletInfo() {
              return "Short description";
       }// </editor-fold>

}
