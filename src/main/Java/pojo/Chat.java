package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Chat {
    private String id;
    private String contactId;
    private String textContent;
    private String senderId;
    private String receiverId;
    private String releasingTime;
    private String pictureURL;
    private String videoURL;
    private Integer deleted = 0;
    private Integer readed = 0;
}
