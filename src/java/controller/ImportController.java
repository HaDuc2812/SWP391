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
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.ImportBill;
import model.ImportItem;
import model.Product;
import model.Suppliers;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ImportController", urlPatterns = {"/import", "/import/*"})
public class ImportController extends HttpServlet {

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
            out.println("<title>Servlet ImportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportController at " + request.getContextPath() + "</h1>");
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
                listImports(request, response);
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
                createImport(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listImports(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<ImportBill> imports = dao.getAllImportBills();
        request.setAttribute("imports", imports);
        request.getRequestDispatcher("/importList.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Suppliers> suppliers = dao.getAllSuppliers();
        List<Product> products = dao.getAllGoods();

        request.setAttribute("suppliers", suppliers);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/importForm.jsp").forward(request, response);
    }

    private void showDetail(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int importId = Integer.parseInt(request.getParameter("id"));
        ImportBill importBill = dao.getImportBillById(importId);

        if (importBill == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        request.setAttribute("importBill", importBill);
        request.getRequestDispatcher("/importDetail.jsp").forward(request, response);
    }

    private void createImport(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

// Kiểm tra user null
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/Login.jsp?redirect="
                    + URLEncoder.encode(request.getRequestURI(), "UTF-8"));
            return;
        }

        // Kiểm tra role (đã bỏ comment)
        if (!(user.getRole().equalsIgnoreCase("InventoryManager")
                || user.getRole().equalsIgnoreCase("Administrator"))) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN,
                    "Only inventory managers or administrators can create import bills");
            return;
        }

        int supplierId = Integer.parseInt(request.getParameter("supplierId"));
        String[] productIds = request.getParameterValues("productId");
        String[] quantities = request.getParameterValues("quantity");
        String[] prices = request.getParameterValues("price");

        ImportBill importBill = new ImportBill();
        importBill.setSupplierId(supplierId);
        importBill.setCreatedBy(user.getUser_id());
        importBill.setStatus("Completed");

        double totalAmount = 0;
        List<ImportItem> items = new ArrayList<>();

        for (int i = 0; i < productIds.length; i++) {
            int productId = Integer.parseInt(productIds[i]);
            int quantity = Integer.parseInt(quantities[i]);
            double price = Double.parseDouble(prices[i]);

            ImportItem item = new ImportItem();
            item.setFurnitureId(productId);
            item.setQuantity(quantity);
            item.setUnitPrice(price);
            items.add(item);

            totalAmount += quantity * price;
        }

        importBill.setTotalAmount(totalAmount);
        importBill.setItems(items);

        int importId = dao.createImportBill(importBill);

        response.sendRedirect(request.getContextPath() + "/import/detail?id=" + importId);
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
