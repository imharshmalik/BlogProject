package com.blog.servlets;

import com.blog.dao.UserDAO;
import com.blog.entities.Message;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

       protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
              response.setContentType("text/html;charset=UTF-8");
              try (PrintWriter out = response.getWriter()) {
                     
                    String userEmail = request.getParameter("email");
                    String userPassword = request.getParameter("password");
                    
                     UserDAO dao = new UserDAO (ConnectionProvider.getConnection());
                     User userDetails = dao.getUserByEmailAndPassword(userEmail, userPassword);
                     
                     if (userDetails == null) {
                            //out.println("Invalid details");
                            Message m = new Message("Invalid details! Try again", "error", "alert-danger");
                            HttpSession s = request.getSession();
                            s.setAttribute("msg", m);
                            response.sendRedirect("login.jsp");
                     }
                     else {
                            HttpSession s = request.getSession();
                            s.setAttribute("currentUser", userDetails);
                            response.sendRedirect("profile.jsp");
                     }
              }
       }

       // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
       /**
        * Handles the HTTP <code>GET</code> method.
        *
        * @param request servlet request
        * @param response servlet response
        * @throws ServletException if a servlet-specific error occurs
        * @throws IOException if an I/O error occurs
        */
       @Override
       protected void doGet(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              processRequest(request, response);
       }

       /**
        * Handles the HTTP <code>POST</code> method.
        *
        * @param request servlet request
        * @param response servlet response
        * @throws ServletException if a servlet-specific error occurs
        * @throws IOException if an I/O error occurs
        */
       @Override
       protected void doPost(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              processRequest(request, response);
       }

       /**
        * Returns a short description of the servlet.
        *
        * @return a String containing servlet description
        */
       @Override
       public String getServletInfo() {
              return "Short description";
       }// </editor-fold>

}
