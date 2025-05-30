package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 * 1) Handles login (POST to /LoginServlet).
 * 2) For GET /LoginServlet, simply forward to Login.jsp.
 * 3) For GET /userprofile, check session and forward to profile.jsp if logged in, else redirect to Login.jsp.
 *
 * NOTE: All of your original login‐and‐redirect logic is untouched; we only added a new mapping and a branch in doGet().
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet", "/userprofile"})
public class LoginServlet extends HttpServlet {

    DAO dao = new DAO();

    /**
     * Processes requests for both HTTP GET (when mapped to /LoginServlet) and POST (login submission).
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
            // Store the User object into session so profile.jsp can read it later
            HttpSession session = request.getSession();
            session.setAttribute("user", u);
            System.out.println("User stored in session: " + session.getAttribute("user"));

            // Check role and redirect
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
     * Handles GET requests.
     *
     * - If the request URL is "/LoginServlet", just show the login form (Login.jsp).  
     * - If the request URL is "/userprofile", check session; if user is logged in, forward to profile.jsp. Otherwise redirect to Login.jsp.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String servletPath = request.getServletPath();

        if ("/userprofile".equals(servletPath)) {
            // --- PROFILE branch ---
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                // User is logged in → forward to profile.jsp
                request.getRequestDispatcher("profile.jsp").forward(request, response);
            } else {
                // No valid session/user → redirect to login
                response.sendRedirect(request.getContextPath() + "/Login.jsp");
            }

        } else {
            // --- LOGIN FORM branch ("/LoginServlet") ---
            // Show the login page
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }

    /**
     * Handles POST requests (form submission to /LoginServlet).
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "LoginServlet + Profile access control";
    }
}
