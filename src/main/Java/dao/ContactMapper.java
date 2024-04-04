package dao;

import org.apache.ibatis.annotations.Param;
import pojo.Contact;

import java.util.List;

public interface ContactMapper {
    public int addContact(Contact contact);
    public List<Contact> contactsByUserId(@Param("userId") String userId);
    public List<Contact> contactsByUserIds(@Param("userId1") String userId1,@Param("userId2") String userId2);
    public String idByUserIds(@Param("userId1") String userId1,@Param("userId2") String userId2);
}
