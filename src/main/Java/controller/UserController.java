package controller;


import config.S3ClientGetter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributesModelMap;
import pojo.Content;
import pojo.Notification;
import pojo.Page;
import pojo.User;
import service.ContentService;
import service.NotificationService;
import service.UserService;
import utility.DateUtility;
import utility.RandomUtility;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/User")
public class UserController {
    //controller 调用 service 层
    @Autowired//开启自动装配
    @Qualifier("UserServiceImpl")//指定service里定义的bean
//    将spring-service.xml指明的id为BookServiceImpl的bean映射到此处定义的其接口类
    private UserService userService;

    @Autowired//开启自动装配
    @Qualifier("ContentServiceImpl")//指定service里定义的bean
    private ContentService contentService;

    @Autowired//开启自动装配
    @Qualifier("NotificationServiceImpl")//指定service里定义的bean
    private NotificationService notificationService;

    private DateUtility dateUtility = new DateUtility();

    private RandomUtility randomUtility = new RandomUtility();
    @ResponseBody
    @RequestMapping("/addUser")
    public HashMap addUser(Model model, @RequestBody HashMap<String, String> map){
        String name = map.get("name");
        String email = map.get("email");
        String password = map.get("password");
        RandomUtility randomUtility = new RandomUtility();
        User user = new User();
        user.setId(randomUtility.createId());
        user.setName(name);
        user.setEmail(email);
        user.setRegion("");
        user.setPassword(password);
        user.setProfilePicUrl("users/image/default_profile.jpg");
        user.setBgPicUrl("images/profile/defaultBg.png");
        user.setLikedContentIds("");
        user.setCreatingTime(dateUtility.getDate());
        user.setFollowerNum(0);
        user.setFollowerIds("");
        user.setFollowingNum(0);
        user.setFollowingIds("");
        user.setTopicIds("");
        user.setSignature("");
        user.setGender(-1);
        user.setActivated(Integer.valueOf(randomUtility.createIdByNum(8)));   //inactivated account by default

        HashMap result = new HashMap<String, String>();

        try {
            userService.addUser(user);
        } catch (Exception e) {
            System.out.println("error-----"+e);
            model.addAttribute("message","Fail to login in！");
            result.put("code", 0);
            return result;
        }
        model.addAttribute("message","立即登录！");

        //        通知被关注对象
        Notification notification = new Notification();
        notification.setTargetUserId(user.getId());
        notification.setUserId("");
        notification.setTextContent("恭喜您完成WEIBlog注册，快看看有些什么有趣的事情正在发生吧！");
        notification.setType(0);
        try {
            notificationService.notify(notification);
        } catch (Exception e) {
            e.printStackTrace();
        }
        result.put("code", 1);
        result.put("emailtoken", user.getActivated());
        return result;
    }

    /**
     * @param email
     * @param request
     * @return
     * after verifying the email, the account can be activated
     */
    @RequestMapping("/activateUser")
    public String activateUser(String email, String emailtoken, HttpServletRequest request){
        User user = userService.getUserByEmail(email);
        if (String.valueOf(emailtoken).equals(user.getActivated())){
            return "wrongemail";
        }
        user.setActivated(1);
        userService.updateUser(user);
        return "rightemail";
    }

    @ResponseBody
    @RequestMapping("/checkUser")
    public HashMap checkUser(String email, String password, HttpServletRequest request){
        HttpSession session=request.getSession();
        User user = userService.checkUser(email,password);
        // 从 s3 中解析图片
        user.setBgPicUrl(S3ClientGetter.getS3PresignedUrl(user.getBgPicUrl()));
        user.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(user.getProfilePicUrl()));
        session.setAttribute("user",user);
        HashMap map = new HashMap<>();
        map.put("user", user);

