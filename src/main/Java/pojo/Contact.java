package pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.SneakyThrows;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Contact{
    private String id;
    private String creator;
    private String contactIds;
    private String lastContactTime;
    private String lastContent;//不存入数据库中，Messages/""由每次list的时候再数据库获取最后一条信息
    private String creatingTime;
    private String closedIds;


    public static void ListSort(List<Contact> list) {
        Collections.sort(list, new Comparator<Contact>() {
            @Override
            //定义一个比较器
            public int compare(Contact c1, Contact c2) {
                SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH/mm");
                try {
                    Date dt1 = df.parse(c1.getLastContactTime());
                    Date dt2 = df.parse(c2.getLastContactTime());
                    if (dt1.getTime() < dt2.getTime()) {
                        return 1;
                    } else if (dt1.getTime() > dt2.getTime()) {
                        return -1;
                    } else {
                        return 0;
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                return 0;
            }
        });
    }

    public static void main(String[] args) {
        List<Contact> contacts = new ArrayList<Contact>();
        String[] dateArr = {"2022/05/23 06/23","2022/04/10 05/30","2022/2/4 11/24","2022/4/11 06/12"};
        for (int i = 0; i < 4; i++){
            Contact c = new Contact();
            c.setLastContent("lastContent:"+i);
            c.setLastContactTime(dateArr[i]);
            contacts.add(c);
        }
        System.out.println("排序前:");
        for (Contact c : contacts) {
            System.out.println(c.getLastContent()+" "+c.getLastContactTime());
        }
        Contact.ListSort(contacts);
        System.out.println("排序后:");
        for (Contact c : contacts) {
            System.out.println(c.getLastContent()+" === "+c.getLastContactTime());
        }
    }
}
