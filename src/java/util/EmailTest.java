/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package util;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;
/**
 *
 * @author HA DUC
 */
public class EmailTest {
    public static void main(String[] args) {
        boolean success = EmailUtil.sendEmail("haduc8384@email.com", "Test", "This is test");
        System.out.println("Email success: " + success);
    }
}

