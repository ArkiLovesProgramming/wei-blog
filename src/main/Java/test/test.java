package test;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import pojo.Chat;
import pojo.Notification;
import pojo.Topic;
import utility.DataUtility;
import utility.RandomUtility;

import java.util.ArrayList;
import java.util.List;

public class test {
    public static void main(String[] args) throws JsonProcessingException {
        test t = new test();
        t.test1();
    }

    public void test1() throws JsonProcessingException {
        ObjectMapper mapper=new ObjectMapper();
        for (int i = 0; i < 3; i++) {
            Chat chat = new Chat();
            chat.setId("id"+i);
            chat.setTextContent("content:"+i);
            String jsonStr=mapper.writeValueAsString(chat);
            System.out.println(jsonStr);
        }
    }
}
