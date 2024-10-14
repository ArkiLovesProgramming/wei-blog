package controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import config.S3ClientGetter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import pojo.Chat;
import pojo.Contact;
import pojo.Page;
import pojo.User;
import service.ChatService;
import service.ContactService;
import service.UserService;
import utility.DataUtility;
import utility.DateUtility;
import utility.RandomUtility;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/Messages")
public class MessageController {

    @Autowired//开启自动装配
    @Qualifier("ContactServiceImpl")
    private ContactService contactService;

    @Autowired//开启自动装配
    @Qualifier("UserServiceImpl")
    private UserService userService;

    @Autowired//开启自动装配
    @Qualifier("ChatServiceImpl")
    private ChatService chatService;

    private RandomUtility randomUtility = new RandomUtility();
    private DateUtility dateUtility = new DateUtility();
    private DataUtility dataUtility = new DataUtility();

    @RequestMapping("/addContact/{targetUserId}")
    public String addContact(@PathVariable String targetUserId, HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        Contact contact = new Contact();
        List<Contact> existingContacts = contactService.contactsByUserIds(user.getId(),targetUserId);
        if (existingContacts.size() == 1){
            System.out.println("待添加的contact已存在！创建时间是： "+existingContacts.get(0).getCreatingTime());
        } else if (existingContacts.size() == 0){
            String id = randomUtility.createId();
            contact.setId(id);
            contact.setCreator(user.getId());
            String contactIds = user.getId()+","+targetUserId;
            contact.setContactIds(contactIds);
            contact.setLastContactTime("");
            contact.setLastContent("");
            String creatingTime = dateUtility.getDate();
            contact.setCreatingTime(creatingTime);
            contact.setClosedIds("");

            try {
                contactService.addContact(contact);
//            添加改变session
                List<Contact> contacts = (List<Contact>) session.getAttribute("contacts");
                contacts.add(contact);
                session.setAttribute("contacts",contacts);
                Map<String, Object> ctactIdMapUser = (Map<String, Object>) session.getAttribute("ctactIdMapUser");
                User targetUser = userService.getUserById(targetUserId);
                targetUser.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(targetUser.getProfilePicUrl()));
                ctactIdMapUser.put(contact.getId(), targetUser);
                session.setAttribute("ctactIdMapUser",ctactIdMapUser);
            } catch (Exception e){
                e.printStackTrace();
            }
        } else {
            System.out.println("addContact程序错误！");
        }
        return "success";
    }

    @RequestMapping("")
    public String messages(HttpServletRequest request){


        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/User/logout";
        }
        //        创造一个application，用来看看某个人user是否有最新消息，如果有，放入userMsgedIds
        //|123,123||222,333|   senderId,receiverId;
        ServletContext application = request.getSession().getServletContext();
        if (application.getAttribute("userMsgedIds") == null){
            application.setAttribute("userMsgedIds","");
            System.out.println("appication第一次由"+user.getName()+"创建！");
        }
        if (session.getAttribute("hasChatWithUId") != null){
            return "redirect:/Messages/"+user.getId() + "-" + session.getAttribute("hasChatWithUId");
        }
        List<Contact> contacts = contactService.contactsByUserId(user.getId());
        Map<String, Object> ctactIdMapUser = new HashMap<>();
        for (Contact contact : contacts) {
            String contactIds = contact.getContactIds();
            String targetUserId = contactIds.replace(user.getId(),"").replace(",","");
            User targetUser = userService.getUserById(targetUserId);
            targetUser.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(targetUser.getProfilePicUrl()));
            ctactIdMapUser.put(contact.getId(),targetUser);
//            获取lastContent的信息
            Chat lastChat = chatService.lastChatInfo(contact.getId());
            if (lastChat != null){
                if (!lastChat.getTextContent().equals("")){
                    contact.setLastContent(dataUtility.removeHtmlTags(lastChat.getTextContent()));
                } else if (!lastChat.getPictureURL().equals("0")){
                    contact.setLastContent("You sent a picture");
                } else if (!lastChat.getVideoURL().equals("0")){
                    contact.setLastContent("You sent a video");
                }
                contact.setLastContactTime(lastChat.getReleasingTime());
            }
        }
