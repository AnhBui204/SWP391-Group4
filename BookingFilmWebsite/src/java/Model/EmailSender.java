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
        final String username = "kurokogaming204@gmail.com";
        final String password = "eczx xihs nuuj pfvo";

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
            message.setFrom(new InternetAddress(username, "OTP Sender"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("OTP Verification");
            message.setText("Your OTP for verification is: " + otp_code);

            Transport.send(message);

            System.out.println("Email sent to " + recipientEmail);

        } catch (UnsupportedEncodingException | MessagingException e) {
        }
    }

//    public static String generateOTP() {
//        // Tạo mã OTP ngẫu nhiên
//        Random random = new Random();
//        int otpLength = 6; // Độ dài của mã OTP
//        StringBuilder otp = new StringBuilder();
//
//        for (int i = 0; i < otpLength; i++) {
//            otp.append(random.nextInt(10)); // Tạo số ngẫu nhiên từ 0 đến 9
//        }
//
//        return otp.toString();
//    }
}