package utility;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.io.UnsupportedEncodingException;
import java.util.Properties;

public class MailUtility {

    static String baseURL = "http://3.98.136.76:80";

    public boolean sendMail(String name,String email,String password, String emailtoken) throws MessagingException, UnsupportedEncodingException {
        Properties props = new Properties();
        // 开启debug调试
        props.setProperty("mail.debug", "true");
        // 发送服务器需要身份验证
        props.setProperty("mail.smtp.auth", "true");
        // 设置邮件服务器主机名
        props.setProperty("mail.host", "imap.sohu.com");
        props.setProperty("mail.smtp.ssl.enable", "true");
        props.setProperty("mail.smtp.ssl.protocols", "TLSv1.2");
        props.setProperty("mail.smtp.port", "465");
        // 发送邮件协议名称
        props.setProperty("mail.transport.protocol", "smtp");


        // 设置环境信息
        Session session = Session.getInstance(props);

        // 创建邮件对象
        Message msg = new MimeMessage(session);
        msg.setSubject("WEIBlog registration email verification");
        // 设置邮件内容
        //msg.setText("您的昵称是："+name+"您的邮箱账号是："+email+" 您的登录密码是:"+password+" 您可以点击链接进行验证注册:"+"12312312312313.com");
        String href = baseURL + "/User/activateUser?email=" + email + "&emailtoken=" + emailtoken;
        String htmlText = "<div style=\"text-align: center;height: 46px;color: #3f9bff;font-size: 30px;font-weight: 900;line-height: 46px;\">\n" +
                "\t\t\tWEI\n" +
                "\t\t</div>\n" +
                "\t\t<div style=\"padding: 0px 16px;\">\n" +
                "\t\t\tdear <b>"+name+"</b> Hello! This is an email verification information, please make sure the following information is filled in correctly, and activate the account according to the operation!<br>\n" +
                "\t\t\t<table style=\"margin: 12px 0px;\">\n" +
                "\t\t\t\t<tr><td>Your email:</td><td><b>"+email+"</b></td></tr>\n" +
                "\t\t\t\t<tr><td>Your name:</td><td><b>"+name+"</b></td></tr>\n" +
//                "\t\t\t\t<tr><td>Your password:</td><td><b>"+password+"</b></td></tr>\n" +
                "\t\t\t</table>\n" +
                "\t\t\t<table style=\"width: 100%;margin: 12px 0px;\">\n" +
                "\t\t\t\t<tr><td>You can verify your registration by clicking on the link below:</td></tr>\n" +
                "\t\t\t\t<tr><td><a style=\"cursor: pointer;color: #499BEA;\" href='"+href+"'><b>Finish registration!</b></a></td></tr>\n" +
//                "\t\t\t\t<tr><td>or copy the address to your browser:</td></tr>\n" +
//                "\t\t\t\t<tr><td><b style=\"text-decoration: underline;\">"+href+"</b></td></tr>\n" +
                "\t\t\t</table>\n" +
                "\t\t</div>";


        msg.setContent(htmlText,"text/html;charset=UTF-8");
        // 设置发件人（账号）
        msg.setFrom(new InternetAddress("13168034666@sohu.com", "WEIBlog Authentication"));

        Transport transport = session.getTransport();
        // 连接邮件服务器(账号，授权码)
        transport.connect("13168034666@sohu.com", "NMP08CUTJ6L");
        // 发送邮件
        transport.sendMessage(msg, new Address[] {new InternetAddress(email)});
        // 关闭连接
        transport.close();
        return true;
    }

    public static void main(String[] args) throws MessagingException, UnsupportedEncodingException {
        MailUtility m = new MailUtility();
        m.sendMail("123","1090409167@qq.com","123", "dddd");
    }
}
