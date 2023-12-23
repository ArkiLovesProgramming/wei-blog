package dao;

import org.apache.ibatis.annotations.Param;
import pojo.Page;
import pojo.User;

import java.util.List;

public interface UserMapper {
    public int addUser(User user);
    public User checkUser(@Param("email") String email,@Param("password") String password);
    public User getUserById(@Param("id")String id);
    public int updateUser(User user);
    public String getSField(@Param("field")String field,@Param("userId")String userId);
    public List<User> usersByIds(@Param("ids") List<String> ids,@Param("orderSql") String orderSql);
    public List<User> allUsers();
//    who to follower模块
    public List<User> whoToFollower(@Param("userId") String userId,@Param("page") Page page);
}
