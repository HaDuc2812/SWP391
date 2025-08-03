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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.ExportBill;
import model.ExportItem;
import model.Product;
import model.Shop;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ExportController", urlPatterns = {"/export", "/export/*"})
public class ExportController extends HttpServlet {

    private DAO dao;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new DAO();
    }

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
            out.println("<title>Servlet ExportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportController at " + request.getContextPath() + "</h1>");
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
        String action = request.getPathInfo();

        try {
            if (action == null || action.equals("/list")) {
                listExports(request, response);
            } else if (action.equals("/new")) {
                showNewForm(request, response);
            } else if (action.equals("/detail")) {
                showDetail(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
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
        String action = request.getPathInfo();

        try {
            if (action == null || action.equals("/create")) {
                createExport(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException ex) {
            request.setAttribute("error", ex.getMessage());
            try {
                showNewForm(request, response);
            } catch (SQLException ex1) {
                Logger.getLogger(ExportController.class.getName()).log(Level.SEVERE, null, ex1);
            }
        }
    }

    private void listExports(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        // Lấy tham số tìm kiếm từ request
        String searchTerm = request.getParameter("search");
        String statusFilter = request.getParameter("status");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");

        // Gọi DAO với các tham số lọc
        List<ExportBill> exports = dao.getAllExportBills(searchTerm, statusFilter, fromDate, toDate);

        request.setAttribute("exports", exports);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("statusFilter", statusFilter);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);

        request.getRequestDispatcher("/exportList.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Shop> shops = dao.getAllShops();
        List<Product> products = dao.getAllGoods();

        request.setAttribute("shops", shops);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/exportForm.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int exportId = Integer.parseInt(request.getParameter("id"));
        ExportBill exportBill = dao.getExportBillById(exportId);

        if (exportBill == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("exportBill", exportBill);
        request.getRequestDispatcher("/exportDetail.jsp").forward(request, response);
    }

    private void createExport(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

//        if (user == null || !(user.getRole().equals("InventoryManager") || user.getRole().equals("Administrator"))) {
//            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only inventory managers can create export bills");
//            return;
//        }
        int shopId = Integer.parseInt(request.getParameter("shopId"));
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");

        ExportBill exportBill = new ExportBill();
        exportBill.setShopId(shopId);
        exportBill.setCreatedBy(user.getUser_id());
        exportBill.setStatus("Completed");

        double totalAmount = 0;
        List<ExportItem> items = new ArrayList<>();

        for (int i = 0; i < productIds.length; i++) {
            int productId = Integer.parseInt(productIds[i]);
            int quantity = Integer.parseInt(quantities[i]);
            double price = Double.parseDouble(prices[i]);

            ExportItem item = new ExportItem();
            item.setFurnitureId(productId);
            item.setQuantity(quantity);
            item.setUnitPrice(price);
            items.add(item);

            totalAmount += quantity * price;
        }

        exportBill.setTotalAmount(totalAmount);
        exportBill.setItems(items);

        int exportId = dao.createExportBill(exportBill);

        response.sendRedirect(request.getContextPath() + "/export/detail?id=" + exportId);
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
