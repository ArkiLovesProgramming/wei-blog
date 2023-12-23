package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Content {
    private String id;
    private String textContent;
    private String pictureURL;
    private String videoURL;
    private String authorId;
    private String topicIds;
    private Integer likeNum;
    private String likeIds;
    private Integer commentNum;
    private String commentIds;
    private Integer bookmarkNum;
    private String bookmarkIds;
    private Integer transmitNum;
    private String transmitIds;
    private String level;
    private String parentId;
    private String releasingTime;
    private String childContentId;
    private Integer playNum;
    private Integer deleted;
    private Integer visible;
}