//        给contact进行按lastContactTime排序
        Contact.ListSort(contacts);
        session.setAttribute("contacts",contacts);
        session.setAttribute("ctactIdMapUser",ctactIdMapUser);
        return "messages";
    }

    @RequestMapping("/{myId}-{otherId}")
    public String messages(@PathVariable String myId,@PathVariable String otherId, HttpServletRequest request){
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");
        if (user == null) {
            return "redirect:/User/logout";
        }
        //        打开聊天界面的时候，清空自己在application中的情况
        ServletContext application = request.getSession().getServletContext();
        String str = (String) application.getAttribute("userMsgedIds");
        if (str.indexOf("|"+otherId+","+myId+"|") != -1){
            System.out.println("有新的消息通知存放在application中！");
            System.out.println("原来application中的userMsgedIds为： "+str);
            str = str.replace("|"+otherId+","+myId+"|","");
            application.setAttribute("userMsgedIds",str);
            System.out.println("新的消息通知已经从application中删除！");
            System.out.println("现在的application中的userMsgedIds为： "+str);
        }

        if (session.getAttribute("contacts") == null || session.getAttribute("ctactIdMapUser") == null){
            List<Contact> contacts = contactService.contactsByUserId(user.getId());
            Map<String, Object> ctactIdMapUser = new HashMap<>();
            for (Contact contact : contacts) {
                String contactIds = contact.getContactIds();
                String targetUserId = contactIds.replace(user.getId(),"").replace(",","");
                User targetUser = userService.getUserById(targetUserId);
                targetUser.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(targetUser.getProfilePicUrl()));
                ctactIdMapUser.put(contact.getId(),targetUser);
//            获取lastContent的信息
                Chat lastChat = chatService.lastChatInfo(contact.getId());
                if (lastChat != null){
                    if (!lastChat.getTextContent().equals("")){
                        contact.setLastContent(dataUtility.removeHtmlTags(lastChat.getTextContent()));
                    } else if (!lastChat.getPictureURL().equals("0")){
                        contact.setLastContent("You sent a picture");
                    } else if (!lastChat.getVideoURL().equals("0")){
                        contact.setLastContent("You sent a video");
                    }
                    contact.setLastContactTime(lastChat.getReleasingTime());
                }
            }
            //        给contact进行按lastContactTime排序
            Contact.ListSort(contacts);
            session.setAttribute("contacts",contacts);
            session.setAttribute("ctactIdMapUser",ctactIdMapUser);
        }

        String contactId = contactService.idByUserIds(myId,otherId);
        List<Chat> chats = chatService.chatsByCtactId(contactId);
        int otherMsgsNum = 0;
        for (Chat chat : chats) {
            System.out.println(chat.toString());
            if (!chat.getVideoURL().equals("0")) {
                chat.setVideoURL(S3ClientGetter.getS3PresignedUrl(chat.getVideoURL()));
            }
            if (!chat.getPictureURL().equals("0")) {
                chat.setPictureURL(S3ClientGetter.getS3PresignedUrl(chat.getPictureURL()));
            }
            if (chat.getReceiverId().equals(user.getId())){
                otherMsgsNum++;
            }
        }
        System.out.println("初始的对方信息数量是=======》   "+otherMsgsNum);
        session.setAttribute("otherMsgsNum",otherMsgsNum);
        request.setAttribute("chats",chats);
        User targetUser = userService.getUserById(otherId);
        targetUser.setProfilePicUrl(S3ClientGetter.getS3PresignedUrl(targetUser.getProfilePicUrl()));
        request.setAttribute("chatTargetUser",targetUser);
        request.setAttribute("currentContactId",contactId);
        session.setAttribute("hasChatWithUId",otherId);
        return "messages";
    }



    @RequestMapping("/addChat")
    @ResponseBody
    public Chat addChat(@RequestBody(required = false) Chat chat,HttpServletRequest request){
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            return null;
        }
        String chatId = "chat"+randomUtility.createId();
        chat.setId(chatId);
        chat.setSenderId(user.getId());
        String receiverId = (String) session.getAttribute("hasChatWithUId");
        if (receiverId != null) {
            chat.setReceiverId(receiverId);
        }
        chat.setReleasingTime(dateUtility.getDateTime());
        chat.setDeleted(0);
        chat.setReaded(0);
        try {
            chatService.addChat(chat);

//            添加chat的时候，通过application通知接收用户
            ServletContext application = request.getSession().getServletContext();
            String str = (String) application.getAttribute("userMsgedIds");
            if (str.indexOf("|"+chat.getSenderId()+","+chat.getReceiverId()+"|") != -1){
                System.out.println("给 "+chat.getReceiverId()+" 通知已存在application中");
            } else {
                str = str + "|"+chat.getSenderId()+","+chat.getReceiverId()+"|";
                application.setAttribute("userMsgedIds",str);
                System.out.println("已经通知id为："+chat.getReceiverId()+"有最新消息，并存入application中！");
                System.out.println("application中的userMsgedIds为： "+ application.getAttribute("userMsgedIds"));
            }
//            错误代码，这里的addChat是自己发消息，不是目前收到对方消息
//            添加已经获取了多少对方信息，然后方便后续轮询查询
//            int num = (int) session.getAttribute("otherMsgsNum");
//            session.setAttribute("otherMsgsNum",++num);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return chat;
    }

    @RequestMapping(value = "/msgReceivedListener1/{senderId}/{receiverId}")
    @ResponseBody
    public void serverSend1(HttpServletResponse response,HttpServletRequest request,@PathVariable String senderId,@PathVariable String receiverId) throws IOException {
        response.setContentType("text/event-stream");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = null;
        if (senderId == null || receiverId == null){
            return;
        }
        while (true) {
            try {
                HttpSession session = request.getSession();
                ServletContext application = request.getSession().getServletContext();
                writer = response.getWriter();
                Thread.sleep(1500);
                String userMsgedIds = (String) application.getAttribute("userMsgedIds");
//                如果application有待通知信息
                if (userMsgedIds.indexOf("|"+senderId+","+receiverId+"|") != -1) {
                    int currentPage = (int) session.getAttribute("otherMsgsNum");
                    System.out.println(receiverId+"拥有最新消息，当前对方消息数是： "+currentPage+" 开始查询数据库！");
                    Page page = new Page();
                    page.setCurrentPage(currentPage);
                    page.setPageSize(10);
                    List<Chat> chats = chatService.chatsBySRId(senderId,receiverId,page);
                    if (chats.size() == 0){
                        System.out.println("未查到数据！程序出错！");
                        return;
                    }
//                    查出最新的chat数据给对方初始session信息更新
                    session.setAttribute("otherMsgsNum",currentPage+chats.size());
                    System.out.println("给对方初始消息otherMsgsNum重新赋值为： "+session.getAttribute("otherMsgsNum"));
                    ObjectMapper mapper=new ObjectMapper();
                    String result = "";
                    for (Chat chat : chats) {
                        String jsonStr = mapper.writeValueAsString(chat);
                        result = result + jsonStr + ",";
                    }
                    result = result.substring(0,result.length() - 1);
                    result = "["+result+"]";
                    writer.write("data: "+result+" \n\n");//这里需要\n\n，必须要，不然前台接收不到值,键必须为data
                    // 删除该通知信息从application里面
                    userMsgedIds = userMsgedIds.replace("|"+senderId+","+receiverId+"|","");
                    application.setAttribute("userMsgedIds",userMsgedIds);
                    System.out.println("userMsgedIds以将接受人id为： "+receiverId+"的记录清除！");
                    System.out.println(application.getAttribute("userMsgedIds"));
                } else {
                    writer.write("data:\n\n");
                }
                // 如果浏览器直接关闭，需要check一下
                if (writer.checkError()) {
                    System.out.println("客户端主动断开连接");
                    writer.close();
                    return;
                } else writer.flush();
            } catch (Exception e) {
                e.printStackTrace();
                if(null != writer) {
                    writer.close();
                }
                return;
            }
        }
    }


}
