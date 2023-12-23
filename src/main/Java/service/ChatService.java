package service;

import org.apache.ibatis.annotations.Param;
import pojo.Chat;
import pojo.Page;

import java.util.List;

public interface ChatService {
    public List<Chat> chatsByCtactId(String contactId);
    public int addChat(Chat chat);
    public int chatsNum(String senderId,String receiverId);
    public List<Chat> chatsBySRId(String senderId,String receiverId,Page page);
    public Chat lastChatInfo(String contactId);
}
