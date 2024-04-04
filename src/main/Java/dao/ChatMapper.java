package dao;

import org.apache.ibatis.annotations.Param;
import pojo.Chat;
import pojo.Page;

import java.util.List;

public interface ChatMapper {
    public List<Chat> chatsByCtactId(@Param("contactId") String contactId);
    public int addChat(Chat chat);
    public int chatsNum(@Param("senderId")String senderId,@Param("receiverId")String receiverId);
    public List<Chat> chatsBySRId(@Param("senderId")String senderId, @Param("receiverId")String receiverId,@Param("page") Page page);
//    String list,1 textcontent，2 pictureURL，3 videoURL 4 lastContentTime
    public Chat lastChatInfo(@Param("contactId") String contactId);
}
