package service;

import org.apache.ibatis.annotations.Param;
import pojo.Topic;

import java.util.List;

public interface TopicService {
    public int addTopic(Topic topic);
    public List<Topic> getAllTopic();
    public List<Topic> getParentTopic();
    public List<Topic> topicByPId(String parentId);
    public List<Topic> topTopics(String type);
    public Topic topicById(String topicId);
    public int updateTopic(Topic topic);
}
