package pojo;

import lombok.Data;
import utility.RandomUtility;

import java.util.*;

//相似度对象
@Data
public class Similarity implements Comparable<Similarity>{
    private int similarity;
    private Content content = null;
    private User user = null;
    private Topic topic = null;

    public Similarity(User user, int similarity) {
        this.user = user;
        this.similarity = similarity;
    }
    public Similarity(Content content, int similarity) {
        this.content = content;
        this.similarity = similarity;
    }
    public Similarity(Topic topic, int similarity) {
        this.topic = topic;
        this.similarity = similarity;
    }
    public Similarity() {

    }

    public Object getObject(){
        if (this.content != null){
            return this.content;
        } else if(this.user != null) {
            return this.user;
        } else if(this.topic != null){
            return this.topic;
        }
        return null;
    }

    @Override
    public int compareTo(Similarity s) {
        int tmp = s.getSimilarity() - this.getSimilarity();
        return tmp;
    }
}
