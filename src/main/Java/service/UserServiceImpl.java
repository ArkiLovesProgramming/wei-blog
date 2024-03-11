package service;

import dao.UserMapper;
import pojo.Page;
import pojo.User;

import java.util.List;

public class UserServiceImpl implements UserService {
    //    注入进来的
    private UserMapper userMapper;

    //    必须要有set方法才能接收依赖注入
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    //    although it looks redundant, but it conforms to principle of separation of service layer and bussiness logic layer
    public int addUser(User user) {
        return this.userMapper.addUser(user);
    }

    @Override
    public User checkUser(String email, String password) {
        return this.userMapper.checkUser(email,password);
    }

    @Override
    public User getUserById(String id) {
        return this.userMapper.getUserById(id);
    }

    @Override
    public int updateUser(User user) {
        return this.userMapper.updateUser(user);
    }

    @Override
    public String getSField(String field, String userId) {
        return this.userMapper.getSField(field,userId);
    }

    @Override
    public List<User> usersByIds(List<String> ids, String orderSql) {
        return this.userMapper.usersByIds(ids,orderSql);
    }

    @Override
    public List<User> allUsers() {
        return this.userMapper.allUsers();
    }

    @Override
    public List<User> whoToFollower(String userId, Page page) {
        return this.userMapper.whoToFollower(userId,page);
    }


}
