package com.blog.servlets;

import com.blog.dao.UserDAO;
import com.blog.entities.Message;
import com.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeleteUserServlet extends HttpServlet {

       protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              response.setContentType("text/html;charset=UTF-8");
              try (PrintWriter out = response.getWriter()) {
                     UserDAO udao = new UserDAO(ConnectionProvider.getConnection());
                     int uid = Integer.parseInt(request.getParameter("userID"));
                     udao.deleteProfile(uid);
                     
                     HttpSession s = request.getSession();
                     s.removeAttribute("currentUser");
                     Message m = new Message("User deleted!", "danger", "alert-danger");
                     s.setAttribute("msg", m);
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
