package model;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import model.OrderItem;

public class Order {

    private int orderId;
    private Integer supplierId;
    private Integer shopid;
    private Date orderDate;
    private String status; // "Placed", "Shipped", "Received"
    private double totalCost;
    private int placedBy;
    private String orderType; // "SUPPLIER" or "STORE"
    private List<OrderItem> items;

    // Constructors
    public Order() {
        this.orderDate = new Date(); // Default to current date/time
        this.status = "Placed";      // Default status
    }

    public Order(int supplierId, double totalCost, int placedBy, String orderType) {
        this();
        this.supplierId = supplierId;
        this.totalCost = totalCost;
        this.placedBy = placedBy;
        this.orderType = orderType;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

   

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        if (!status.equals("Placed") && !status.equals("Shipped") && !status.equals("Received")) {
            throw new IllegalArgumentException("Invalid order status");
        }
        this.status = status;
    }

    public double getTotalCost() {
        return totalCost;
    }

    public void setTotalCost(double totalCost) {
        if (totalCost < 0) {
            throw new IllegalArgumentException("Total cost cannot be negative");
        }
        this.totalCost = totalCost;
    }

        public int getPlacedBy() {
        return placedBy;
    }

    public void setPlacedBy(int placedBy) {
        this.placedBy = placedBy;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        if (!orderType.equals("SUPPLIER") && !orderType.equals("STORE")) {
            throw new IllegalArgumentException("Invalid order type");
        }
        this.orderType = orderType;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public Integer getShopid() {
        return shopid;
    }

    public void setShopid(Integer shopid) {
        this.shopid = shopid;
    }

   
}
