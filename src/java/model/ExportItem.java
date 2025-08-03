/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class ExportItem {
    private int exportItemId;
    private int exportId;
    private int furnitureId;
    private int quantity;
    private double unitPrice;
    private Product product;

    public ExportItem(int exportItemId, int exportId, int furnitureId, int quantity, double unitPrice, Product product) {
        this.exportItemId = exportItemId;
        this.exportId = exportId;
        this.furnitureId = furnitureId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.product = product;
    }

    public ExportItem() {
    }

    public int getExportItemId() {
        return exportItemId;
    }

    public void setExportItemId(int exportItemId) {
        this.exportItemId = exportItemId;
    }

    public int getExportId() {
        return exportId;
    }

    public void setExportId(int exportId) {
        this.exportId = exportId;
    }

    public int getFurnitureId() {
        return furnitureId;
    }

    public void setFurnitureId(int furnitureId) {
        this.furnitureId = furnitureId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }
    
}
