package dao;

import org.apache.ibatis.annotations.Param;
import pojo.Content;
import pojo.Page;

import java.util.List;

public interface ContentMapper {
    public int sendContent(Content content);
    public List<Content> getAllContents();
    public List<Content> conByAuthIds(@Param("ids") List<String> ids, @Param("page")Page page);
    public List<Content> conByIds(@Param("ids") List<String> ids);
    public List<Content> mediaConByAuthId(@Param("authorId") String authorId, @Param("page") Page page);
    public Content conById(@Param("id") String id);
    public int likeContent (@Param("contentId")String contentId,@Param("userId")String userId);
    public int unlikeContent (@Param("contentId")String contentId,@Param("userId")String userId);
    public int updateContent(Content content);
    public String getSField(@Param("field")String field,@Param("contentId")String contentId);
    public int getIField(@Param("field")String field,@Param("contentId")String contentId);
    public List<Content> getChildCon(@Param("parentId")String parentId, @Param("level")String level);
    public List<Content> consByTopicId(@Param("topicId") String topicId,@Param("page") Page page);
    public List<Content> allConsBySql(@Param("sql") String sql);
    public List<Content> allPhotoContent();
}
