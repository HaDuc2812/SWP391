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
public class ImportBill {
    private int importId;
    private int supplierId;
    private Timestamp importDate;
    private double totalAmount;
    private int createdBy;
    private String status;
    private List<ImportItem> items;
    private Suppliers supplier;

    public ImportBill(int importId, int supplierId, Timestamp importDate, double totalAmount, int createdBy, String status, List<ImportItem> items, Suppliers supplier) {
        this.importId = importId;
        this.supplierId = supplierId;
        this.importDate = importDate;
        this.totalAmount = totalAmount;
        this.createdBy = createdBy;
        this.status = status;
        this.items = items;
        this.supplier = supplier;
    }

    public ImportBill() {
    }

    public int getImportId() {
        return importId;
    }

    public void setImportId(int importId) {
        this.importId = importId;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public Timestamp getImportDate() {
        return importDate;
    }

    public void setImportDate(Timestamp importDate) {
        this.importDate = importDate;
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

    public List<ImportItem> getItems() {
        return items;
    }

    public void setItems(List<ImportItem> items) {
        this.items = items;
    }

    public Suppliers getSupplier() {
        return supplier;
    }

    public void setSupplier(Suppliers supplier) {
        this.supplier = supplier;
    }
    
}
