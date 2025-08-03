/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
import entity.Accounts;
import model.Product;
import entity.User;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import java.sql.Statement;
import java.util.HashMap;
import java.util.Map;
import model.*;

/**
 *
 * @author HA DUC
 */
public class DAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Accounts login(String email, String password) {
        String query = "SELECT * FROM Users WHERE email = ? AND [password] = ?";
        try {
            System.out.println("Connecting to database for login...");
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            System.out.println("Executing query: " + ps);
            rs = ps.executeQuery();
            if (rs.next()) {
                System.out.println("Login successful for user: " + email);
                return new Accounts(
                        rs.getInt("UserID"),
                        rs.getString("Email"),
                        rs.getString("Password"),
                        rs.getString("FullName"),
                        rs.getString("Role")
                );
            } else {
                System.out.println("Login failed: incorrect email or password.");
            }
        } catch (SQLException e) {
            System.out.println("SQL Exception during login: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return null;
    }

    public boolean register(String fullName, String email, String phone, String password, String gender,
            String role, String address, Date dob) {
        String sql = "INSERT INTO Users (FullName, Email, PhoneNumber, Password, Gender, Role, Address, DateOfBirth) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, password); // consider hashing this
            ps.setString(5, gender);
            ps.setString(6, role);
            ps.setString(7, address);
            ps.setDate(8, dob); // java.sql.Date

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(); // Make sure close() closes conn, ps, rs if needed
        }
        return false;
    }

