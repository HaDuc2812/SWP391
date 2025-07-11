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
import java.time.LocalDate;
import java.util.regex.Pattern;
import util.EmailUtil;

/**
 *
 * @author HA DUC
 */
public class RegisterSevlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]+$"
    );

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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

    // Get all parameters from form
    String fullName = request.getParameter("fullName");
    String email = request.getParameter("email");
    String phoneNumber = request.getParameter("phoneNumber");
    String password = request.getParameter("password");
    String confirmPassword = request.getParameter("confirmPassword");
    String address = request.getParameter("address");
    String dobStr = request.getParameter("dob");
    String gender = request.getParameter("gender");
    String roleFromForm = request.getParameter("role"); // Default "Customer" from form

    // Check for password mismatch
    if (!password.equals(confirmPassword)) {
        request.setAttribute("error", "Passwords do not match.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
        return;
    }

    // Parse date of birth
    Date dob;
    try {
        dob = Date.valueOf(LocalDate.parse(dobStr));
    } catch (Exception e) {
        request.setAttribute("error", "Invalid date of birth format.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
        return;
    }

    DAO dao = new DAO();

    // Check for duplicate email or phone number
    if (dao.isEmailRegistered(email)) {
        request.setAttribute("error", "Email is already registered.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
        return;
    }
    if (dao.isPhoneRegistered(phoneNumber)) {
        request.setAttribute("error", "Phone number is already registered.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
        return;
    }

    // Assign "Administrator" to first user
    String role = dao.countUsers() == 0 ? "Administrator" : "employees";

    // Call DAO to register
    boolean success = dao.register(fullName, email, phoneNumber, password, gender, role, address, dob);

    if (success) {
        response.sendRedirect("Login.jsp");
    } else {
        request.setAttribute("error", "Registration failed. Please try again.");
        request.getRequestDispatcher("register.jsp").forward(request, response);
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
