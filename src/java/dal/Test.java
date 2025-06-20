/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Goods;

/**
 *
 * @author HA DUC
 */
public class Test {
    public static void main(String[] args) {
    DAO dao = new DAO();
    List<Goods> goodsList = dao.getAllGoods();

    if (goodsList == null) {
        System.out.println("goodsList is null");
    } else if (goodsList.isEmpty()) {
        System.out.println("goodsList is empty");
    } else {
        for (Goods g : goodsList) {
            System.out.println(g.getName() + " - " + g.getPrice()+ " - "+ g.getSupplier_id());
        }
    }
}
}
