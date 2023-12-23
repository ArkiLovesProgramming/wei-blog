package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private String id;
    private String name;
    private Integer gender;
    private String password;
    private String accountId;
    private String email;
    private String region;
    private String birthday;
    private String profilePicUrl;
    private String bgPicUrl;
    private String topicIds;
    private String signature;
    private Integer followingNum;
    private String followingIds;
    private Integer followerNum;
    private String followerIds;
    private String likedContentIds;
    private String bookmarkContentIds;
    private String creatingTime;

}
