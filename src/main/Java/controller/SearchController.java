package controller;


import config.S3ClientGetter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Content;
import pojo.Similarity;
import pojo.Topic;
import pojo.User;
import service.ContentService;
import service.TopicService;
import service.UserService;
import utility.DataUtility;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/Search")
public class SearchController {
    //controller 调用 service 层
    @Autowired//开启自动装配
    @Qualifier("ContentServiceImpl")//指定service里定义的bean
//    将spring-service.xml指明的id为BookServiceImpl的bean映射到此处定义的其接口类
    private ContentService contentService;

    @Autowired//开启自动装配
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @Autowired//开启自动装配
    @Qualifier("TopicServiceImpl")
    private TopicService topicService;

    private DataUtility dataUtility = new DataUtility();

    @RequestMapping("/{type}/{keyword}")
    public String search(@PathVariable String type, @PathVariable String keyword, HttpServletRequest request){
        request.setAttribute("keywordShow",keyword);
        request.setAttribute("type",type);
        if ("Top".equals(type)){
            String sql = "order by likeNum*2+commentNum desc";
            List<Content> allContents = contentService.allConsBySql(sql);
            List<Content> resultContents = new ArrayList<>();
            Map<String,Object> conIdMapUser = new HashMap<>();
            for (int x = 0 ; x < allContents.size(); x++){
                Content content = allContents.get(x);
                String textContent = content.getTextContent();
                textContent = dataUtility.removeHtmlTags(textContent);
                if (dataUtility.similarity(textContent,keyword)>0.2){
                    System.out.println("这个content满足大于50，匹配度是："+dataUtility.similarity(textContent,keyword));
                    if (!content.getParentId().equals("0")){
                        Content pc = contentService.conById(content.getParentId());
                        User pcAuthor = userService.getUserById(pc.getAuthorId());
                        pcAuthor.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(pcAuthor.getProfilePicUrl()));
                        conIdMapUser.put(content.getParentId(),pcAuthor);
                    }

                    resultContents.add(content);
                }
            }
            for (Content content : resultContents){
                User author = userService.getUserById(content.getAuthorId());
                conIdMapUser.put(content.getId(),author);
            }
//            top页面的user list
            List<User> allUsers = userService.allUsers();
            List<Similarity> simiList = new ArrayList<>();
            for (int i = 0;i<allUsers.size();i++) {
                User user = allUsers.get(i);
                user.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(user.getProfilePicUrl()));
                String email = user.getEmail();
                String name = user.getName();
                int simiarity1 = (int) (dataUtility.similarity(keyword,email)*100000);
                int simiarity2 = (int) (dataUtility.similarity(keyword,name)*100000);
                Similarity similarityEnity1 = new Similarity(user,simiarity1);
                Similarity similarityEnity2 = new Similarity(user,simiarity2);
                simiList.add(similarityEnity1);
                simiList.add(similarityEnity2);
            }
//        list排序
            Collections.sort(simiList);
            //        list去重
            simiList = dataUtility.removeSimi(simiList);
            List<User> resultUsers = new ArrayList<>();
            for (Similarity s : simiList){
                if(resultUsers.size()>3){
                    break;
                }
                resultUsers.add((User) s.getObject());
            }

            //top页面的topic list
            List<Topic> allTopics = topicService.getAllTopic();
            List<Topic> resultTopics = new ArrayList<>();
            for (int i = 0;i<allTopics.size();i++) {
                Topic topic = allTopics.get(i);
                String topicName = topic.getName();
                if (dataUtility.similarity(topicName,keyword)>0.8){
                    resultTopics.add(topic);
                }
                if (resultTopics.size() >3){
                    break;
                }
            }


            request.setAttribute("schResultTopics",resultTopics);
            request.setAttribute("schPeopleList",resultUsers);
            request.setAttribute("schTopContents",resultContents);
            request.setAttribute("schConIdMapUser",conIdMapUser);
        }
        else if ("Latest".equals(type)){
            String sql = "order by str_to_date( releasingTime,'%Y/%m/%d %H/%i') desc";
            List<Content> allContents = contentService.allConsBySql(sql);
            List<Content> resultContents = new ArrayList<>();
            Map<String,Object> conIdMapUser = new HashMap<>();
            for (int x = 0 ; x < allContents.size(); x++){
                Content content = allContents.get(x);
                String textContent = content.getTextContent();
                textContent = dataUtility.removeHtmlTags(textContent);
                if (dataUtility.similarity(textContent,keyword)>0.2){
                    System.out.println("这个content满足大于50，匹配度是："+dataUtility.similarity(textContent,keyword));
                    if (!content.getParentId().equals("0")){
                        Content pc = contentService.conById(content.getParentId());
                        User pcAuthor = userService.getUserById(pc.getAuthorId());
                        pcAuthor.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(pcAuthor.getProfilePicUrl()));
                        conIdMapUser.put(content.getParentId(),pcAuthor);
                    }
                    resultContents.add(content);
                }
            }
            for (Content content : resultContents){
                User author = userService.getUserById(content.getAuthorId());
                conIdMapUser.put(content.getId(),author);
            }
            request.setAttribute("schTopContents",resultContents);
            request.setAttribute("schConIdMapUser",conIdMapUser);
        }
        else if ("People".equals(type)){
            List<User> allUsers = userService.allUsers();
            List<Similarity> simiList = new ArrayList<>();
            for (int i = 0;i<allUsers.size();i++) {
                User user = allUsers.get(i);
                user.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(user.getProfilePicUrl()));
                String email = user.getEmail();
                String name = user.getName();
                int simiarity1 = (int) (dataUtility.similarity(keyword,email)*100000);
                int simiarity2 = (int) (dataUtility.similarity(keyword,name)*100000);
                Similarity similarityEnity1 = new Similarity(user,simiarity1);
                Similarity similarityEnity2 = new Similarity(user,simiarity2);
                simiList.add(similarityEnity1);
                simiList.add(similarityEnity2);
            }
