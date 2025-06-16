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
import model.User;

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

        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            request.setAttribute("mess", "Session expired. Please login again.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
            return;
        }

        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        DAO dao = new DAO();
        boolean updated = false;

        // Name
        if (name != null && !name.trim().isEmpty()) {
            dao.updateUser(user.getUser_id(), "name", name.trim());
            user.setUsername(name.trim());
            updated = true;
        }

        // Phone
        if (phone != null && !phone.trim().isEmpty()) {
            dao.updateUser(user.getUser_id(), "phone", phone.trim());
            user.setPhone(phone.trim());
            updated = true;
        }

        // Address
        if (address != null && !address.trim().isEmpty()) {
            dao.updateUser(user.getUser_id(), "address", address.trim());
            user.setAddress(address.trim());
            updated = true;
        }

        // Password validation with your predefined regex
        if (password != null && !password.trim().isEmpty()) {
            if (!PASSWORD_PATTERN.matcher(password).matches()) {
                request.setAttribute("mess", "Password must contain at least one lowercase letter, one uppercase letter, one number, and one special character (@$!%*?&).");
                request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                return;
            } else if (!password.equals(confirmPassword)) {
                request.setAttribute("mess", "Confirm password does not match.");
                request.getRequestDispatcher("userprofile.jsp").forward(request, response);
                return;
            } else {
                dao.updateUser(user.getUser_id(), "password", password);
                user.setPassword_hash(password);
                updated = true;
            }
        }

        if (updated) {
            request.setAttribute("mess", "Profile updated successfully.");
        } else {
            request.setAttribute("mess", "No changes were made.");
        }

        session.setAttribute("user", user); // Refresh session info
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
