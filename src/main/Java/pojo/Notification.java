package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import utility.DateUtility;
import utility.RandomUtility;

@Data
@AllArgsConstructor
public class Notification {
    private String id;
    private Integer type;//0：系统 1：关注 2：取消关注
    private String textContent;
    private String targetUserId;//通知对象
    private String creatingTime;
    private String userId;//系统通知此项为""
    private Integer readed;
    private Integer deleted;

    public Notification(){
        DateUtility dateUtility = new DateUtility();
        RandomUtility r = new RandomUtility();
        System.out.println("通知里操作：");
        this.id = r.createId();
        this.creatingTime = dateUtility.getDate();
        this.readed = 0;
        this.deleted = 0;
        this.textContent = "";
        this.targetUserId = "";
        this.userId = "";
    }

    public void setNull(){
        this.id = null;
        this.type = null;
        this.textContent = null;
        this.targetUserId = null;
        this.userId = null;
        this.creatingTime = null;
        this.readed = null;
        this.deleted = null;
    }

}