        if (user != null && user.getActivated() == 1){
            System.out.println("验证成功！");
            map.put("code", "1");
            //获取是否有通知
            Integer notisNum = notificationService.notisNumByTUId(user.getId());
            if (notisNum != null) {
                session.setAttribute("notificationNum",notisNum);
            }
        } else {
            System.out.println("验证失败！");
            map.put("code", "0");
        }
        return map;
    }

    @RequestMapping("/logout")
    public String logout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.invalidate();
        return "redirect:../explore.jsp";
    }


    @ResponseBody
    @RequestMapping("/updateUser")
    public String updateUser(@RequestBody(required = false) User user, HttpServletRequest request){
        HttpSession session = request.getSession();
        User thisuser = (User) session.getAttribute("user");
        if (thisuser == null) {
            return "{\"myStatus\":\"error\"}";
        }
        if (thisuser.getName().equals(user.getName())) user.setName(null);
        if (thisuser.getSignature().equals(user.getSignature())) user.setSignature(null);
        if (thisuser.getRegion().equals(user.getRegion())) user.setRegion(null);
        if (thisuser.getGender().equals(user.getGender())) user.setGender(null);
        if (user.getProfilePicUrl().equals("")) user.setProfilePicUrl(null);    // 这里故意等于空的，可以让 mybatis 不去更新对应值
        if (user.getBgPicUrl().equals("")) user.setBgPicUrl(null);
        user.setId(thisuser.getId());
        try {
            userService.updateUser(user);
        } catch (Exception e){
            e.printStackTrace();
        }
        user = userService.getUserById(thisuser.getId());
        user.setBgPicUrl(S3ClientGetter.getS3PresignedUrl(user.getBgPicUrl()));
        user.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(user.getProfilePicUrl()));
        session.setAttribute("user", user);
        return "{\"myStatus\":\"success\"}";
    }

    @RequestMapping("/detailUser/{userId}")
    public String detailUser(@PathVariable String userId, HttpServletRequest request){
        request.setAttribute("indexType","normal");
        HttpSession session = request.getSession();
        User thisUser = userService.getUserById(userId);
        thisUser.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(thisUser.getProfilePicUrl()));
        thisUser.setBgPicUrl(S3ClientGetter.getS3PresignedUrl(thisUser.getBgPicUrl()));
        request.setAttribute("detailUser",thisUser);
        Map<String, Object> conIdMapUser = new HashMap<>();
        List<String> userIds = new ArrayList<String>();
        userIds.add(userId);
        List<Content> contents = contentService.conByAuthIds(userIds,null);
        for (Content content : contents) {
            // 保证这个 level2com content 的图片视频正常显示
            if (!content.getVideoURL().equals("0")) {
                content.setVideoURL(S3ClientGetter.getS3PresignedUrl(content.getVideoURL()));
            }
            if (!content.getPictureURL().equals("0")) {
                content.setPictureURL(S3ClientGetter.getS3PresignedUrl(content.getPictureURL()));
            }
            if (!content.getParentId().equals("0")){
                String pConAuthorId = contentService.getSField("authorId", content.getParentId());
                User author = userService.getUserById(pConAuthorId);
                author.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(author.getProfilePicUrl()));
                conIdMapUser.put(content.getParentId(),author);
            }
        }

        List<String> showPics = new ArrayList<String>();
        Page page = new Page();
        page.setPageSize(6);
        List<Content> mediaContents = contentService.mediaConByAuthId(userId,page);
        for (Content content : mediaContents) {
            if (!content.getPictureURL().equals("0")){
                if (content.getPictureURL().indexOf(",")!=-1){
                    showPics.add(S3ClientGetter.getS3PresignedUrl(content.getPictureURL().split(",")[0]));
                    showPics.add(S3ClientGetter.getS3PresignedUrl(content.getPictureURL().split(",")[1]));
                } else {
                    showPics.add(S3ClientGetter.getS3PresignedUrl(content.getPictureURL()));
                }
            }
        }
        session.setAttribute("showPics",showPics);
        request.setAttribute("indexConIdMapUser",conIdMapUser);
        request.setAttribute("indexContents",contents);
        return "index";
    }

    @RequestMapping("/detailUser/{userId}/{type}")
    public String detailUserByType(@PathVariable String userId,@PathVariable String type,HttpServletRequest request){
        request.setAttribute("indexType",type);
        User thisUser = userService.getUserById(userId);
        thisUser.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(thisUser.getProfilePicUrl()));
        thisUser.setBgPicUrl(S3ClientGetter.getS3PresignedUrl(thisUser.getBgPicUrl()));
        request.setAttribute("detailUser",thisUser);
        if (type.equals("likes")){
            String likedCons = userService.getSField("likedContentIds",userId);
            List<String> likedContentIds = new ArrayList(Arrays.asList(likedCons.split(",")));
            List<Content> contents = contentService.conByIds(likedContentIds);
            Map<String, Object> indexConIdMapUser = new HashMap<>();
            for (Content content : contents){
                User author = userService.getUserById(content.getAuthorId());
                author.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(author.getProfilePicUrl()));
                indexConIdMapUser.put(content.getId(),author);
                if (!content.getParentId().equals("0")){
                    String pConAuthorId = contentService.getSField("authorId",content.getParentId());
                    User pcAuthor = userService.getUserById(pConAuthorId);
                    pcAuthor.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(pcAuthor.getProfilePicUrl()));
                    indexConIdMapUser.put(content.getParentId(),pcAuthor);
                }
            }
            request.setAttribute("indexConIdMapUser",indexConIdMapUser);
            request.setAttribute("indexContents",contents);
        } else if (type.equals("medias")){
            Map<String, Object> conIdMapUser = new HashMap<>();
            List<Content> mediaContents = contentService.mediaConByAuthId(userId,null);
            for (Content content : mediaContents) {
                if (!content.getParentId().equals("0")){
                    String pConAuthorId = contentService.getSField("authorId", content.getParentId());
                    User author = userService.getUserById(pConAuthorId);
                    author.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(author.getProfilePicUrl()));
                    conIdMapUser.put(content.getParentId(),author);
                }
            }
            request.setAttribute("indexConIdMapUser",conIdMapUser);
            request.setAttribute("indexContents",mediaContents);
        }
        return "index";
    }

    @RequestMapping("/followUser/{userId}")
    @ResponseBody
    public Map followUser(@PathVariable String userId,HttpServletRequest request){
//        我的关注列表
        HttpSession session = request.getSession();
        Map map = new HashMap();
        User user = (User) session.getAttribute("user");
        String followingIds = user.getFollowingIds();
        int followingNum = user.getFollowingNum();
        followingNum++;
        if (followingIds.indexOf(userId) != -1){
            map.put("code","0");
            return map;
        }
        followingIds = followingIds + "," + userId;
        if (followingIds.startsWith(",")){
            followingIds = followingIds.substring(1);
        }
        User updateUser1 = new User();
        updateUser1.setId(user.getId());
        updateUser1.setFollowingIds(followingIds);
        updateUser1.setFollowingNum(followingNum);
//        重新改一下session的值
        user.setFollowingIds(followingIds);
        user.setFollowingNum(followingNum);
        session.setAttribute("user",user);
        try {
            userService.updateUser(updateUser1);
        } catch (Exception e) {
            e.printStackTrace();
        }

//        目标用户的粉丝改变
        User targetUser = userService.getUserById(userId);
        String followerIds = targetUser.getFollowerIds();
        int followerNum = targetUser.getFollowerNum();
        followerNum++;
        followerIds = followerIds + ","+user.getId();
        if (followerIds.startsWith(",")){
            followerIds = followerIds.substring(1);
        }
        User updateUser2 = new User();
        updateUser2.setId(targetUser.getId());
        updateUser2.setFollowerIds(followerIds);
        updateUser2.setFollowerNum(followerNum);
        try {
            userService.updateUser(updateUser2);
        } catch (Exception e) {
            e.printStackTrace();
        }

//        通知被关注对象
        Notification notification = new Notification();
        notification.setTargetUserId(targetUser.getId());
        notification.setUserId(user.getId());
        notification.setType(1);
        try {
            notificationService.notify(notification);
        } catch (Exception e) {
            e.printStackTrace();
        }

        map.put("code","1");
        return map;
    }
    @RequestMapping("/unfollowUser/{userId}")
    @ResponseBody
    public Map unfollowUser(@PathVariable String userId,HttpServletRequest request){
        HttpSession session = request.getSession();
        Map map = new HashMap();
        User user = (User) session.getAttribute("user");
        String followingIds = user.getFollowingIds();
        int followingNum = user.getFollowingNum();
        if (followingIds.indexOf(userId) == -1 || followingNum < 1){
            map.put("code","0");
            return map;
        }
        followingNum--;
        followingIds = followingIds.replace(userId,"");
        if (followingIds.endsWith(",")){
            followingIds = followingIds.substring(0 ,followingIds.length() - 1 );
        }
        if (followingIds.indexOf(",,") != -1){
            followingIds = followingIds.replace(",,",",");
        }
        if (followingIds.startsWith(",")){
            followingIds = followingIds.substring(1);
        }
        User updateUser1 = new User();
        updateUser1.setId(user.getId());
        updateUser1.setFollowingIds(followingIds);
        updateUser1.setFollowingNum(followingNum);
        //        重新改一下session的值
        user.setFollowingIds(followingIds);
        user.setFollowingNum(followingNum);
        session.setAttribute("user",user);
        try {
            userService.updateUser(updateUser1);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //        目标用户的粉丝改变
        User targetUser = userService.getUserById(userId);
        String followerIds = targetUser.getFollowerIds();
        int followerNum = targetUser.getFollowerNum();
        if (followerNum < 1) {
            map.put("code","0");
            return map;
        }
        followerNum--;
        followerIds = followerIds.replace(user.getId(),"");
        if (followerIds.endsWith(",")){
            followerIds = followerIds.substring(0 ,followerIds.length() - 1 );
        }
        if (followerIds.indexOf(",,") != -1){
            followerIds = followerIds.replace(",,",",");
        }
        if (followerIds.startsWith(",")){
            followerIds = followerIds.substring(1);
        }
        User updateUser2 = new User();
        updateUser2.setId(targetUser.getId());
        updateUser2.setFollowerIds(followerIds);
        updateUser2.setFollowerNum(followerNum);
        try {
            userService.updateUser(updateUser2);
        } catch (Exception e) {
            e.printStackTrace();
        }

        //        通知被关注对象
        Notification notification = new Notification();
        notification.setTargetUserId(targetUser.getId());
        notification.setUserId(user.getId());
        notification.setType(2);
        try {
            notificationService.notify(notification);
        } catch (Exception e) {
            e.printStackTrace();
        }


        map.put("code","1");
        return map;
    }
}
