package utility;

import org.junit.jupiter.api.Test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtility {
    private SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH/mm");
    private SimpleDateFormat dtf = new SimpleDateFormat("yyyy/MM/dd HH/mm/ss");

    @Test
    public void test(){getDateTime();}

//    获取现在时间
    public String getDate(){
        Date present = new Date();
        System.out.println(df.format(present));
        return df.format(present);
    }

    public String getDateTime(){
        Date present = new Date();
        System.out.println(dtf.format(present));
        return dtf.format(present);
    }

    public Date StringToDate(String s) throws ParseException {
        Date date = new Date();
        date = df.parse(s);
        return date;
    }

}
