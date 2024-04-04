package dao;

import org.apache.ibatis.annotations.Param;
import pojo.Notification;

import java.util.List;

public interface NotificationMapper {
    public int notify(Notification notification);
    public List<Notification> notisByTUId(@Param("targetUserId") String targetUserId);
    public int updateNotification(Notification notification);
    public int notisNumByTUId(@Param("targetUserId") String targetUserId);
}
