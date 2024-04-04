package service;

import org.apache.ibatis.annotations.Param;
import pojo.Content;
import pojo.Page;

import java.util.List;

public interface ContentService {
    public int sendContent(Content content);
    public List<Content> getAllContents();
    public List<Content> conByAuthIds(List<String> ids,Page page);//就是找出关注的人的ids，加自己的，找出这样的content，放在home页面
    public List<Content> conByIds(List<String> ids);
    public List<Content> mediaConByAuthId(String authorId,Page page);
    public Content conById(String id);
    public int likeContent (String contentId, String userId);
    public int unlikeContent (String contentId,String userId);
    public int updateContent(Content content);
    public String getSField(String field,String contentId);
    public int getIField(String field,String contentId);
    public List<Content> getChildCon(String parentId, String level);
    public List<Content> consByTopicId(String topicId,Page page);
    public List<Content> allConsBySql(String sql);
    public List<Content> allPhotoContent();
}
