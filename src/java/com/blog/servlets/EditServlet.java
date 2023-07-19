
package com.blog.servlets;

import com.blog.dao.UserDAO;
import com.blog.entities.Message;
import com.blog.entities.User;
import com.blog.helper.ConnectionProvider;
import com.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

       protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              response.setContentType("text/html;charset=UTF-8");
              try (PrintWriter out = response.getWriter()) {
                     /* TODO output your page here. You may use following sample code. */
                     String updatedName = request.getParameter("name");
                     String updatedEmail = request.getParameter("email");
                     String updatedPassword = request.getParameter("password");
                     Part part = request.getPart("new_profile_pic");
                     String newProfilePicName = part.getSubmittedFileName();

                     HttpSession s = request.getSession();
                     User user = (User) s.getAttribute("currentUser");
                     user.setName(updatedName);
                     user.setEmail(updatedEmail);
                     user.setPassword(updatedPassword);
                     user.setProfilePic(newProfilePicName);

                     UserDAO userdao = new UserDAO(ConnectionProvider.getConnection());
                     boolean ifUpdated = userdao.updateUserDetails(user);
                     if (ifUpdated) {
                            String path = request.getRealPath("/") + "profile_pics" + File.separator + user.getProfilePic();
                            Helper.deleteFile(path);
                            if (Helper.savePicture(part.getInputStream(), path)) {
                                   Message m = new Message("Details updated successfully", "success", "alert-success");
                                   s.setAttribute("msg", m);
                            }

                     } else {
                            Message m = new Message("Something went wrong! Try again", "error", "alert-danger");
                            s.setAttribute("msg", m);
                     }
                     response.sendRedirect("profile.jsp");
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
