package controller;


import config.S3ClientGetter;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Content;
import pojo.Topic;
import pojo.User;
import service.ContentService;
import service.TopicService;
import service.UserService;
import utility.RandomUtility;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("/Topic")
public class TopicController {
    //controller 调用 service 层
    @Autowired//开启自动装配
    @Qualifier("TopicServiceImpl")//指定service里定义的bean
//    将spring-service.xml指明的id为BookServiceImpl的bean映射到此处定义的其接口类
    private TopicService topicService;

    @Autowired//开启自动装配
    @Qualifier("ContentServiceImpl")//指定service里定义的bean
    private ContentService contentService;

    @Autowired//开启自动装配
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @RequestMapping("/addTopic")
    @ResponseBody
    @Transactional
    public String addTopic(){
        String parentliststr = "Technology, cat17941903, Music, cat23985466, BusinessFinance, cat21099682, Outdoor, cat28542823," +
                "FashionB, cat37194337, HomeFamily, cat50833112, Gaming, cat51586570, Careers, cat53933042, Entertainment, cat54908091";
        String[] parentArray = parentliststr.split(",");
        for (int i = 0; i < parentArray.length; i += 2){
            Topic topic = new Topic();
            topic.setId(parentArray[i+1].substring(1));
            topic.setName(parentArray[i]);
            topic.setIsParent(1);
            topic.setParentId("");
            topic.setUserInTopicIds("");
            topic.setUserInTopicNum(0);
            topic.setContentNum(0);
            topic.setContentIds("");
            if (topicService.addTopic(topic) != 1){
                System.out.println("error: father topic fails to insert");
            }
        }

        String Technology = "cat17941903,Elon Musk,Apple,Android,Tech news,Machine learning,Artificial intelligence,Computer programming,YouTube,Open source";
        String Music = "cat23985466,Rap,Drake,K-pop,J. Cole,R&B & soul,Rock,J-pop,Hip hop,Music news,Pop,Jay Z,Classical music";
        String BusinessFinance = "cat21099682,Business news,Marketing,Investing,Small business,Accounting,Advertising,Tesla Motors,Financial";
        String Outdoor = "cat28542823,Travel,Fishing,Golf,Climbing,Car travel";
        String FashionB = "cat37194337,Daily outfit,Adidas,Nike,Louis Vuitton,victory,cosmetics";
        String HomeFamily = "cat50833112,Family relationship,Father,Trivial matters,relatives";
        String Gaming = "cat51586570,LoL,CF,Mobile game,Pc game,Simulating";
        String Careers = "cat53933042,Education,Language learning,Interior design,Architecture";
        String Entertainment = "cat54908091,Movie news,Movies,Celebrities,Comedy,Entertainment news,Disney";
        String[] musicArr = Music.split(",");
        String[] techArr = Technology.split(",");
        String[] bfArr = BusinessFinance.split(",");
        String[] outdoorArr = Outdoor.split(",");
        String[] FashionBArr = FashionB.split(",");
        String[] HomeFamilyArr = HomeFamily.split(",");
        String[] GamingArr = Gaming.split(",");
        String[] CareersArr = Careers.split(",");
        String[] EntertainmentArr = Entertainment.split(",");
        List<String[]> topicList = new ArrayList<>();
        topicList.add(techArr);
        topicList.add(musicArr);
        topicList.add(bfArr);
        topicList.add(outdoorArr);
        topicList.add(FashionBArr);
        topicList.add(HomeFamilyArr);
        topicList.add(GamingArr);
        topicList.add(CareersArr);
        topicList.add(EntertainmentArr);

        RandomUtility random = new RandomUtility();
        for (int i = 0;i<topicList.size();i++){
            String[] items = topicList.get(i);
            System.out.println("======================>");
            for (String item : items){
                System.out.println(item);
            }
            System.out.println("总共："+topicList.size()+"次");
            System.out.println(items);
            for (int x=1;x<items.length; x++){
                Topic topic = new Topic();
                topic.setId("cat"+random.createId());
                topic.setName(items[x]);
                topic.setIsParent(0);
                topic.setParentId(items[0]);
                topic.setUserInTopicIds("");
                topic.setUserInTopicNum(0);
                topic.setContentNum(0);
                topic.setContentIds("");
                List<Topic> topics = topicService.getAllTopic();
                int judge = 0;
                for (Topic t : topics) {
                    if (t.getName().equals(items[x])){
                        judge++;
                        break;
                    } else {

                    }
                }
                if (judge == 0) {
                    topicService.addTopic(topic);
                } else {
                    System.out.println("已存在："+topic.getName());
                }
            }
        }
        return "";
    }

