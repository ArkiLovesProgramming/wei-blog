package service;

import org.apache.ibatis.annotations.Param;
import pojo.Notification;

import java.util.List;

public interface NotificationService {
    public int notify(Notification notification);
    public List<Notification> notisByTUId(String targetUserId);
    public int updateNotification(Notification notification);
    public int notisNumByTUId(String targetUserId);
}
