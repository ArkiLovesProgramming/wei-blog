package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import pojo.Content;
import pojo.Page;
import pojo.Topic;
import pojo.User;
import service.ContentService;
import service.TopicService;
import service.UserService;
import utility.DateUtility;
import utility.RandomUtility;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/Content")
public class ContentController {
    //controller 调用 service 层
    @Autowired//开启自动装配
    @Qualifier("ContentServiceImpl")//指定service里定义的bean
//    将spring-service.xml指明的id为BookServiceImpl的bean映射到此处定义的其接口类
    private ContentService contentService;

    @Autowired//开启自动装配
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @Autowired//开启自动装配
    @Qualifier("TopicServiceImpl")//指定service里定义的bean
    private TopicService topicService;


    @RequestMapping(value = "/sendContent",method = RequestMethod.POST)
    @ResponseBody
    public Content sendContent(@RequestBody(required = false) Content content){
        RandomUtility randomUtility = new RandomUtility();
        String id = randomUtility.createId();
        DateUtility dateUtility = new DateUtility();
        String curentDate = dateUtility.getDate();
        content.setId(id);
        content.setReleasingTime(curentDate);
        content.setLikeNum(0);
        content.setLikeIds("");
        content.setCommentNum(0);
        content.setCommentIds("");
        content.setTransmitNum(0);
        content.setTransmitIds("");
        content.setBookmarkNum(0);
        content.setBookmarkIds("");
        if (content.getTopicIds()!=""){
            String pTopicIds = "";
            List<String> topicIds = new ArrayList(Arrays.asList(content.getTopicIds().split(",")));
            for (String topicId : topicIds) {
                Topic topic = topicService.topicById(topicId);
                if (pTopicIds.indexOf(topic.getParentId())==-1){
                    pTopicIds = pTopicIds + topic.getParentId() + ",";
                }
            }
            pTopicIds = pTopicIds.substring(0,pTopicIds.length()-1);
            String str = content.getTopicIds();
            str = str + ","+pTopicIds;
            content.setTopicIds(str);
        }
        try {
            contentService.sendContent(content);
        } catch (Exception e) {
            e.printStackTrace();
        }
//        是评论的话，就要给父内容的commentIds，和commentNum改变
        if (!"0".equals(content.getParentId())){
            Content parentContent = contentService.conById(content.getParentId());
            Content newParent = new Content();
            newParent.setCommentNum(parentContent.getCommentNum()+1);
            String commentIds = parentContent.getCommentIds();
            commentIds = commentIds + ','+parentContent.getAuthorId();
            if(commentIds.startsWith(",")){
                commentIds = commentIds.substring(1);
            }
            newParent.setCommentIds(commentIds);
            newParent.setId(parentContent.getId());
            try {
                contentService.updateContent(newParent);
            } catch (Exception e) {
                e.printStackTrace();
            }

        }

//        如果是发布内容，就要改变topic的数据
        if ("0".equals(content.getParentId())){
            if (content.getTopicIds()!=""){
                List<String> topicIds = new ArrayList(Arrays.asList(content.getTopicIds().split(",")));
                for (String topicId : topicIds){
                    Topic topic = topicService.topicById(topicId);
                    Topic updateTopic = new Topic();
                    updateTopic.setId(topic.getId());
                    String contentIds = topic.getContentIds();
                    contentIds = contentIds + "," + content.getId();
                    if (contentIds.startsWith(",")){
                        contentIds = contentIds.substring(1);
                    }
                    updateTopic.setContentIds(contentIds);
                    int contentNum = topic.getContentNum();
                    contentNum++;
                    updateTopic.setContentNum(contentNum);
                    topicService.updateTopic(updateTopic);
                }
            }
        }

        return content;
    }

