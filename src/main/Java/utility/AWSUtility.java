//package utility;
//
//import com.amazonaws.regions.Region;
//import com.amazonaws.secretsmanager.caching.SecretCache;
//
//import java.util.HashMap;
//
//public class AWSUtility {
//    private static final SecretCache cache  = new SecretCache();
//
//    private static final String SecretId = "arn:aws:secretsmanager:ca-central-1:866941515364:secret:rds!db-8631b034-c452-49f6-8480-3ff6da21c6e4-KQ9Srn";
//    public static void main(String[] args) {
//        System.out.println(getSecret());
//    }
//
//    public static String getSecret(){
//        final String secret  = cache.getSecretString(SecretId);
//        System.out.println("[info] 调用了 AWS");
//        return secret;
//    }
//}
