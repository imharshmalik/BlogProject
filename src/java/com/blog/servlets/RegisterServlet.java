
package com.blog.servlets;

import com.blog.dao.UserDAO;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

     
       protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
              response.setContentType("text/html;charset=UTF-8");
              try (PrintWriter out = response.getWriter()) {
                     String checkbox = request.getParameter("checkbox");
                     if (checkbox == null) {
                            out.println("<h3>Agree to the terms and conditions first</h3>");
                     }
                     else {
                            String name = request.getParameter("name");
                            String email = request.getParameter("email");
                            String password = request.getParameter("password");
                            
                            User user = new User (name, email, password);
                            
                            UserDAO userdao = new UserDAO (ConnectionProvider.getConnection());
                            boolean ifUserAdded = userdao.addNewUser(user);
                            if (ifUserAdded == true) {
                                   out.println("added");
                            }
                     }
                     
              }
       }

       @Override
       protected void doGet(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              processRequest(request, response);
       }

       @Override
       protected void doPost(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              processRequest(request, response);
       }

       @Override
       public String getServletInfo() {
              return "Short description";
       }

}