    @RequestMapping(value = "/getAllContents")
    @ResponseBody
    public String getAllContents(HttpServletRequest request) {
        List<Content> allContents = new ArrayList<>();
        allContents = contentService.getAllContents();
        HttpSession session = request.getSession();
        session.setAttribute("allContents",allContents);
//        System.out.println(allContents.toString());
        return "seccess";
    }

//    home页面的content都是自己和关注的人，按时间排序
//    使用ajax也一样，就是success里面加location
    @RequestMapping(value = "/getHomeContents")
    public String getHomeContents(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/User/logout";
        }
        List<String> followingIds = new ArrayList(Arrays.asList(user.getFollowingIds().split(",")));
        followingIds.add(user.getId());
        Page page = (Page) request.getAttribute("page");
        if (page==null){
            page = new Page();
        }
        List<Content> contents = new ArrayList<>();
        contents = contentService.conByAuthIds(followingIds,page);
//        for (Content content : contents){
//            System.out.println(content.getReleasingTime());
//        }
        session.setAttribute("homeContents",contents);
        Map<String, Object> conIdMapUser = new HashMap<>();
        for (Content content : contents) {
            User thisUser = userService.getUserById(content.getAuthorId());
            conIdMapUser.put(content.getId(),thisUser);
        }
        session.setAttribute("conIdMapUser",conIdMapUser);

        return "home";
    }

