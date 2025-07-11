/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author HA DUC
 */
public class Product {

    private int comboID;
    private String comboName;
    private String poster;
    private String description;
    private String status;
    private String brand;
    private String category;
    private String material;
    private int stockQuantity;
    private double cost;
    private Date createdDate;
    private Date lastUpdated;

    public Product() {
    }

    public Product(int comboID, String comboName, String poster, String description, String status, String brand, String category, String material, int stockQuantity, double cost, Date createdDate, Date lastUpdated) {
        this.comboID = comboID;
        this.comboName = comboName;
        this.poster = poster;
        this.description = description;
        this.status = status;
        this.brand = brand;
        this.category = category;
        this.material = material;
        this.stockQuantity = stockQuantity;
        this.cost = cost;
        this.createdDate = createdDate;
        this.lastUpdated = lastUpdated;
    }

    public int getComboID() {
        return comboID;
    }

    public void setComboID(int comboID) {
        this.comboID = comboID;
    }

    public String getComboName() {
        return comboName;
    }

    public void setComboName(String comboName) {
        this.comboName = comboName;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public Date getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(Date lastUpdated) {
        this.lastUpdated = lastUpdated;
    }

    
}
