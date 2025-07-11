package controller;

import dal.DAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import entity.Accounts;
import entity.User;

/**
 * 1) Handles login (POST to /LoginServlet). 2) For GET /LoginServlet, simply
 * forward to Login.jsp. 3) For GET /userprofile, check session and forward to
 * profile.jsp if logged in, else redirect to Login.jsp.
 *
 * NOTE: All of your original login‐and‐redirect logic is untouched; we only
 * added a new mapping and a branch in doGet().
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet", "/userprofile"})
public class LoginServlet extends HttpServlet {

    DAO dao = new DAO();

    /**
     * Processes requests for both HTTP GET (when mapped to /LoginServlet) and
     * POST (login submission).
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        DAO dao = new DAO(); // Make sure DAO is instantiated
        Accounts acc = dao.login(username, password); // Assumes DAO.login returns Accounts

        if (acc == null) {
            request.setAttribute("mess", "Wrong username or password");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        } else {
            // Store the Accounts object in session
            HttpSession session = request.getSession();
            session.setAttribute("account", acc);
            User fullUser = dao.getUserById(acc.getUsersId());
            session.setAttribute("user", fullUser);
            System.out.println("Full user: " + fullUser);

            // Also store role if you plan to check it in JSP
            session.setAttribute("role", acc.getRole());

            System.out.println("Account stored in session: " + acc.getEmail());
            System.out.println("Logged in with role: " + acc.getRole());

            // Redirect based on role
            String role = acc.getRole();
            if ("Administrator".equalsIgnoreCase(role)) {
                response.sendRedirect("adminDashboard.jsp");
            } else if ("InventoryManager".equalsIgnoreCase(role)) {
                response.sendRedirect("inventoryDashboard.jsp");
            } else if ("StoreManager".equalsIgnoreCase(role)) {
                response.sendRedirect("storeDashboard.jsp");
            } else if ("Customer".equalsIgnoreCase(role)) {
                response.sendRedirect("Homepage.jsp");
            } else {
                response.sendRedirect("Homepage.jsp"); // fallback
            }
        }
    }

    /**
     * Handles GET requests.
     *
     * - If the request URL is "/LoginServlet", just show the login form
     * (Login.jsp). - If the request URL is "/userprofile", check session; if
     * user is logged in, forward to profile.jsp. Otherwise redirect to
     * Login.jsp.
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
