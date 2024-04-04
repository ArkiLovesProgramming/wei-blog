package dao;

import org.apache.ibatis.annotations.Param;
import pojo.Topic;

import java.util.List;

public interface TopicMapper {
    public int addTopic(Topic topic);
    public List<Topic> getAllTopic();
    public List<Topic> getParentTopic();
    public List<Topic> topicByPId(@Param("parentId") String parentId);
    public List<Topic> topTopics(@Param("type") String type);
    public Topic topicById(@Param("topicId") String topicId);
    public int updateTopic(Topic topic);
}