    public int countUsers() {
        String sql = "select count(*) from Users";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close();
        }
        return 0;
    }

    private void close() {
        try {
            if (rs != null) {
                ps.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateUser(int user_id, String field, String value) {
        if (!isAllowedField(field)) {
            throw new IllegalArgumentException("Invalid field name: " + field);
        }
        String sql = "UPDATE Users SET " + field + " = ? WHERE user_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, value);
            ps.setInt(2, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // For Date field specifically (DOB)
    public void updateUser(int user_id, String field, java.sql.Date value) {
        if (!"DOB".equals(field)) {
            throw new IllegalArgumentException("Only 'DOB' can be updated with Date value.");
        }
        String sql = "UPDATE Users SET " + field + " = ? WHERE UserID  = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, value);
            ps.setInt(2, user_id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Helper method to whitelist allowed fields
    private boolean isAllowedField(String field) {
        if (field == null) {
            return false;
        }
        switch (field) {
            case "FullName":
            case "PhoneNumber":
            case "Gender":
            case "Address":
            case "Password":
            case "Status":
            case "Role":
            case "Email":
                return true;
            default:
                return false;
        }
    }

    public User getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE UserID = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("UserID"));
                u.setFullname(rs.getString("FullName"));
                u.setEmail(rs.getString("Email"));
                u.setPassword(rs.getString("Password"));
                u.setPhonenumber(rs.getString("PhoneNumber"));
                u.setGender(rs.getString("Gender"));
                u.setRole(rs.getString("Role"));
                u.setAddress(rs.getString("Address"));
                u.setDob(rs.getDate("DateOfBirth"));
                u.setStatus(rs.getString("Status"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Shop> getAllShops() {
        List<Shop> shops = new ArrayList<>();
        String sql = "SELECT * FROM Shops";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Shop shop = new Shop();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("name"));
                shop.setLocation(rs.getString("address"));
                shops.add(shop);
            }

        } catch (SQLException e) {
            e.printStackTrace(); // You can also use logging
        }

        return shops;
    }

    public int countGoods() {
        String query = "SELECT COUNT(*) AS total FROM Goods";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error in countGoods(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    /**
     * Đếm tổng số nhà cung cấp (Suppliers)
     */
    public int countSuppliers() {
        String query = "SELECT COUNT(*) AS total FROM Suppliers";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error in countSuppliers(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    /**
     * Đếm tổng số đơn hàng (Orders)
     */
    public int countOrders() {
        String query = "SELECT COUNT(*) AS total FROM Orders";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error in countOrders(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    /**
     * Đếm tổng số yêu cầu khách hàng (CustomerRequests)
     */
    public int countCustomerRequests() {
        String query = "SELECT COUNT(*) AS total FROM CustomerRequests";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException e) {
            System.out.println("Error in countCustomerRequests(): " + e.getMessage());
        } finally {
            closeResources();
        }
        return 0;
    }

    /**
     * Đóng kết nối và các resource
     */
    private void closeResources() {
        try {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }

    //check xem email da ton tai trong he thong chua
    public boolean isEmailRegistered(String email) {
        String sql = "Select * from Users where email =?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean isPhoneRegistered(String phoneNumber) {
        String query = "SELECT 1 FROM Users WHERE PhoneNumber = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, phoneNumber);
            ResultSet rs = ps.executeQuery();
            return rs.next(); // true if phone number exists
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    //generate verification code
    public String generatVerificationCode() {
        Random rand = new Random();
        int code = 100000 + rand.nextInt(900000);
        return String.valueOf(code);
    }

    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE Users SET password_hash = ? WHERE email = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            // Optional: Hash the password before storing
            String hashedPassword = newPassword; // default plain

            ps.setString(1, hashedPassword);
            ps.setString(2, email);

            int rows = ps.executeUpdate();
            System.out.println("Updating password for: " + email + " | Rows affected: " + rows);
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

//    public List<Product> searchGoods(String keyword) {
//        List<Product> list = new ArrayList<>();
//        String sql = "SELECT * FROM Goods WHERE name LIKE ? OR category LIKE ?";
//
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
//            String kw = "%" + keyword + "%";
//            ps.setString(1, kw);
//            ps.setString(2, kw);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Product g = new Product(
//                        rs.getInt("good_id"),
//                        rs.getString("name"),
//                        rs.getString("description"),
//                        rs.getString("category"),
//                        rs.getDouble("price"),
//                        rs.getInt("quantity"),
//                        rs.getInt("supplier_id"),
//                        rs.getDate("added_on")
//                );
//                list.add(g);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return list;
//    }
    public List<Product> getAllGoods() {
        List<Product> goods = new ArrayList<>();
        String sql = "SELECT * FROM Furniture";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Product g = new Product();
                g.setFurnitureID(rs.getInt("FurnitureID"));
                g.setFurnitureName(rs.getString("FurnitureName"));
                g.setPoster(rs.getString("Image"));
                g.setDescription(rs.getString("Description"));
                g.setStatus(rs.getString("Status"));
                g.setBrand(rs.getString("Brand"));
                g.setCategory(rs.getString("Category"));
                g.setMaterial(rs.getString("Material"));
                g.setStockQuantity(rs.getInt("StockQuantity"));
                g.setCost(rs.getDouble("Cost"));
                g.setCreatedDate(rs.getDate("CreatedDate"));
                g.setLastUpdated(rs.getDate("LastUpdated"));

                goods.add(g);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return goods;
    }

    public Shop getShopbyId(int shopId) {
        String sql = "SELECT * FROM Shops WHERE shop_id=?";
        Shop shop = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, shopId);
            rs = ps.executeQuery(); // ✅ Required line
            if (rs.next()) {
                shop = new Shop();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("name"));
                shop.setLocation(rs.getString("Address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return shop;
    }

    public List<Order> getAllSupplierOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE shop_id IS NULL ORDER BY order_date DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setShopid(null); // because it's a supplier order, shop_id is null
                o.setSupplierId(rs.getInt("supplier_id")); // supplierId is valid
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setStatus(rs.getString("status"));
                o.setTotalCost(rs.getDouble("total_cost"));
                o.setPlacedBy(rs.getInt("placed_by"));
                orders.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public String getSupplierNameById(int supplierId) {
        String sql = "SELECT name FROM Suppliers WHERE supplier_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, supplierId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("name");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String getOrderStatus(int orderId) {
        String sql = "SELECT status FROM Orders WHERE order_id = ?";
        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

//    public List<Product> getLowQuantityGoods(int threshold) {
//        List<Product> lowStock = new ArrayList<>();
//        String sql = "Select * from Goods where quantity < ?";
//        try {
//            conn = DBContext.getConnection();
//            ps = conn.prepareStatement(sql);
//
//            ps.setInt(1, threshold);
//            rs = ps.executeQuery();
//            while (rs.next()) {
//                Product g = new Product();
//                g.setGood_id(rs.getInt("good_id"));
//                g.setName(rs.getString("name"));
//                g.setDescription(rs.getString("description"));
//                g.setCategory(rs.getString("category"));
//                g.setPrice(rs.getDouble("price"));
//                g.setQuantity(rs.getInt("quantity"));
//                g.setSupplier_id(rs.getInt("supplier_id"));
//                g.setAdded_on(rs.getDate("added_on"));
//                lowStock.add(g);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return lowStock;
//    }
//
//    public List<Product> getFilteredGoods(String[] categories, Double minPrice, Double maxPrice) {
//        List<Product> goods = new ArrayList<>();
//        StringBuilder sql = new StringBuilder("SELECT * FROM Goods WHERE 1=1");
//        List<Object> params = new ArrayList<>();
//
//        // Add categories filter
//        if (categories != null && categories.length > 0) {
//            sql.append(" AND category IN (");
//            for (int i = 0; i < categories.length; i++) {
//                sql.append("?");
//                if (i < categories.length - 1) {
//                    sql.append(", ");
//                }
//                params.add(categories[i]);
//            }
//            sql.append(")");
//        }
//
//        // Add price filter
//        if (minPrice != null && maxPrice != null) {
//            sql.append(" AND price BETWEEN ? AND ?");
//            params.add(minPrice);
//            params.add(maxPrice);
//        }
//
//        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql.toString())) {
//
//            for (int i = 0; i < params.size(); i++) {
//                ps.setObject(i + 1, params.get(i));
//            }
//
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Product g = new Product();
//                g.setGood_id(rs.getInt("good_id"));
//                g.setName(rs.getString("name"));
//                g.setDescription(rs.getString("description"));
//                g.setCategory(rs.getString("category"));
//                g.setPrice(rs.getDouble("price"));
//                g.setQuantity(rs.getInt("quantity"));
//                g.setSupplier_id(rs.getInt("supplier_id"));
//                g.setAdded_on(rs.getDate("added_on"));
//                goods.add(g);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return goods;
//    }
    //shop orders from storage
    public int placeShopOrder(int shopId, int placedByUserId, List<OrderItem> items, double total) {
        int orderId = -1;
        String orderSql = "INSERT INTO Orders (shop_id, order_date, status, total_cost, placed_by) VALUES (?, GETDATE(), 'Placed', ?, ?)";
        String itemSql = "INSERT INTO Order_Items (order_id, good_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Insert into Orders
            ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, shopId);
            ps.setDouble(2, total);
            ps.setInt(3, placedByUserId); // should be valid UserID (e.g., 9999 for "System")
            System.out.println("Placing order with total: " + total);

            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            ps.close();

            // Insert order items
            ps = conn.prepareStatement(itemSql);
            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getGood_id());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getUnitPrice());
                ps.addBatch();
            }
            ps.executeBatch();

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderId;
    }
// Storage places an order to Supplier

    public int placeStorageOrder(int supplierId, int userId, List<OrderItem> items, double total) {
        int orderId = -1;
        String orderSql = "INSERT INTO Orders (supplier_id, order_date, status, total_cost, placed_by) VALUES (?, GETDATE(), 'Placed', ?, ?)";
        String itemSql = "INSERT INTO Order_Items (order_id, good_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Insert order
            ps = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, supplierId);
            ps.setDouble(2, total);
            ps.setInt(3, userId);
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }
            ps.close();

            // Insert order items
            ps = conn.prepareStatement(itemSql);
            for (OrderItem item : items) {
                ps.setInt(1, orderId);
                ps.setInt(2, item.getGood_id());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getUnitPrice());
                ps.addBatch();
            }
            ps.executeBatch();

            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return orderId;
    }

    public List<Suppliers> getAllSuppliers() {
        List<Suppliers> suppliers = new ArrayList<>();
        String sql = "select * from Suppliers order by supplier_id";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                Suppliers su = new Suppliers();
                su.setSname(rs.getString("name"));
                su.setSupplierID(rs.getInt("supplier_id"));
                su.setAddress(rs.getString("address"));
                suppliers.add(su);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    public Product getProductById(int comboId) {
        String sql = "SELECT * FROM Furniture WHERE FurnitureID = ?";
        Product product = null;

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, comboId); // move this before executeQuery
            rs = ps.executeQuery();

            if (rs.next()) {
                product = new Product(); // or use Product if you're using that class name
                product.setFurnitureID(rs.getInt("FurnitureID"));
                product.setFurnitureName(rs.getString("FurnitureName"));
                product.setPoster(rs.getString("Poster"));
                product.setDescription(rs.getString("Description"));
                product.setStatus(rs.getString("Status"));
                product.setBrand(rs.getString("Brand"));
                product.setCategory(rs.getString("Category"));
                product.setMaterial(rs.getString("Material"));
                product.setStockQuantity(rs.getInt("StockQuantity"));
                product.setCost(rs.getDouble("Cost"));
                product.setCreatedDate(rs.getDate("CreatedDate"));
                product.setLastUpdated(rs.getDate("LastUpdated"));
            }

        } catch (SQLException e) {
            System.err.println("Error getting furniture by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return product;
    }

    public List<Order> getAllShopOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE shop_id IS NOT NULL ORDER BY order_date DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order o = new Order();
                o.setOrderId(rs.getInt("order_id"));
                o.setShopid(rs.getInt("shop_id"));
                o.setSupplierId(null); // because we know it's null
                o.setOrderDate(rs.getTimestamp("order_date"));
                o.setStatus(rs.getString("status"));
                o.setTotalCost(rs.getDouble("total_cost"));
                o.setPlacedBy(rs.getInt("placed_by"));
                orders.add(o);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public String getShopNameById(int shopId) {
        String name = "unknown";
        String sql = "SELECT [name] FROM Shops WHERE shop_id =?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, shopId);
            rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString("name");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public String getUsernameById(int userId) {
        String name = "unknown";
        String sql = "SELECT fullName FROM Users WHERE UserID = ?;";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                name = rs.getString("fullName");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return name;
    }

    public Order getOrderWithDetails(int orderId) throws SQLException {
        String sql = "SELECT \n"
                + "    o.order_id,\n"
                + "    o.order_date,\n"
                + "    o.status,\n"
                + "    o.total_cost,\n"
                + "    o.placed_by,\n"
                + "    o.shop_id,\n"
                + "    o.supplier_id,\n"
                + "    oi.good_id,\n"
                + "    oi.quantity,\n"
                + "    oi.unit_price,\n"
                + "    f.FurnitureName AS good_name\n"
                + "FROM \n"
                + "    Orders o\n"
                + "JOIN \n"
                + "    Order_Items oi ON o.order_id = oi.order_id\n"
                + "JOIN \n"
                + "    Furniture f ON oi.good_id = f.FurnitureID\n"
                + "WHERE \n"
                + "    o.order_id = 37;";
        Order order = null;
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            try {
                rs = ps.executeQuery();
                List<OrderItem> items = new ArrayList<>();
                while (rs.next()) {
                    if (order == null) {
                        order = new Order();
                        order.setOrderId(rs.getInt("order_id"));
                        order.setOrderDate(rs.getDate("order_date"));
                        order.setStatus(rs.getString("status"));
                        order.setTotalCost(rs.getDouble("total_cost"));
                        order.setPlacedBy(rs.getInt("placed_by"));
                        order.setShopid(rs.getInt("shop_id"));
                    }
                    OrderItem item = new OrderItem();
                    item.setGood_id(rs.getInt("good_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));
                    items.add(item);
                }
                if (order != null) {
                    order.setItems(items);
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public String getFurnitureNameById(int comboId) throws SQLException {
        String sql = "SELECT FurnitureName FROM Furniture WHERE FurnitureID = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, comboId);
            try {
                rs = ps.executeQuery();
                if (rs.next()) {
                    return rs.getString("FurnitureName");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<OrderItem> getOderItemsByOrderId(int orderId) {
        List<OrderItem> items = new ArrayList<>();
        double totalCost = 0;

        String sql = "SELECT oi.*, o.total_cost\n"
                + "FROM Order_Items oi\n"
                + "JOIN Orders o ON oi.order_id = o.order_id\n"
                + "WHERE oi.order_id = ?;";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemId(rs.getInt("order_item_id"));
                item.setOrderId(rs.getInt("order_id"));
                item.setGood_id(rs.getInt("good_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));

                totalCost = rs.getDouble("total_cost"); // Same for all rows
                item.setTotalPrice(rs.getDouble("total_cost"));
                items.add(item);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "select * from Orders where order_id = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setShopid(rs.getInt("shop_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setTotalCost(rs.getDouble("total_cost"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public int getFurnitureStockBYId(int comboId) throws SQLException {
        String sql = "SELECT  StockQuantity FROM Furniture WHERE FurnitureID = ?;";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, comboId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("StockQuantity");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

    public void deductFurnitureStocks(int comboId, int quantity) throws SQLException {
        String sql = "UPDATE Furniture SET StockQuantity = StockQuantity - ? WHERE FurnitureID = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, comboId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE Orders SET status = ? WHERE order_id = ?";
        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Import/Export methods
    public int createImportBill(ImportBill importBill) throws SQLException {
        int importId = -1;
        String billSql = "INSERT INTO ImportBills (supplier_id, total_amount, created_by, status) VALUES (?, ?, ?, ?)";
        String itemSql = "INSERT INTO ImportItems (import_id, furniture_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Insert import bill
            ps = conn.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, importBill.getSupplierId());
            ps.setDouble(2, importBill.getTotalAmount());
            ps.setInt(3, importBill.getCreatedBy());
            ps.setString(4, importBill.getStatus());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                importId = rs.getInt(1);
            }

            // Insert import items
            ps = conn.prepareStatement(itemSql);
            for (ImportItem item : importBill.getItems()) {
                ps.setInt(1, importId);
                ps.setInt(2, item.getFurnitureId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getUnitPrice());
                ps.addBatch();

                // Update stock quantity
                updateFurnitureStock(conn, item.getFurnitureId(), item.getQuantity());
            }
            ps.executeBatch();

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            closeResources();
        }
        return importId;
    }

    public int createExportBill(ExportBill exportBill) throws SQLException {
        int exportId = -1;
        String billSql = "INSERT INTO ExportBills (shop_id, total_amount, created_by, status) VALUES (?, ?, ?, ?)";
        String itemSql = "INSERT INTO ExportItems (export_id, furniture_id, quantity, unit_price) VALUES (?, ?, ?, ?)";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);

            // Check stock availability first
            for (ExportItem item : exportBill.getItems()) {
                int currentStock = getFurnitureStockBYId(item.getFurnitureId());
                if (currentStock < item.getQuantity()) {
                    throw new SQLException("Not enough stock for furniture ID: " + item.getFurnitureId()
                            + ". Available: " + currentStock + ", Requested: " + item.getQuantity());
                }
            }

            // Insert export bill
            ps = conn.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, exportBill.getShopId());
            ps.setDouble(2, exportBill.getTotalAmount());
            ps.setInt(3, exportBill.getCreatedBy());
            ps.setString(4, exportBill.getStatus());
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (rs.next()) {
                exportId = rs.getInt(1);
            }

            // Insert export items
            ps = conn.prepareStatement(itemSql);
            for (ExportItem item : exportBill.getItems()) {
                ps.setInt(1, exportId);
                ps.setInt(2, item.getFurnitureId());
                ps.setInt(3, item.getQuantity());
                ps.setDouble(4, item.getUnitPrice());
                ps.addBatch();

                // Update stock quantity (deduct)
                updateFurnitureStock(conn, item.getFurnitureId(), -item.getQuantity());
            }
            ps.executeBatch();

            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                conn.rollback();
            }
            throw e;
        } finally {
            closeResources();
        }
        return exportId;
    }

    private void updateFurnitureStock(Connection conn, int furnitureId, int quantityChange) throws SQLException {
        String sql = "UPDATE Furniture SET StockQuantity = StockQuantity + ? WHERE FurnitureID = ?";
        PreparedStatement ps = null;
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quantityChange);
            ps.setInt(2, furnitureId);
            ps.executeUpdate();
        } finally {
            if (ps != null) {
                ps.close();
            }
        }
    }

    public List<ImportBill> getAllImportBills() throws SQLException {
        List<ImportBill> bills = new ArrayList<>();
        String sql = "SELECT ib.*, s.name as supplier_name, s.address as supplier_address "
                + "FROM ImportBills ib "
                + "JOIN Suppliers s ON ib.supplier_id = s.supplier_id "
                + "ORDER BY ib.import_date DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ImportBill bill = new ImportBill();
                bill.setImportId(rs.getInt("import_id"));
                bill.setSupplierId(rs.getInt("supplier_id"));
                bill.setImportDate(rs.getTimestamp("import_date"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setCreatedBy(rs.getInt("created_by"));
                bill.setStatus(rs.getString("status"));

                Suppliers supplier = new Suppliers();
                supplier.setSupplierID(rs.getInt("supplier_id"));
                supplier.setSname(rs.getString("supplier_name"));
                supplier.setAddress(rs.getString("supplier_address"));
                bill.setSupplier(supplier);

                bills.add(bill);
            }
        } finally {
            closeResources();
        }
        return bills;
    }

    public List<ExportBill> getAllExportBills() throws SQLException {
        List<ExportBill> bills = new ArrayList<>();
        String sql = "SELECT eb.*, s.name as shop_name, s.address as shop_location "
                + "FROM ExportBills eb "
                + "JOIN Shops s ON eb.shop_id = s.shop_id "
                + "ORDER BY eb.export_date DESC";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                ExportBill bill = new ExportBill();
                bill.setExportId(rs.getInt("export_id"));
                bill.setShopId(rs.getInt("shop_id"));
                bill.setExportDate(rs.getTimestamp("export_date"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setCreatedBy(rs.getInt("created_by"));
                bill.setStatus(rs.getString("status"));

                Shop shop = new Shop();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("shop_name"));
                shop.setLocation(rs.getString("shop_location"));
                bill.setShop(shop);

                bills.add(bill);
            }
        } finally {
            closeResources();
        }
        return bills;
    }

    public ImportBill getImportBillById(int importId) throws SQLException {
        ImportBill bill = null;
        String billSql = "SELECT ib.*, s.name as supplier_name, s.address as supplier_address "
                + "FROM ImportBills ib "
                + "JOIN Suppliers s ON ib.supplier_id = s.supplier_id "
                + "WHERE ib.import_id = ?";
        String itemsSql = "SELECT ii.*, f.FurnitureName, f.Brand, f.Category "
                + "FROM ImportItems ii "
                + "JOIN Furniture f ON ii.furniture_id = f.FurnitureID "
                + "WHERE ii.import_id = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();

            // Get bill info
            ps = conn.prepareStatement(billSql);
            ps.setInt(1, importId);
            rs = ps.executeQuery();

            if (rs.next()) {
                bill = new ImportBill();
                bill.setImportId(rs.getInt("import_id"));
                bill.setSupplierId(rs.getInt("supplier_id"));
                bill.setImportDate(rs.getTimestamp("import_date"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setCreatedBy(rs.getInt("created_by"));
                bill.setStatus(rs.getString("status"));

                Suppliers supplier = new Suppliers();
                supplier.setSupplierID(rs.getInt("supplier_id"));
                supplier.setSname(rs.getString("supplier_name"));
                supplier.setAddress(rs.getString("supplier_address"));
                bill.setSupplier(supplier);
            }

            if (bill != null) {
                // Get items
                ps = conn.prepareStatement(itemsSql);
                ps.setInt(1, importId);
                rs = ps.executeQuery();

                List<ImportItem> items = new ArrayList<>();
                while (rs.next()) {
                    ImportItem item = new ImportItem();
                    item.setImportItemId(rs.getInt("import_item_id"));
                    item.setImportId(rs.getInt("import_id"));
                    item.setFurnitureId(rs.getInt("furniture_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));

                    Product product = new Product();
                    product.setFurnitureID(rs.getInt("furniture_id"));
                    product.setFurnitureName(rs.getString("FurnitureName"));
                    product.setBrand(rs.getString("Brand"));
                    product.setCategory(rs.getString("Category"));
                    item.setProduct(product);

                    items.add(item);
                }
                bill.setItems(items);
            }
        } finally {
            closeResources();
        }
        return bill;
    }

    public ExportBill getExportBillById(int exportId) throws SQLException {
        ExportBill bill = null;
        String billSql = "SELECT eb.*, s.name as shop_name, s.address as shop_location "
                + "FROM ExportBills eb "
                + "JOIN Shops s ON eb.shop_id = s.shop_id "
                + "WHERE eb.export_id = ?";
        String itemsSql = "SELECT ei.*, f.FurnitureName, f.Brand, f.Category "
                + "FROM ExportItems ei "
                + "JOIN Furniture f ON ei.furniture_id = f.FurnitureID "
                + "WHERE ei.export_id = ?";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();

            // Get bill info
            ps = conn.prepareStatement(billSql);
            ps.setInt(1, exportId);
            rs = ps.executeQuery();

            if (rs.next()) {
                bill = new ExportBill();
                bill.setExportId(rs.getInt("export_id"));
                bill.setShopId(rs.getInt("shop_id"));
                bill.setExportDate(rs.getTimestamp("export_date"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setCreatedBy(rs.getInt("created_by"));
                bill.setStatus(rs.getString("status"));

                Shop shop = new Shop();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("shop_name"));
                shop.setLocation(rs.getString("shop_location"));
                bill.setShop(shop);
            }

            if (bill != null) {
                // Get items
                ps = conn.prepareStatement(itemsSql);
                ps.setInt(1, exportId);
                rs = ps.executeQuery();

                List<ExportItem> items = new ArrayList<>();
                while (rs.next()) {
                    ExportItem item = new ExportItem();
                    item.setExportItemId(rs.getInt("export_item_id"));
                    item.setExportId(rs.getInt("export_id"));
                    item.setFurnitureId(rs.getInt("furniture_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getDouble("unit_price"));

                    Product product = new Product();
                    product.setFurnitureID(rs.getInt("furniture_id"));
                    product.setFurnitureName(rs.getString("FurnitureName"));
                    product.setBrand(rs.getString("Brand"));
                    product.setCategory(rs.getString("Category"));
                    item.setProduct(product);

                    items.add(item);
                }
                bill.setItems(items);
            }
        } finally {
            closeResources();
        }
        return bill;
    }

    // Thêm vào DAO.java
    public Map<String, Object> getInventoryStats() throws SQLException {
        Map<String, Object> stats = new HashMap<>();
        String sql = "SELECT "
                + "  (SELECT COUNT(*) FROM Furniture) AS totalProducts, "
                + "  (SELECT SUM(StockQuantity) FROM Furniture) AS totalStock, "
                + "  (SELECT SUM(StockQuantity * Cost) FROM Furniture) AS inventoryValue, "
                + "  (SELECT COUNT(*) FROM ImportBills WHERE import_date >= DATEADD(day, -30, GETDATE())) AS recentImports, "
                + "  (SELECT COUNT(*) FROM ExportBills WHERE export_date >= DATEADD(day, -30, GETDATE())) AS recentExports";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            if (rs.next()) {
                stats.put("totalProducts", rs.getInt("totalProducts"));
                stats.put("totalStock", rs.getInt("totalStock"));
                stats.put("inventoryValue", rs.getDouble("inventoryValue"));
                stats.put("recentImports", rs.getInt("recentImports"));
                stats.put("recentExports", rs.getInt("recentExports"));
            }
        } finally {
            closeResources();
        }
        return stats;
    }

// Phương thức phụ trợ để lấy thống kê theo loại sản phẩm
    public Map<String, Integer> getProductStatsByCategory() throws SQLException {
        Map<String, Integer> categoryStats = new HashMap<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT Category, COUNT(*) as count FROM Furniture GROUP BY Category");

            while (rs.next()) {
                categoryStats.put(rs.getString("Category"), rs.getInt("count"));
            }
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (stmt != null) {
                    stmt.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return categoryStats;
    }

    public List<ImportBill> getAllImportBills(String searchTerm, String status, String fromDate, String toDate) throws SQLException {
        List<ImportBill> bills = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT ib.*, s.name as supplier_name, s.address as supplier_address "
                + "FROM ImportBills ib "
                + "JOIN Suppliers s ON ib.supplier_id = s.supplier_id "
                + "WHERE 1=1"
        );

        List<Object> params = new ArrayList<>();

        if (searchTerm != null && !searchTerm.isEmpty()) {
            sql.append(" AND (s.name LIKE ? OR ib.import_id LIKE ?)");
            params.add("%" + searchTerm + "%");
            params.add("%" + searchTerm + "%");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND ib.status = ?");
            params.add(status);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND ib.import_date >= ?");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND ib.import_date <= ?");
            params.add(toDate);
        }

        sql.append(" ORDER BY ib.import_date DESC");

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                ImportBill bill = new ImportBill();
                bill.setImportId(rs.getInt("import_id"));
                bill.setSupplierId(rs.getInt("supplier_id"));
                bill.setImportDate(rs.getTimestamp("import_date"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setCreatedBy(rs.getInt("created_by"));
                bill.setStatus(rs.getString("status"));

                Suppliers supplier = new Suppliers();
                supplier.setSupplierID(rs.getInt("supplier_id"));
                supplier.setSname(rs.getString("supplier_name"));
                supplier.setAddress(rs.getString("supplier_address"));
                bill.setSupplier(supplier);

                bills.add(bill);
            }
        } finally {
            closeResources();
        }
        return bills;
    }

    /**
     * Lấy tất cả phiếu xuất với khả năng lọc
     */
    public List<ExportBill> getAllExportBills(String searchTerm, String status, String fromDate, String toDate) throws SQLException {
        List<ExportBill> bills = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT eb.*, s.name as shop_name, s.address as shop_location "
                + "FROM ExportBills eb "
                + "JOIN Shops s ON eb.shop_id = s.shop_id "
                + "WHERE 1=1"
        );

        List<Object> params = new ArrayList<>();

        if (searchTerm != null && !searchTerm.isEmpty()) {
            sql.append(" AND (s.name LIKE ? OR eb.export_id LIKE ?)");
            params.add("%" + searchTerm + "%");
            params.add("%" + searchTerm + "%");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND eb.status = ?");
            params.add(status);
        }

        if (fromDate != null && !fromDate.isEmpty()) {
            sql.append(" AND eb.export_date >= ?");
            params.add(fromDate);
        }

        if (toDate != null && !toDate.isEmpty()) {
            sql.append(" AND eb.export_date <= ?");
            params.add(toDate);
        }

        sql.append(" ORDER BY eb.export_date DESC");

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql.toString());

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            rs = ps.executeQuery();

            while (rs.next()) {
                ExportBill bill = new ExportBill();
                bill.setExportId(rs.getInt("export_id"));
                bill.setShopId(rs.getInt("shop_id"));
                bill.setExportDate(rs.getTimestamp("export_date"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setCreatedBy(rs.getInt("created_by"));
                bill.setStatus(rs.getString("status"));

                Shop shop = new Shop();
                shop.setShopId(rs.getInt("shop_id"));
                shop.setShopName(rs.getString("shop_name"));
                shop.setLocation(rs.getString("shop_location"));
                bill.setShop(shop);

                bills.add(bill);
            }
        } finally {
            closeResources();
        }
        return bills;
    }

    public Map<String, Integer> getMonthlyImportExportStats() throws SQLException {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT "
                + "  FORMAT(import_date, 'yyyy-MM') AS month, "
                + "  COUNT(*) AS import_count "
                + "FROM ImportBills "
                + "WHERE import_date >= DATEADD(month, -6, GETDATE()) "
                + "GROUP BY FORMAT(import_date, 'yyyy-MM') "
                + "UNION ALL "
                + "SELECT "
                + "  FORMAT(export_date, 'yyyy-MM') AS month, "
                + "  COUNT(*) * -1 AS export_count "
                + "FROM ExportBills "
                + "WHERE export_date >= DATEADD(month, -6, GETDATE()) "
                + "GROUP BY FORMAT(export_date, 'yyyy-MM')";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                String month = rs.getString("month");
                int count = rs.getInt("import_count");
                stats.merge(month, count, Integer::sum);
            }
        } finally {
            closeResources();
        }
        return stats;
    }

    public Map<String, Double> getInventoryValueByCategory() throws SQLException {
        Map<String, Double> values = new HashMap<>();
        String sql = "SELECT "
                + "  Category, "
                + "  SUM(StockQuantity * Cost) AS total_value "
                + "FROM Furniture "
                + "GROUP BY Category";

        try {
            conn = DBContext.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                values.put(rs.getString("Category"), rs.getDouble("total_value"));
            }
        } finally {
            closeResources();
        }
        return values;
    }

}
