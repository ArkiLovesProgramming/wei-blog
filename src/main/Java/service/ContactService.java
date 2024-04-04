package service;

import org.apache.ibatis.annotations.Param;
import pojo.Contact;

import java.util.List;

public interface ContactService {
    public int addContact(Contact contact);
    public List<Contact> contactsByUserId(String userId);
    public List<Contact> contactsByUserIds(String userId1,String userId2);
    public String idByUserIds(String userId1,String userId2);
}
