/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class ImportItem {
    private int importItemId;
    private int importId;
    private int furnitureId;
    private int quantity;
    private double unitPrice;
    private Product product;

    public ImportItem(int importItemId, int importId, int furnitureId, int quantity, double unitPrice, Product product) {
        this.importItemId = importItemId;
        this.importId = importId;
        this.furnitureId = furnitureId;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.product = product;
    }

    public ImportItem() {
    }

    public int getImportItemId() {
        return importItemId;
    }

    public void setImportItemId(int importItemId) {
        this.importItemId = importItemId;
    }

    public int getImportId() {
        return importId;
    }

    public void setImportId(int importId) {
        this.importId = importId;
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
