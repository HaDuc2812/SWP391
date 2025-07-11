/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import static controller.RegisterSevlet.PASSWORD_PATTERN;
import dal.DAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.regex.Pattern;
import entity.User;

/**
 *
 * @author HA DUC
 */
public class UpdateUser extends HttpServlet {

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
            out.println("<title>Servlet UpdateUser</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateUser at " + request.getContextPath() + "</h1>");
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
    public static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]+$"
    );

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String name = request.getParameter("name");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String dob = request.getParameter("dob"); // Format should be yyyy-MM-dd

        DAO dao = new DAO();
        boolean updated = false;

        // Full Name
        if (name != null && !name.trim().isEmpty() && !name.trim().equals(user.getFullname())) {
            dao.updateUser(user.getUser_id(), "FullName", name.trim());
            user.setFullname(name.trim());
            updated = true;
        }

        // Phone Number
        if (phone != null && !phone.trim().isEmpty() && !phone.trim().equals(user.getPhonenumber())) {
            dao.updateUser(user.getUser_id(), "PhoneNumber", phone.trim());
            user.setPhonenumber(phone.trim());
            updated = true;
        }

        // Gender
        if (gender != null && !gender.trim().isEmpty() && !gender.trim().equals(user.getGender())) {
            dao.updateUser(user.getUser_id(), "Gender", gender.trim());
            user.setGender(gender.trim());
            updated = true;
        }

        // Address
        if (address != null && !address.trim().isEmpty() && !address.trim().equals(user.getAddress())) {
            dao.updateUser(user.getUser_id(), "Address", address.trim());
            user.setAddress(address.trim());
            updated = true;
        }

        // Date of Birth
        if (dob != null && !dob.trim().isEmpty()) {
            try {
                java.sql.Date parsedDob = java.sql.Date.valueOf(dob.trim());
                if (!parsedDob.equals(user.getDob())) {
                    dao.updateUser(user.getUser_id(), "DOB", parsedDob);
                    user.setDob(parsedDob);
                    updated = true;
                }
            } catch (IllegalArgumentException e) {
                request.setAttribute("mess", "Invalid date format for Date of Birth.");
                request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                return;
            }
        }

        // Password update logic remains unchanged
        boolean isAnyPasswordFieldFilled
                = (oldPassword != null && !oldPassword.isEmpty())
                || (newPassword != null && !newPassword.isEmpty())
                || (confirmPassword != null && !confirmPassword.isEmpty());

        if (isAnyPasswordFieldFilled) {
            if (oldPassword == null || newPassword == null || confirmPassword == null
                    || oldPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
                request.setAttribute("mess", "To change your password, please fill in all 3 fields.");
                request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                return;
            }

            if (!oldPassword.equals(user.getPassword())) {
                request.setAttribute("mess", "Old password is incorrect.");
                request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                return;
            }

            if (!PASSWORD_PATTERN.matcher(newPassword).matches()) {
                request.setAttribute("mess", "New password must include uppercase, lowercase, number, and special character.");
                request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                return;
            }

            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("mess", "New password and confirmation do not match.");
                request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                return;
            }

            dao.updateUser(user.getUser_id(), "Password", newPassword); // adjust column if named Password_hash
            user.setPassword(newPassword);
            updated = true;
        }

        if (updated) {
            session.setAttribute("user", user); // Refresh session data
            request.setAttribute("mess", "Your profile has been updated successfully.");
        } else {
            request.setAttribute("mess", "No changes were made.");
        }

        request.getRequestDispatcher("userprofile.jsp").forward(request, response);
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
