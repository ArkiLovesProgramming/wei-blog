package service;

import dao.ChatMapper;
import dao.ContactMapper;
import pojo.Chat;
import pojo.Page;

import java.util.List;

public class ChatServiceImpl implements ChatService{

    //    注入进来的
    private ChatMapper chatMapper;

    //    必须要有set方法才能接收依赖注入
    public void setChatMapper(ChatMapper chatMapper) {
        this.chatMapper = chatMapper;
    }


    @Override
    public List<Chat> chatsByCtactId(String contactId) {
        return this.chatMapper.chatsByCtactId(contactId);
    }

    @Override
    public int addChat(Chat chat) {
        return this.chatMapper.addChat(chat);
    }

    @Override
    public int chatsNum(String senderId, String receiverId) {
        return this.chatMapper.chatsNum(senderId,receiverId);
    }

    @Override
    public List<Chat> chatsBySRId(String senderId, String receiverId, Page page) {
        return this.chatMapper.chatsBySRId(senderId,receiverId,page);
    }

    @Override
    public Chat lastChatInfo(String contactId) {
        return this.chatMapper.lastChatInfo(contactId);
    }
}
