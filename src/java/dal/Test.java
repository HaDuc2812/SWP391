/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Product;
import entity.Accounts;
import entity.User;
import java.sql.Date;
import java.util.ArrayList;
import model.OrderItem;
import model.Shop;
import model.Suppliers;

/**
 *
 * @author HA DUC
 */
public class Test {

    public static void main(String[] args) {
        DAO dao = new DAO();
//    List<Goods> goodsList = dao.getAllGoods();
//
//    if (goodsList == null) {
//        System.out.println("goodsList is null");
//    } else if (goodsList.isEmpty()) {
//        System.out.println("goodsList is empty");
//    } else {
//        for (Product g : goodsList) {
//            System.out.println(g.getName() + " - " + g.getPrice()+ " - "+ g.getSupplier_id());
//        }
//    }
//     int threshold = 6;
//
//        List<Goods> lowStockList = dao.getLowQuantityGoods(threshold);
//
//        if (lowStockList.isEmpty()) {
//            System.out.println("✅ No low stock items found (under " + threshold + ").");
//        } else {
//            System.out.println("⚠ Low Stock Items (Quantity < " + threshold + "):");
//            for (Product g : lowStockList) {
//                System.out.println(" - ID: " + g.getGood_id() +
//                                   ", Name: " + g.getName() +
//                                   ", Qty: " + g.getQuantity());
//            }
//        }
//    }

        // Test user ID and field
//        int testUserId = 1;
//        String testField = "password_hash";  // Ensure this matches the column name in your DB
//        String testValue = "Test@1234";
//
//        try {
//            dao.updateUser(testUserId, testField, testValue);
//            System.out.println(">>> Update attempted on user_id=" + testUserId + ", field=" + testField + ", value=" + testValue);
//        } catch (Exception e) {
//            System.out.println(">>> Exception occurred during update:");
//            e.printStackTrace();
//        }
//    }
//   int userId = 1;
//        String fullname = "Alice Nguyen";
//        String email = "alice@example.com";
//        String phoneNumber = "0912345678";
//        String password = "securePassword123";
//        String gender = "Female";
//        String role = "Customer";
//        String address = "123 Le Loi, Ho Chi Minh City";
//        Date dob = Date.valueOf("2000-01-01");
//        String status = "Active";
//
//        // Create a user object
//        User user = new User(userId, fullname, email, phoneNumber, password, gender, role, address, dob, status);
//
//        // Output user data
//        System.out.println("User ID: " + user.getUser_id());
//        System.out.println("Full Name: " + user.getFullname());
//        System.out.println("Email: " + user.getEmail());
//        System.out.println("Phone Number: " + user.getPhonenumber());
//        System.out.println("Password: " + user.getPassword());
//        System.out.println("Gender: " + user.getGender());
//        System.out.println("Role: " + user.getRole());
//        System.out.println("Address: " + user.getAddress());
//        System.out.println("Date of Birth: " + user.getDob());
//        System.out.println("Status: " + user.getStatus());
//        List<Suppliers> suppliers = dao.getAllSuppliers();
//
//        for (Suppliers s : suppliers) {
//            System.out.println("ID: " + s.getSupplierID());
//            System.out.println("Name: " + s.getSname());
//            System.out.println("Address: " + s.getAddress());
//            System.out.println("------------------------");
//        List<Product> prod = dao.getAllGoods();
//        for(Product p: prod){
//            System.out.println("name "+ p.getComboName());
//            System.out.println(" decs" + p.getDescription());
//        }
//        List<Shop> shop = dao.getAllShops();
//        for(Shop sh : shop){
//            System.out.println("name "+ sh.getShopId());
//            System.out.println(" decs" + sh.getShopName());
//        }
        int shopId = 1; // Must exist in your Shops table
        int placedByUserId = 9999; // Must exist in Users table (e.g., system user)

        // Create dummy order items
        List<OrderItem> items = new ArrayList<>();

        OrderItem item1 = new OrderItem();
        item1.setGoodId(1);  // Use a real goodId from your Furniture table
        item1.setQuantity(2);
        item1.setUnitPrice(150.00);
        items.add(item1);

        OrderItem item2 = new OrderItem();
        item2.setGoodId(2);  // Another real goodId
        item2.setQuantity(1);
        item2.setUnitPrice(300.00);
        items.add(item2);

        double total = 2 * 150.00 + 1 * 300.00;

        int orderId = dao.placeShopOrder(shopId, placedByUserId, items, total);

        if (orderId > 0) {
            System.out.println("✅ Order placed successfully. Order ID: " + orderId);
        } else {
            System.out.println("❌ Failed to place order.");
        }
    }
}

