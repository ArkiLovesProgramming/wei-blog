package service;

import dao.ContentMapper;
import dao.UserMapper;
import pojo.Content;
import pojo.Page;

import java.util.List;

public class ContentServiceImpl implements ContentService{
    //    注入进来的
    private ContentMapper contentMapper;

    //    必须要有set方法才能接收依赖注入
    public void setContentMapper(ContentMapper contentMapper) {
        this.contentMapper = contentMapper;
    }

    @Override
    public int sendContent(Content content) {
        return this.contentMapper.sendContent(content);
    }

    @Override
    public List<Content> getAllContents() {
        return this.contentMapper.getAllContents();
    }

    @Override
    public List<Content> conByAuthIds(List<String> ids,Page page) {
        return this.contentMapper.conByAuthIds(ids,page);
    }

    @Override
    public List<Content> conByIds(List<String> ids) {
        return this.contentMapper.conByIds(ids);
    }

    @Override
    public List<Content> mediaConByAuthId(String authorId,Page page) {
        return this.contentMapper.mediaConByAuthId(authorId,page);
    }

    @Override
    public Content conById(String id) {
        return this.contentMapper.conById(id);
    }

    @Override
    public int likeContent(String contentId, String userId) {
        return this.contentMapper.likeContent(contentId, userId);
    }

    @Override
    public int unlikeContent(String contentId, String userId) {
        return this.contentMapper.unlikeContent(contentId, userId);
    }

    @Override
    public int updateContent(Content content) {
        return this.contentMapper.updateContent(content);
    }

    @Override
    public String getSField(String field, String contentId) {
        return this.contentMapper.getSField(field, contentId);
    }

    @Override
    public int getIField(String field, String contentId) {
        return this.contentMapper.getIField(field, contentId);
    }

    @Override
    public List<Content> getChildCon(String parentId, String level) {
        return this.contentMapper.getChildCon(parentId, level);
    }

    @Override
    public List<Content> consByTopicId(String topicId,Page page) {
        return this.contentMapper.consByTopicId(topicId,page);
    }

    @Override
    public List<Content> allConsBySql(String sql) {
        return this.contentMapper.allConsBySql(sql);
    }

    @Override
    public List<Content> allPhotoContent() {
        return this.contentMapper.allPhotoContent();
    }


}
