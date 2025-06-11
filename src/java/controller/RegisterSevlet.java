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
        response.setContentType("text/html;charset=UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");

        DAO d = new DAO();
        String errorMsg = null;

        // Validation
        if (password == null || !PASSWORD_PATTERN.matcher(password).matches()) {
            errorMsg = "Password phải bao gồm chữ cái in hoa, in thường, số, ký tự đặc biệt, không trùng lặp kề nhau.";
        } else if (!password.equals(confirmPassword)) {
            errorMsg = "Confirm Password không khớp.";
        } else if (email == null || !EMAIL_PATTERN.matcher(email).matches()) {
            errorMsg = "Email không đúng định dạng.";
        }

        if (errorMsg != null) {
            request.setAttribute("error", errorMsg);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Prepare
        String verificationCode = d.generatVerificationCode(); // implement this
        String subject = "Xác Minh Tài Khoản";
        String message = "Your verification code is: " + verificationCode;

        if (EmailUtil.sendEmail(email, subject, message)) {
            HttpSession session = request.getSession();
            session.setAttribute("verificationCode", verificationCode);
            session.setAttribute("username", username);
            session.setAttribute("password", password);
            session.setAttribute("email", email);
            session.setAttribute("verificationFor", "register");
            request.getRequestDispatcher("VerifyCode.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Không thể gửi email xác minh.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
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
