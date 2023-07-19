
package com.blog.servlets;

import com.blog.dao.PostDAO;
import com.blog.entities.Post;
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
public class AddPostServlet extends HttpServlet {

       protected void processRequest(HttpServletRequest request, HttpServletResponse response)
                         throws ServletException, IOException {
              response.setContentType("text/html;charset=UTF-8");
              try (PrintWriter out = response.getWriter()) {
                     int cid = Integer.parseInt(request.getParameter("cid"));
                     String ptitle = request.getParameter("ptitle");
                     String pcontent = request.getParameter("pcontent");
                     Part part = request.getPart("ppic");
                     
                     HttpSession s = request.getSession();
                     User user = (User) s.getAttribute("currentUser");
                     
                     Post postObj = new Post (ptitle, pcontent, part.getSubmittedFileName(), null, cid, user.getId());
                     PostDAO pdao = new PostDAO(ConnectionProvider.getConnection());
                     boolean ifPostAdded = pdao.addNewPost(postObj);
                     if (ifPostAdded) {
                            String path = request.getRealPath("/") + "blog_pics" + File.separator + part.getSubmittedFileName();
                            Helper.savePicture(part.getInputStream(), path);
                            out.println("done");
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
