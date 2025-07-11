/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAO;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.OrderItem;
import model.Product;
import model.Suppliers;

/**
 *
 * @author HA DUC
 */
public class StorageOrderToSupplier extends HttpServlet {

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
            out.println("<title>Servlet StorageOrderToSupplier</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StorageOrderToSupplier at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String role = user.getRole();
        if (role == null || !(role.equalsIgnoreCase("InventoryManager") || role.equalsIgnoreCase("Administrator"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Only managers can perform this action.");
            return;
        }

        try {
            DAO dao = new DAO();
            // Get list of suppliers and products for the form
            List<Suppliers> suppliers = dao.getAllSuppliers();
            List<Product> products = dao.getAllGoods();

            request.setAttribute("suppliers", suppliers);
            request.setAttribute("products", products);
            request.getRequestDispatcher("placeOrderResult.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error loading form data: " + e.getMessage());
            request.getRequestDispatcher("placeOrderResult.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method to process the order.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        String role = user.getRole();
        if (role == null || !(role.equalsIgnoreCase("InventoryManager") || role.equalsIgnoreCase("Administrator"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Only managers can perform this action.");
            return;
        }

        try {
            int supplierId = Integer.parseInt(request.getParameter("supplierId"));
            String[] goodIds = request.getParameterValues("goodId");
            String[] quantities = request.getParameterValues("quantity");
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

            DAO dao = new DAO();
            List<OrderItem> items = new ArrayList<>();

            // Get product prices from database and create order items
            for (int i = 0; i < goodIds.length; i++) {
                int goodId = Integer.parseInt(goodIds[i]);
                int quantity = Integer.parseInt(quantities[i]);

                // Get product details including price from database
                Product product = dao.getProductById(goodId);
                if (product == null) {
                    throw new Exception("Product with ID " + goodId + " not found");
                }

                OrderItem item = new OrderItem();
                item.setGoodId(goodId);
                item.setQuantity(quantity);
                item.setUnitPrice(product.getCost()); // Use price from database
                items.add(item);
            }

            // Place the order with the calculated total
            int orderId = dao.placeStorageOrder(supplierId, user.getUser_id(), items, totalAmount);

            if (orderId > 0) {
                request.setAttribute("message", "Order placed successfully. Order ID: " + orderId);
                request.setAttribute("success", true);
            } else {
                request.setAttribute("message", "Failed to place order.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error processing order: " + e.getMessage());
        }

        request.getRequestDispatcher("placeOrderResult.jsp").forward(request, response);
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