//        list排序
            Collections.sort(simiList);
            //        list去重
            simiList = dataUtility.removeSimi(simiList);
            List<User> resultUsers = new ArrayList<>();
            for (Similarity s : simiList){
                resultUsers.add((User) s.getObject());
            }
            request.setAttribute("schPeopleList",resultUsers);
        }
        else if ("Photos".equals(type) || "Videos".equals(type)){
            List<Content> allPhotoContents = new ArrayList<>();
            if ("Photos".equals(type)){
                allPhotoContents = contentService.allPhotoContent();
            } else {
                String sql = "where videoURL != '0'";
                allPhotoContents = contentService.allConsBySql(sql);
            }
            List<Content> resultContents = new ArrayList<>();
            Map<String,Object> conIdMapUser = new HashMap<>();
            for (int x = 0 ; x < allPhotoContents.size(); x++){
                Content content = allPhotoContents.get(x);
                String textContent = content.getTextContent();
                textContent = dataUtility.removeHtmlTags(textContent);
                if (dataUtility.similarity(textContent,keyword)>0.2){
                    System.out.println("这个content满足大于50，匹配度是："+dataUtility.similarity(textContent,keyword));
                    if (!content.getParentId().equals("0")){
                        Content pc = contentService.conById(content.getParentId());
                        User pcAuthor = userService.getUserById(pc.getAuthorId());
                        pcAuthor.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(pcAuthor.getProfilePicUrl()));
                        conIdMapUser.put(content.getParentId(),pcAuthor);
                    }
                    resultContents.add(content);
                }
            }
            for (Content content : resultContents){
                User author = userService.getUserById(content.getAuthorId());
                author.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(author.getProfilePicUrl()));
                conIdMapUser.put(content.getId(),author);
            }
            request.setAttribute("schPhotoContents",resultContents);
            request.setAttribute("schConIdMapUser",conIdMapUser);
        }
        return "search";

    }

    @RequestMapping("/{keyword}")
    @ResponseBody
    public Map<String, Object> search(@PathVariable String keyword){
        List<User> allUsers = userService.allUsers();
        List<Similarity> simiList = new ArrayList<>();
        Map<String, Object> resultMap = new HashMap<>();
        for (int i = 0;i<allUsers.size();i++) {
            User user = allUsers.get(i);
            user.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(user.getProfilePicUrl()));
            String email = user.getEmail();
            String name = user.getName();
            int simiarity1 = (int) (dataUtility.similarity(keyword,email)*100000);
            int simiarity2 = (int) (dataUtility.similarity(keyword,name)*100000);
            Similarity similarityEnity1 = new Similarity(user,simiarity1);
            Similarity similarityEnity2 = new Similarity(user,simiarity2);
            simiList.add(similarityEnity1);
            simiList.add(similarityEnity2);
        }
//        list排序
        Collections.sort(simiList);
        //        list去重
        simiList = dataUtility.removeSimi(simiList);
        List<User> resultUsers = new ArrayList<>();
        for (Similarity s : simiList){
            if(resultUsers.size() > 10){
                break;
            }
            resultUsers.add((User) s.getObject());
        }

        List<Content> allContents = contentService.getAllContents();
        List<Similarity> conSimiList = new ArrayList();
        for (int x = 0 ; x < allContents.size(); x++){
            Content content = allContents.get(x);
            String textContent = content.getTextContent();
            int similarity3 = (int) (dataUtility.similarity(textContent,keyword)*100000);
            Similarity similarityEnity3 = new Similarity(content,similarity3);
            conSimiList.add(similarityEnity3);
        }
        //        list排序
        Collections.sort(conSimiList);
        //        list去重
        conSimiList = dataUtility.removeSimi(conSimiList);
        List<Content> resultContents = new ArrayList<>();
        for (Similarity s : conSimiList){
            if (s.getSimilarity() > 0){
                resultContents.add((Content) s.getObject());
            }
        }

        resultMap.put("resultUsers",resultUsers);
        resultMap.put("resultContents",resultContents);
        return resultMap;
    }

    @RequestMapping("/listContact/{keyword}")
    @ResponseBody
    public List<User> listContact(@PathVariable String keyword,HttpServletRequest request){
        HttpSession session = request.getSession();
        User sUser = (User) session.getAttribute("user");

        List<User> allUsers = userService.allUsers();
        List<Similarity> simiList = new ArrayList<>();
        for (int i = 0;i<allUsers.size();i++) {
            User user = allUsers.get(i);
            user.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(user.getProfilePicUrl()));
            String email = user.getEmail();
            String name = user.getName();
            int simiarity1 = (int) (dataUtility.similarity(keyword,email)*100000);
            int simiarity2 = (int) (dataUtility.similarity(keyword,name)*100000);
            Similarity similarityEnity1 = new Similarity(user,simiarity1);
            Similarity similarityEnity2 = new Similarity(user,simiarity2);
            simiList.add(similarityEnity1);
            simiList.add(similarityEnity2);
        }
//        list排序
        Collections.sort(simiList);
        //        list去重
        simiList = dataUtility.removeSimi(simiList);
        List<User> resultUsers = new ArrayList<>();
        for (Similarity s : simiList){
            User thisUser = (User) s.getObject();
//            如果是自己的话，就不要放进去在搜索contact页面展示出来了
            if (!thisUser.getId().equals(sUser.getId())){
                resultUsers.add(thisUser);
            }
        }
        return resultUsers;
    }

}
