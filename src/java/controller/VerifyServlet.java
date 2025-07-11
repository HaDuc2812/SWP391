/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;

/**
 *
 * @author HA DUC
 */
public class VerifyServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerifyServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        String realCode = (String) session.getAttribute("verificationCode");
        String verificationFor = (String) session.getAttribute("verificationFor");

        if (realCode != null && realCode.equals(code)) {
            DAO dao = new DAO();

            if ("register".equals(verificationFor)) {
                // Retrieve user details from session
                String fullName = (String) session.getAttribute("fullName");
                String email = (String) session.getAttribute("email");
                String phoneNumber = (String) session.getAttribute("phoneNumber");
                String password = (String) session.getAttribute("password");
                String address = (String) session.getAttribute("address");
                String gender = (String) session.getAttribute("gender");
                String role = dao.countUsers() == 0 ? "Administrator" : "Employees";
                Date dob = (Date) session.getAttribute("dob");

                // Register the user
                dao.register(fullName, email, phoneNumber, password, gender, role, address, dob);

                // Clear session and redirect to login
                session.invalidate();
                response.sendRedirect("Login.jsp");

            } else if ("reset".equals(verificationFor)) {
                response.sendRedirect("resetPassword.jsp");
            }

        } else {
            request.setAttribute("error", "Verification code incorrect");
            request.getRequestDispatcher("VerifyCode.jsp").forward(request, response);
        }
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