    @RequestMapping("/getAllTopics")
    @ResponseBody
    public List<String> getAllTopics() {
        List<Topic> parentTopics = topicService.getParentTopic();
        List<String> result = new ArrayList<>();
        for (Topic pt : parentTopics) {
            List<Topic> cTopics = topicService.topicByPId(pt.getId());
            String js = "";
            String ptName = pt.getName().replace(" ","").replace("&","").replace("-","").replace(".","");
            String List = "var "+ptName+"List = [";
            for (Topic ct : cTopics){
                String ctName = ct.getName().replace(" ","").replace("&","").replace("-","").replace(".","");
                js = js + "var "+ctName+" = {\n" +
                        "    name: \""+ct.getName()+"\",\n" +
                        "    id: \""+ct.getId()+"\",\n" +
                        "    parentId: \""+pt.getId()+"\"\n" +
                        "}\n";
                List = List + ctName + ",";
            }
            System.out.println(js);
            List = List.substring( 0 ,List.length() - 1 ) + "];\n";
            System.out.println(List);
            result.add(js);
            result.add(List);
        }
        return result;
    }

    @RequestMapping("/getParentTopic")
    @ResponseBody
    public List<Topic> getParentTopic(){
        List<Topic> parentTopics = topicService.getParentTopic();
        return parentTopics;
    }

    /**
     * @param request
     * @return topicsParentList, topicsList
     */
    @RequestMapping("/topics")
    public String topics(HttpServletRequest request){
        HttpSession session = request.getSession();
        List<Topic> foryouTopics = topicService.topTopics("children");
        request.setAttribute("foryouTopics",foryouTopics);
        List<Topic> parentTopics = topicService.getParentTopic();
        List<List<Topic>> topicsList = new ArrayList<>();
        List<Topic> topicsParentList = new ArrayList<>();
        for (Topic pt : parentTopics){
            List<Topic> childrenTopics = topicService.topicByPId(pt.getId());
            if (childrenTopics.size()>0){
                topicsList.add(childrenTopics);
                topicsParentList.add(pt);
            }
        }
        request.setAttribute("topicsParentList",topicsParentList);
        request.setAttribute("topicsList",topicsList);
        return "topics";
    }

