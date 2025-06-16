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
public class Goods {
    private int good_id;
    private String good_name;
    private String description;
    private String category;
    private double price;
    private int quantity;
    private int supplier_id;
    private Date added_on;

    public Goods(int good_id, String good_name, String description, String category, double price, int quantity, int supplier_id, Date added_on) {
        this.good_id = good_id;
        this.good_name = good_name;
        this.description = description;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
        this.supplier_id = supplier_id;
        this.added_on = added_on;
    }

    public int getGood_id() {
        return good_id;
    }

    public void setGood_id(int good_id) {
        this.good_id = good_id;
    }

    public String getGood_name() {
        return good_name;
    }

    public void setGood_name(String good_name) {
        this.good_name = good_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getSupplier_id() {
        return supplier_id;
    }

    public void setSupplier_id(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public Date getAdded_on() {
        return added_on;
    }

    public void setAdded_on(Date added_on) {
        this.added_on = added_on;
    }

    @Override
    public String toString() {
        return "Goods{" + "good_id=" + good_id + ", good_name=" + good_name + ", description=" + description + ", category=" + category + ", price=" + price + ", quantity=" + quantity + ", supplier_id=" + supplier_id + ", added_on=" + added_on + '}';
    }
    
    
}
