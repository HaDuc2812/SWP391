    package controller;

import dal.DAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import util.EmailUtil;
import dal.DAO;

@WebServlet("/resentcode")
public class ResendVerificationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // don't create a new session

        if (session == null ||
            session.getAttribute("email") == null ||
            session.getAttribute("username") == null ||
            session.getAttribute("password") == null) {

            // If session expired or incomplete, redirect back to register page
            request.setAttribute("error", "Phiên của bạn đã hết hạn. Vui lòng đăng ký lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        String email = (String) session.getAttribute("email");
        String username = (String) session.getAttribute("username");

        // Generate new verification code
        DAO dao = new DAO();
        String newCode = dao.generatVerificationCode();

        // Send new email
        String subject = "Mã xác minh mới cho tài khoản của bạn";
        String message = "Xin chào " + username + ",\n\nMã xác minh mới của bạn là: " + newCode;

        boolean emailSent = EmailUtil.sendEmail(email, subject, message);

        if (emailSent) {
            session.setAttribute("verificationCode", newCode);
            request.setAttribute("message", "Mã xác minh mới đã được gửi tới email của bạn.");
        } else {
            request.setAttribute("error", "Không thể gửi lại mã xác minh. Vui lòng thử lại.");
        }

        // Forward back to verification page
        request.getRequestDispatcher("VerifyForRegister.jsp").forward(request, response);
    }
}
