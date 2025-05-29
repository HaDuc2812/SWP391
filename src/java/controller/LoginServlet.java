/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import dal.DBContext;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import org.bouncycastle.crypto.generators.BCrypt;

/**
 *
 * @author HA DUC
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    DAO dao = new DAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User u = dao.login(username, password);
        if (u == null) {
            request.setAttribute("mess", "Wrong username or password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            //u = dao.checkAccountExists(username);
            HttpSession session = request.getSession();
            session.setAttribute("user", u);
            System.out.println("User stored in session: " + session.getAttribute("user"));
            //  Check role and redirect 
            String role = u.getRole();
            System.out.println("Logged in with role: " + role);

            if ("Administrator".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
            } else if ("InventoryManager".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/inventoryDashboard.jsp");
            } else if ("StoreManager".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/storeDashboard.jsp");
            } else if ("Customer".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/Homepage.jsp");
            } else {
                // fallback if an unexpected role is stored
                response.sendRedirect(request.getContextPath() + "/Homepage.jsp");
            }
        }
    }

        /**
         * Handles POST requests (form submission).
         */
        @Override
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Handles GET requests by showing the login page.
         */
        @Override
        protected void doGet
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            // Simply forward to the login form
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }

        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