    @RequestMapping("/detailTopic/{topicId}")
    public String detialTopic(@PathVariable String topicId,HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/User/logout";
        }
        Topic detailTopic = topicService.topicById(topicId);
        String contentIdStr = detailTopic.getContentIds();
        List<String> contentIds = new ArrayList(Arrays.asList(contentIdStr.split(",")));
        List<Content> contents = contentService.conByIds(contentIds);
        String orderSql = "order by followingNum DESC\n" +
                "\t\t\t\tLIMIT 0,3";
        List<String> UserInTopicIds = new ArrayList(Arrays.asList(detailTopic.getUserInTopicIds().split(",")));
        List<User> topicUsers = userService.usersByIds(UserInTopicIds,orderSql);
        List<String> profilePics = new ArrayList<>();
        for (User u : topicUsers){
            profilePics.add(S3ClientGetter.getS3PresignedUrl(u.getProfilePicUrl()));
        }
        while (profilePics.size()<4){
            profilePics.add("users/image/default_profile.jpg");
        }
        Map<String, Object> conIdMapUser = new HashMap<>();
        for (Content content : contents) {
            User author = userService.getUserById(content.getAuthorId());
            author.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(author.getProfilePicUrl()));
            conIdMapUser.put(content.getId(),author);
        }
        request.setAttribute("detailTopic",detailTopic);
        request.setAttribute("dTopContents",contents);
        request.setAttribute("dTopConIdMapUser",conIdMapUser);
        request.setAttribute("profilePics",profilePics);
        return "topic";
    }

    @RequestMapping("/followTopic/{topicId}")
    @ResponseBody
    public Map followTopic(@PathVariable String topicId,HttpServletRequest request){
        HttpSession session = request.getSession();
        Map result = new HashMap();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            result.put("errorCode","1");
            return  result;
        }

        Topic topic = topicService.topicById(topicId);
        String userInTopicIdsStr = topic.getUserInTopicIds();
        userInTopicIdsStr = userInTopicIdsStr + "," + user.getId();
        if (userInTopicIdsStr.startsWith(",")){
            userInTopicIdsStr = userInTopicIdsStr.substring(1);
        }
        int userInTopicNum = topic.getUserInTopicNum();
        userInTopicNum++;
        Topic updateTopic = new Topic();
        updateTopic.setId(topicId);
        updateTopic.setUserInTopicIds(userInTopicIdsStr);
        updateTopic.setUserInTopicNum(userInTopicNum);
        try {
             topicService.updateTopic(updateTopic);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String topicIds = user.getTopicIds();
        topicIds = topicIds + "," + topicId;
        if (topicIds.startsWith(",")){
            topicIds = topicIds.substring(1);
        }
        User updatedUser = new User();
        updatedUser.setId(user.getId());
        updatedUser.setTopicIds(topicIds);
        try {
            userService.updateUser(updatedUser);
            user.setTopicIds(topicIds);
            session.setAttribute("user",user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        result.put("status","success");
        return result;
    }

    @RequestMapping("/unfollowTopic/{topicId}")
    @ResponseBody
    public Map unfollowTopic(@PathVariable String topicId,HttpServletRequest request){
        HttpSession session = request.getSession();
        Map result = new HashMap();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            result.put("errorCode","1");
            return  result;
        }

        Topic topic = topicService.topicById(topicId);
        String userInTopicIdsStr = topic.getUserInTopicIds();
        if (userInTopicIdsStr.indexOf(user.getId()) != -1){
            userInTopicIdsStr = userInTopicIdsStr.replace(user.getId(),"");
        } else {
            result.put("errorCode","2");
            return  result;
        }
        if (userInTopicIdsStr.endsWith(",")){
            userInTopicIdsStr = userInTopicIdsStr.substring(0,userInTopicIdsStr.length()-1);
        }
        if (userInTopicIdsStr.indexOf(",,") != -1 ){
            userInTopicIdsStr = userInTopicIdsStr.replace(",,",",");
        }
        if (userInTopicIdsStr.startsWith(",")){
            userInTopicIdsStr = userInTopicIdsStr.substring(1);
        }
        int userInTopicNum = topic.getUserInTopicNum();
        if (userInTopicNum > 0){
            userInTopicNum--;
        } else {
            result.put("errorCode","3");
            return  result;
        }
        Topic updateTopic = new Topic();
        updateTopic.setId(topicId);
        updateTopic.setUserInTopicIds(userInTopicIdsStr);
        updateTopic.setUserInTopicNum(userInTopicNum);
        try {
            topicService.updateTopic(updateTopic);
        } catch (Exception e) {
            e.printStackTrace();
        }

        String topicIds = user.getTopicIds();
        if (topicIds.indexOf(topicId) != -1){
            topicIds = topicIds.replace(topicId,"");
        } else {
            result.put("errorCode","4");
            return  result;
        }
        if (topicIds.endsWith(",")){
            topicIds = topicIds.substring(0,topicIds.length()-1);
        }
        if (topicIds.indexOf(",,") != -1 ){
            topicIds = topicIds.replace(",,",",");
        }
        if (topicIds.startsWith(",")){
            topicIds = topicIds.substring(1);
        }
        User updatedUser = new User();
        updatedUser.setId(user.getId());
        updatedUser.setTopicIds(topicIds);
        try {
            userService.updateUser(updatedUser);
            user.setTopicIds(topicIds);
            session.setAttribute("user",user);
        } catch (Exception e) {
            e.printStackTrace();
        }

        result.put("status","success");
        return  result;
    }

}
