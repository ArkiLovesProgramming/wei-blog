package controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import utility.MailUtility;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@RestController
@RequestMapping("/Mail")
public class MailController {
    MailUtility mailUtility = new MailUtility();

    @RequestMapping(value = "/sendMail", method = RequestMethod.POST, produces = "text/html;charset=UTF-8")
    public String sendMail(String name, String password, String email, String emailtoken, HttpServletResponse response) throws IOException, MessagingException {
        mailUtility.sendMail(name,email,password,emailtoken);
        System.out.println("到达邮箱发送controller！");
        return "true";
    }
}
