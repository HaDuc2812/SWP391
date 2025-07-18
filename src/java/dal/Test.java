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
import java.sql.SQLException;
import java.util.ArrayList;
import model.OrderItem;
import model.Shop;
import model.Suppliers;

/**
 *
 * @author HA DUC
 */
public class Test {

    public static void main(String[] args) throws SQLException {
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
////      // Step 1: Prepare test values
//        int shopId = 1;                 // assume shop ID 1 exists
//        int placedByUserId = 8;      // assume user ID 9999 exists
//        List<OrderItem> items = new ArrayList<>();
//
//        // Create sample OrderItems (orderItemId = 0, orderId = 0 since not used in this context)
//        items.add(new OrderItem(0, 0, 101, 5, 10.0));   // good_id=101, quantity=5, unit_price=10.0
//        items.add(new OrderItem(0, 0, 102, 3, 15.5));   // good_id=102, quantity=3, unit_price=15.5
//
//        // Step 2: Calculate total cost
//        double totalCost = 0;
//        for (OrderItem item : items) {
//            totalCost += item.getQuantity() * item.getUnitPrice();
//        }
//
//        // Step 3: Call DAO method
//        int orderId = dao.placeShopOrder(shopId, placedByUserId, items, totalCost);
//
//        // Step 4: Output result
//        if (orderId != -1) {
//            System.out.println("✅ Order placed successfully. Order ID: " + orderId);
//        } else {
//            System.out.println("❌ Failed to place order.");
//        }
//    }
        int testOrderId = 41; // Replace with an existing order_id from your DB

        List<OrderItem> items = dao.getOderItemsByOrderId(testOrderId);

        if (items.isEmpty()) {
            System.out.println("No order items found for order ID: " + testOrderId);
        } else {
            System.out.println("Order Items for Order ID: " + testOrderId);
            for (OrderItem item : items) {
                System.out.println("Item ID: " + item.getOrderItemId());
                System.out.println("Good ID: " + item.getGood_id());
                System.out.println("Quantity: " + item.getQuantity());
                System.out.println("Unit Price: " + item.getUnitPrice());
                System.out.println("Total Cost (same for all items): " + item.getTotalPrice());
                System.out.println("----------------------------");
            }
        }
    }
}
