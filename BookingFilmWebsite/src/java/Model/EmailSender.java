/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author pc
 */
import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.Random;
import java.util.UUID;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailSender {
    // Phương thức gửi email chứa mã OTP

    public static void sendOtpToEmail(String recipientEmail, String otp_code) {
//        final String username = "kurokogaming204@gmail.com";
//        final String password = "eczx xihs nuuj pfvo";
        final String username = "hoangquyettien.93.04@gmail.com";
        final String password = "idgz kjbb hxdu xtvu";
        
        System.out.println(recipientEmail);
        System.out.println(otp_code);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
                
            }
            
        };
        
        Session session = Session.getInstance(props, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username, "CINELUXE"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Xác thực OTP");
            message.setText("Mã OTP của bạn là: " + otp_code + ". Mã sẽ hết hạn sau 15 phút.");

            Transport.send(message);

            System.out.println("Email sent to " + recipientEmail);

        } catch (UnsupportedEncodingException | MessagingException e) {
        }
    }
    
    public static void replyEmail(String recipientEmail, String rmessage) {
//        final String username = "kurokogaming204@gmail.com";
//        final String password = "eczx xihs nuuj pfvo";
        final String username = "hoangquyettien.93.04@gmail.com";
        final String password = "idgz kjbb hxdu xtvu";
        
        System.out.println(recipientEmail);
        System.out.println(rmessage);

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Authenticator auth = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
                
            }
            
        };
        
        Session session = Session.getInstance(props, auth);

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username, "CINELUXE"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Hỗ trợ từ CINELUXE");
            message.setText(rmessage);

            Transport.send(message);

            System.out.println("Email sent to " + recipientEmail);

        } catch (UnsupportedEncodingException | MessagingException e) {
        }
    }
    
}