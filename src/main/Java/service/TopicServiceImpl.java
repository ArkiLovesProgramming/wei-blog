package service;

import dao.ContentMapper;
import dao.TopicMapper;
import pojo.Topic;

import java.util.List;

public class TopicServiceImpl implements TopicService{
    //    注入进来的
    private TopicMapper topicMapper;

    //    必须要有set方法才能接收依赖注入
    public void setTopicMapper(TopicMapper topicMapper) {
        this.topicMapper = topicMapper;
    }

    @Override
    public int addTopic(Topic topic) {
        return this.topicMapper.addTopic(topic);
    }

    @Override
    public List<Topic> getAllTopic() {
        return this.topicMapper.getAllTopic();
    }

    @Override
    public List<Topic> getParentTopic() {
        return this.topicMapper.getParentTopic();
    }

    @Override
    public List<Topic> topicByPId(String parentId) {
        return this.topicMapper.topicByPId(parentId);
    }

    @Override
    public List<Topic> topTopics(String type) {
        return this.topicMapper.topTopics(type);
    }

    @Override
    public Topic topicById(String topicId) {
        return this.topicMapper.topicById(topicId);
    }

    @Override
    public int updateTopic(Topic topic) {
        return this.topicMapper.updateTopic(topic);
    }
}
