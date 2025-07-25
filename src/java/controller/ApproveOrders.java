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
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderItem;

/**
 *
 * @author HA DUC
 */
public class ApproveOrders extends HttpServlet {

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
            out.println("<title>Servlet ApproveOrders</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ApproveOrders at " + request.getContextPath() + "</h1>");
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
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        DAO dao = new DAO();
        boolean canApprove = true;
        List<OrderItem> orderItems = dao.getOderItemsByOrderId(orderId);
        List<String> insufficientProducts = new ArrayList<>();
        
        HttpSession session = request.getSession(); // ✅ For message persistence
        String status = dao.getOrderStatus(orderId); // you need this method

        if ("shipped".equalsIgnoreCase(status)) {

            session.setAttribute("error", "Order has already been shipped and cannot be approved again.");
            response.sendRedirect("orderDetail?order_id=" + orderId);
            return;
        }

        try {
            // check stock availability
            for (OrderItem item : orderItems) {
                int comboId = item.getGood_id();
                int orderedQty = item.getQuantity();
                int availbileQty = dao.getFurnitureStockBYId(comboId);

                if (availbileQty < orderedQty) {
                    canApprove = false;
                    String productName = dao.getFurnitureNameById(comboId);
                    insufficientProducts.add(productName + "(need: "+ orderedQty+ ", Instock: "+ availbileQty + ")");
                    break;
                }
            }

            if (canApprove) {
                // deduct stock and mark order as approved
                for (OrderItem item : orderItems) {
                    int comboId = item.getGood_id();
                    int orderedQty = item.getQuantity();
                    dao.deductFurnitureStocks(comboId, orderedQty);
                }
                dao.updateOrderStatus(orderId, "Shipped"); // update order to be shipped out
                session.setAttribute("message", "Order will be shipped out soon"); // ✅ session message
            } else {
                session.setAttribute("message", "Cannot approve: insufficient stocks"); // ✅
                session.setAttribute("insufficientProducts", insufficientProducts);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("message", "An error occurred while approving order"); // ✅ fix typo and use session
        }
        session.setAttribute("orderApprovalResult", session.getAttribute("message"));
        response.sendRedirect("orderApprovalResult.jsp?order_id=" + orderId);

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
