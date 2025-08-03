/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ExportBill {
    private int exportId;
    private int shopId;
    private Timestamp exportDate;
    private double totalAmount;
    private int createdBy;
    private String status;
    private List<ExportItem> items;
    private Shop shop;

    public ExportBill(int exportId, int shopId, Timestamp exportDate, double totalAmount, int createdBy, String status, List<ExportItem> items, Shop shop) {
        this.exportId = exportId;
        this.shopId = shopId;
        this.exportDate = exportDate;
        this.totalAmount = totalAmount;
        this.createdBy = createdBy;
        this.status = status;
        this.items = items;
        this.shop = shop;
    }

    public ExportBill() {
    }

    public int getExportId() {
        return exportId;
    }

    public void setExportId(int exportId) {
        this.exportId = exportId;
    }

    public int getShopId() {
        return shopId;
    }

    public void setShopId(int shopId) {
        this.shopId = shopId;
    }

    public Timestamp getExportDate() {
        return exportDate;
    }

    public void setExportDate(Timestamp exportDate) {
        this.exportDate = exportDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<ExportItem> getItems() {
        return items;
    }

    public void setItems(List<ExportItem> items) {
        this.items = items;
    }

    public Shop getShop() {
        return shop;
    }

    public void setShop(Shop shop) {
        this.shop = shop;
    }
    
}
