package utility;

import org.junit.jupiter.api.Test;

import java.util.Random;

public class RandomUtility {

    public String createIdByNum(int digit) {
        StringBuilder str = new StringBuilder();
        for (int i = 0; i < digit; i++) {
            if (i == 0 && digit > 1)
                str.append(new Random().nextInt(9) + 1);
            else
                str.append(new Random().nextInt(10));
        }
        System.out.println("生成的id===>" + str.toString());
        return str.toString();
    }
    @Test
    public void test(){
        createIdByNum(8);
    }
    public String createId() {
        StringBuilder str = new StringBuilder();
        for (int i = 0; i < 8; i++) {
            if (i == 0 && 8 > 1)
                str.append(new Random().nextInt(9) + 1);
            else
                str.append(new Random().nextInt(10));
        }
        System.out.println("生成的id===>" + str.toString());
        return str.toString();
    }
}
