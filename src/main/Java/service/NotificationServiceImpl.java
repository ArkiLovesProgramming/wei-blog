package service;

import dao.ContentMapper;
import dao.NotificationMapper;
import pojo.Notification;

import java.util.List;

public class NotificationServiceImpl implements NotificationService{
    //    注入进来的
    private NotificationMapper notificationMapper;

    //    必须要有set方法才能接收依赖注入
    public void setNotificationMapper(NotificationMapper notificationMapper) {
        this.notificationMapper = notificationMapper;
    }


    @Override
    public int notify(Notification notification) {
        return this.notificationMapper.notify(notification);
    }

    @Override
    public List<Notification> notisByTUId(String targetUserId) {
        return this.notificationMapper.notisByTUId(targetUserId);
    }

    @Override
    public int updateNotification(Notification notification) {
        return this.notificationMapper.updateNotification(notification);
    }

    @Override
    public int notisNumByTUId(String targetUserId) {
        return this.notificationMapper.notisNumByTUId(targetUserId);
    }

}
