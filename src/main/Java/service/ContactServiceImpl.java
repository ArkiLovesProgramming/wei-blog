package service;

import dao.ContactMapper;
import dao.ContentMapper;
import pojo.Contact;

import java.util.List;

public class ContactServiceImpl implements ContactService{

    //    注入进来的
    private ContactMapper contactMapper;

    //    必须要有set方法才能接收依赖注入
    public void setContactMapper(ContactMapper contactMapper) {
        this.contactMapper = contactMapper;
    }


    @Override
    public int addContact(Contact contact) {
        return this.contactMapper.addContact(contact);
    }

    @Override
    public List<Contact> contactsByUserId(String userId) {
        return this.contactMapper.contactsByUserId(userId);
    }

    @Override
    public List<Contact> contactsByUserIds(String userId1, String userId2) {
        return this.contactMapper.contactsByUserIds(userId1,userId2);
    }

    @Override
    public String idByUserIds(String userId1, String userId2) {
        return this.contactMapper.idByUserIds(userId1, userId2);
    }

}