//    ajax动态注入内容
    @RequestMapping(value = "/getHomeContents/{currentPage}")
    @ResponseBody
    public Map HomeContentByPage(@PathVariable int currentPage,HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            Map<String, Object> map1 = new HashMap();
            map1.put("status","error");
            return map1;
        }
        List<String> followingIds = new ArrayList(Arrays.asList(user.getFollowingIds().split(",")));
        followingIds.add(user.getId());
        Page page = new Page();
        page.setCurrentPage(currentPage);
        List<Content> contents = new ArrayList<>();
        contents = contentService.conByAuthIds(followingIds,page);
        Map<String, Object> conIdMapUser = new HashMap<>();
        for (Content content : contents) {
            User thisUser = userService.getUserById(content.getAuthorId());
            conIdMapUser.put(content.getId(),thisUser);
        }
        Map<String, Object> map = new HashMap<>();
        map.put("contents",contents);
        map.put("conIdMapUser",conIdMapUser);
        return map;
    }

    @RequestMapping(value = "/likeContent")
    @ResponseBody
    public String likeContent(String contentId, String userId,HttpServletRequest request){
        if (contentId == null || userId == null){
            return "{'errorcode':'0'}";
        }
        HttpSession session = request.getSession();
        System.out.println("数据是===>"+contentId+" "+userId);
        User user =new User();
        user.setId(userId);
        String userLikedContentIds = userService.getSField("likedContentIds",userId);
        userLikedContentIds = userLikedContentIds +','+contentId;
        if (userLikedContentIds.startsWith(",")){
            userLikedContentIds = userLikedContentIds.substring(1);
        }
        user.setLikedContentIds(userLikedContentIds);
        try {
            userService.updateUser(user);
            User currentUser = userService.getUserById(userId);
            session.setAttribute("user",currentUser);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Content content = new Content();
        content.setId(contentId);

        String contentLikeIds ="";
        int contentlikeNum = 0;
        try {
            contentLikeIds = contentService.getSField("likeIds",contentId);
            contentlikeNum = contentService.getIField("likeNum",contentId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        contentLikeIds = contentLikeIds +','+userId;
        if (contentLikeIds.startsWith(",")){
            contentLikeIds = contentLikeIds.substring(1);
        }
        contentlikeNum = contentlikeNum + 1;
        content.setLikeIds(contentLikeIds);
        content.setLikeNum(contentlikeNum);
        System.out.println("contentlikeNum=======>"+contentlikeNum);
        try {
            contentService.updateContent(content);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "ture";
    }

    @RequestMapping(value = "/unlikeContent")
    @ResponseBody
    public String unlikeContent(String contentId, String userId,HttpServletRequest request){
        HttpSession session = request.getSession();
        System.out.println("数据是===>"+contentId+" "+userId);
        User user =new User();
        user.setId(userId);
        String userLikedContentIds = userService.getSField("likedContentIds",userId);
        System.out.println("1:"+userLikedContentIds);
        userLikedContentIds = userLikedContentIds.replace(""+contentId,"");
        System.out.println("2:"+userLikedContentIds);
        if (userLikedContentIds.indexOf(",,") != -1){
            userLikedContentIds = userLikedContentIds.replace(",,",",");
            System.out.println("3:"+userLikedContentIds);
        }
        if (userLikedContentIds.startsWith(",")){
            userLikedContentIds = userLikedContentIds.substring(1);
            System.out.println("4:"+userLikedContentIds);
        }
        if (userLikedContentIds.length() >= 1){
            if(userLikedContentIds.endsWith(",")) {
                userLikedContentIds = userLikedContentIds.substring(0, userLikedContentIds.length()-1);
                System.out.println("5:"+userLikedContentIds);
            }
        }
        if (user == null || userLikedContentIds == null){
            System.out.println("空！！！！！！！！！！！！！！！！！！！！！！！！");
        } else {
            System.out.println("有"+user.toString()+" userLikedContentIds:"+userLikedContentIds+"！！！！！！！！！！！！！！！！！！！！！！！！");
        }
        user.setLikedContentIds(userLikedContentIds+"");
        try {
            userService.updateUser(user);
            User currentUser = userService.getUserById(userId);
            session.setAttribute("user",currentUser);
        } catch (Exception e) {
            e.printStackTrace();
        }

        Content content = new Content();
        content.setId(contentId);
        String contentLikeIds = "";
        int contentlikeNum = 0;
        try {
            contentLikeIds = contentService.getSField("likeIds",contentId);
            contentlikeNum = contentService.getIField("likeNum",contentId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        contentLikeIds = contentLikeIds.replace(""+userId,"");
        if (contentLikeIds.startsWith(",")){
            contentLikeIds = contentLikeIds.substring(1);
        }
        if (contentLikeIds.length() >= 1){
            if(contentLikeIds.charAt(contentLikeIds.length()-1) == ',')
            contentLikeIds = contentLikeIds.substring(0, contentLikeIds.length()-1);
        }
        if (contentLikeIds.indexOf(",,") != -1){
            contentLikeIds = contentLikeIds.replace(",,",",");
        }
        contentlikeNum = contentlikeNum -1;
        content.setLikeIds(contentLikeIds);
        content.setLikeNum(contentlikeNum);
        System.out.println("contentlikeNum=======>"+contentlikeNum);
        try {
            contentService.updateContent(content);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "ture";
    }


    @RequestMapping(value = "/testContent")
    @ResponseBody
    public List<Content> testContent() {

        List<String> ids = new ArrayList<>();
        ids.add("68817854");
        List<Content> contents = new ArrayList<>();
//        contents = contentService.conByAuthIds(ids);
        for (Content content : contents){
            System.out.println(content.getReleasingTime());
        }
        return contents;

    }

    @RequestMapping(value = "/detailContent/{contentId}",method = RequestMethod.GET)
    public String detailContent(@PathVariable String contentId, HttpServletRequest request){
        HttpSession session = request.getSession();
        Content thisContent = (Content) contentService.conById(contentId);
        int childLevel = Integer.parseInt(thisContent.getLevel())+1;
        if (childLevel > 2) {
            childLevel = 2;
        }
        User thisUser = new User();
        try {
            thisUser = userService.getUserById(thisContent.getAuthorId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        session.setAttribute("detailContent",thisContent);//session: detailContent
        Map<String, Object> comIdMapUser = new HashMap<>();//评论内容id对于相应user，包括当前内容的user
        Map<String, List<Content>> comIdMapChildCom = new HashMap<>();//评论内容id对于相应子评论list
        comIdMapUser.put(contentId,thisUser);
        if (!thisContent.getLevel().equals("0")){//放入父内容的信息
            for (int i = 0;i<5;i++){
                System.out.println("========================");
            }
            Content pC = (Content) contentService.conById(thisContent.getParentId());
            User parentContentAuthor = userService.getUserById(pC.getAuthorId());
            comIdMapUser.put(thisContent.getParentId(),parentContentAuthor);
        }
        List<Content> childContents = contentService.getChildCon(contentId,String.valueOf(childLevel));
        childLevel++;
        if (childLevel > 2) {
            childLevel = 2;
        }
        session.removeAttribute("comments");
        if (childContents.size() > 0){
            System.out.println("子评论不为空！！！");
            session.setAttribute("comments",childContents);
            for (Content childContent : childContents) {
                User author = userService.getUserById(childContent.getAuthorId());
                comIdMapUser.put(childContent.getId(),author);
                List<Content> level2coms = contentService.getChildCon(childContent.getId(),String.valueOf(childLevel));
                if (level2coms.size() > 0){
                    for (Content level2com : level2coms) {
                        User level2author = userService.getUserById(level2com.getAuthorId());
                        comIdMapUser.put(level2com.getId(),level2author);
                    }
                    comIdMapChildCom.put(childContent.getId(),level2coms);
                }
            }
        }
        System.out.println("comIdMapChildCom===>"+comIdMapChildCom);
        session.setAttribute("comIdMapUser",comIdMapUser);//session: comIdMapUser
        session.setAttribute("comIdMapChildCom",comIdMapChildCom);//session: comIdMapChildCom
//        return "thisContent==>"+thisContent.toString()+" comIdMapUser==>"+comIdMapUser.toString()+" comIdMapUser==>"+comIdMapChildCom.toString();
//        String json = "{\"status\":\"succecss\"}";
        return "content";
    }

    @RequestMapping("/explore")
    public String explore(HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null){
            return "redirect:/User/logout";
        }
        String topicIdsStr = user.getTopicIds();
        if (topicIdsStr.equals("")){
            List<Topic> topParentTopics = topicService.topTopics("parent");
            for (Topic pt : topParentTopics){
                if (topicIdsStr.split(",").length > 5){
                    break;
                }
                topicIdsStr = topicIdsStr + ","+pt.getId();
            }
            topicIdsStr = topicIdsStr.substring(1);
        }
        List<String> topicIds = new ArrayList<>(Arrays.asList(topicIdsStr.split(",")));
        List<Topic> topics = new ArrayList<>();
        Map<String, Object> topicIdMapCons = new HashMap<>();
        Map<String, Object> conIdMapUser = new HashMap<>();
        Page page = new Page();
        page.setPageSize(5);
        for (String topicId : topicIds) {
            Topic topic = topicService.topicById(topicId);
//            consByTopicId有时间，热度，三天内的排序
            List<Content> contents = contentService.consByTopicId(topicId,page);
            if (contents.size() > 0){
                topics.add(topic);
                for (Content content : contents) {
                    User author = userService.getUserById(content.getAuthorId());
                    conIdMapUser.put(content.getId(),author);
                }
                topicIdMapCons.put(topicId,contents);
            }
            if (!topic.getParentId().equals("0")){
                if (user.getTopicIds().indexOf(topic.getParentId()) == -1 && !topics.stream().filter(item->item.getId().equals(topic.getParentId())).findAny().isPresent()){
                    Topic pTopic = topicService.topicById(topic.getParentId());
                    List<Content> pTcontents = contentService.consByTopicId(pTopic.getId(),page);
                    if (pTcontents.size() > 0){
                        topics.add(pTopic);
                        for (Content content : pTcontents) {
                            User author = userService.getUserById(content.getAuthorId());
                            conIdMapUser.put(content.getId(),author);
                        }
                        topicIdMapCons.put(pTopic.getId(),contents);
                    }
                }
            }
        }
//        who to follow
        Page page1 = new Page(); page1.setPageSize(3);
        List<User> wtfUsers = userService.whoToFollower(user.getId(),page1);
        session.setAttribute("wtfUsers",wtfUsers);

        request.setAttribute("expTopics",topics);
        request.setAttribute("expTopicIdMapCons",topicIdMapCons);
        request.setAttribute("expConIdMapUser",conIdMapUser);
        return "explore";
    }
}
