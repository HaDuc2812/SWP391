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
import model.Shop;

/**
 *
 * @author HA DUC
 */
public class ShopOrders extends HttpServlet {

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
            out.println("<title>Servlet ShopOrders</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ShopOrders at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        DAO dao = new DAO();
        List<Shop> shops = dao.getAllShops();          // Load list of shops
        List<Product> products = dao.getAllGoods();    // Load product list (Furniture)

        request.setAttribute("shops", shops);
        request.setAttribute("products", products);
        request.getRequestDispatcher("shopsPlaceOrders.jsp").forward(request, response); // JSP to display form
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                response.sendRedirect("Login.jsp");
                return;
            }

            int userId = user.getUser_id();
            int shopId = Integer.parseInt(request.getParameter("shopId"));
            String[] goodIds = request.getParameterValues("goodId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] prices = request.getParameterValues("price[]");

            if (goodIds == null || quantities == null || prices == null || goodIds.length == 0) {
                request.setAttribute("status", "error");
                request.setAttribute("message", "Missing or empty order item data.");
                request.getRequestDispatcher("shopOrderResult.jsp").forward(request, response);
                return;
            }

            List<OrderItem> items = new ArrayList<>();
            System.out.println("Items to insert: " + items.size());
            for (OrderItem item : items) {
                System.out.println("Item - GoodID: " + item.getGood_id() + ", Qty: " + item.getQuantity() + ", Price: " + item.getUnitPrice());
            }
            for (int i = 0; i < goodIds.length; i++) {
                String goodIdStr = goodIds[i];
                String quantityStr = quantities[i];
                String priceStr = prices[i];

                if (goodIdStr == null || quantityStr == null || priceStr == null
                        || goodIdStr.trim().isEmpty() || quantityStr.trim().isEmpty() || priceStr.trim().isEmpty()) {
                    continue; // skip empty entries
                }

                int productId = Integer.parseInt(goodIdStr);
                int quantity = Integer.parseInt(quantityStr);
                double price = Double.parseDouble(priceStr);

                OrderItem item = new OrderItem();
                item.setGood_id(productId);
                item.setQuantity(quantity);
                item.setUnitPrice(price);

                items.add(item);
            }

            if (items.isEmpty()) {
                request.setAttribute("status", "error");
                request.setAttribute("message", "No valid order items found.");
                request.getRequestDispatcher("shopOrderResult.jsp").forward(request, response);
                return;
            }

            double total = 0;
            String totalAmountParam = request.getParameter("totalAmount");
            if (totalAmountParam != null && !totalAmountParam.trim().isEmpty()) {
                try {
                    total = Double.parseDouble(totalAmountParam.trim());
                } catch (NumberFormatException e) {
                    total = 0; // fallback or log error
                }
            } else {
                total = 0; // fallback
            }

            DAO dao = new DAO();
            int orderId = dao.placeShopOrder(shopId, userId, items, total);

            if (orderId > 0) {
                request.setAttribute("status", "success");
                request.setAttribute("message", "Order placed successfully.");
                request.setAttribute("orderId", orderId);
                request.setAttribute("shopId", shopId);
            } else {
                request.setAttribute("status", "error");
                request.setAttribute("message", "Failed to place order.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("status", "error");
            request.setAttribute("message", "Error: " + e.getMessage());
        }

        request.getRequestDispatcher("shopOrderResult.jsp").forward(request, response);
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
