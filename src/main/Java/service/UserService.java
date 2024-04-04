package service;

import org.apache.ibatis.annotations.Param;
import pojo.Page;
import pojo.User;

import java.util.List;

public interface UserService {
    public int addUser(User user);
    public User checkUser(String email,String password);
    public User getUserById(String id);
    public User getUserByEmail(String email);
    public int updateUser(User user);
    public String getSField(String field, String userId);
    public List<User> usersByIds(List<String> ids,String orderSql);
    public List<User> allUsers();
    public List<User> whoToFollower(String userId, Page page);
}
