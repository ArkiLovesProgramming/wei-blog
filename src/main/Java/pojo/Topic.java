package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Topic {
    private String id;
    private String name;
    private Integer isParent;
    private String parentId;
    private String userInTopicIds;
    private Integer userInTopicNum;
    private Integer contentNum;
    private String contentIds;
}
