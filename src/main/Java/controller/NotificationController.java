package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import pojo.Notification;
import pojo.User;
import service.ContentService;
import service.NotificationService;
import service.UserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class NotificationController {
    //controller 调用 service 层
    @Autowired//开启自动装配
    @Qualifier("NotificationServiceImpl")//指定service里定义的bean
//    将spring-service.xml指明的id为BookServiceImpl的bean映射到此处定义的其接口类
    private NotificationService notificationService;

    @Autowired//开启自动装配
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @RequestMapping("/Notifications")
    public String Notifications(HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null){
            return "redirect:/User/logout";
        }
        List<Notification> notifications = notificationService.notisByTUId(user.getId());
        Map<String, Object> notisIdMapUser = new HashMap<>();
        for (Notification notification : notifications) {
            if (!notification.getUserId().equals("")){
                String userId = notification.getUserId();
                User thisuser = userService.getUserById(userId);
                notisIdMapUser.put(notification.getId(),thisuser);
            }
        }
        request.setAttribute("notifications",notifications);
        request.setAttribute("notisIdMapUser",notisIdMapUser);

//        批量阅读所有未读内容
        Notification updateNoti = new Notification();
        updateNoti.setNull();
        updateNoti.setTargetUserId(user.getId());
        updateNoti.setReaded(1);
        notificationService.updateNotification(updateNoti);
        session.setAttribute("notificationNum",0);
        return "notifications";
    }

}
