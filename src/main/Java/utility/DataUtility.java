package utility;

import pojo.Similarity;

import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DataUtility {
    public Float similarity(String str1,String str2){
        //计算两个字符串的长度。
        int len1 = str1.length();
        int len2 = str2.length();
        //建立上面说的数组，比字符长度大一个空间
        int[][] dif = new int[len1 + 1][len2 + 1];
        //赋初值，步骤B。
        for (int a = 0; a <= len1; a++) {
            dif[a][0] = a;
        }
        for (int a = 0; a <= len2; a++) {
            dif[0][a] = a;
        }
        //计算两个字符是否一样，计算左上的值
        int temp;
        for (int i = 1; i <= len1; i++) {
            for (int j = 1; j <= len2; j++) {
                if (str1.charAt(i - 1) == str2.charAt(j - 1)) {
                    temp = 0;
                } else {
                    temp = 1;
                }
                //取三个值中最小的
                dif[i][j] = min(dif[i - 1][j - 1] + temp, dif[i][j - 1] + 1,
                        dif[i - 1][j] + 1);
            }
        }
        System.out.println("字符串\""+str1+"\"与\""+str2+"\"的比较");
        //取数组右下角的值，同样不同位置代表不同字符串的比较
        System.out.println("差异步骤："+dif[len1][len2]);
        //计算相似度
        float similarity =1 - (float) dif[len1][len2] / Math.max(str1.length(), str2.length());
        System.out.println("相似度："+getPercentValue(similarity));
        return Float.parseFloat(String.format("%.5f",similarity));
    }

    public static String getPercentValue( float similarity){
        NumberFormat fmt = NumberFormat.getPercentInstance();
        fmt.setMaximumFractionDigits(2);//最多5位百分小数，如25.23%
        return fmt.format(similarity);
    }
    //得到最小值
    private static int min(int... is) {
        int min = Integer.MAX_VALUE;
        for (int i : is) {
            if (min > i) {
                min = i;
            }
        }
        return min;
    }


//    List<Similarity>去重
    public List<Similarity> removeSimi(List<Similarity> simiList){
        String tempId;
        List<Similarity> simiList2 = new ArrayList<Similarity>();
        for (Similarity simi : simiList){
            if (simi.getUser()!=null){
                tempId = simi.getUser().getId();
            } else {
                tempId = simi.getContent().getId();
            }

            int judge = 0;
            for (Similarity simi2 : simiList2){
                if (simi2.getUser()!=null){
                    if (simi2.getUser().getId() == tempId){
                        judge = 1;
                    }
                } else {
                    if (simi2.getContent().getId() == tempId){
                        judge = 1;
                    }
                }
            }
            if (judge == 0){
                simiList2.add(simi);
            }
        }
        return simiList2;
    }

    public String removeHtmlTags(String htmlStr) {
        //定义script的正则表达式，去除js可以防止注入
        String scriptRegex="<script[^>]*?>[\\s\\S]*?<\\/script>";
        //定义style的正则表达式，去除style样式，防止css代码过多时只截取到css样式代码
        String styleRegex="<style[^>]*?>[\\s\\S]*?<\\/style>";
        //定义HTML标签的正则表达式，去除标签，只提取文字内容
        String htmlRegex="<[^>]+>";
        //定义空格,回车,换行符,制表符
        String spaceRegex = "\t|\r|\n";
//        俩个以上的空格
        String mutiSpace = "\\s{2,}";

        // 过滤script标签
        htmlStr = htmlStr.replaceAll(scriptRegex, "");
        // 过滤style标签
        htmlStr = htmlStr.replaceAll(styleRegex, "");
        // 过滤html标签
        htmlStr = htmlStr.replaceAll(htmlRegex, "");
        // 过滤空格等
        htmlStr = htmlStr.replaceAll(spaceRegex, "");
        htmlStr = htmlStr.replaceAll(mutiSpace," ");
        return htmlStr.trim(); // 返回文本字符串
    }

    public static void main(String[] args) {
        DataUtility d = new DataUtility();
        String html = "<div class=\"d-flex flex-column\"><span>哈哈哈<img src=\"images/emojis/emoji_sprite_03.gif\" class=\"emoji-item\">there is  a apple!</span><span><br></span><span>傻逼儿子！<img src=\"images/emojis/emoji_sprite_51.gif\" class=\"emoji-item\"></span></div>";
        String text = d.removeHtmlTags(html);
        System.out.println(text);
    }
}
