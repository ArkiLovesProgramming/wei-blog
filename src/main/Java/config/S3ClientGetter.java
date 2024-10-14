package config;

import com.amazonaws.HttpMethod;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.http.apache.ApacheHttpClient;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.GetObjectRequest;
import software.amazon.awssdk.services.s3.presigner.S3Presigner;
import software.amazon.awssdk.services.s3.presigner.model.GetObjectPresignRequest;
import software.amazon.awssdk.services.s3.presigner.model.PresignedGetObjectRequest;

import java.net.URL;
import java.time.Duration;
import java.util.Date;

public class S3ClientGetter {
    public static String bucketName = "weiweiblog";
    public static S3Client s3Client() {
        return S3Client.builder()
                .httpClientBuilder(ApacheHttpClient.builder())
                .build();
    }

    public static String getS3PresignedUrl(String objectKey) {
        // 创建 S3 客户端
        S3Client s3Client = s3Client();

        S3Presigner presigner = S3Presigner.create();

        GetObjectRequest objectRequest = GetObjectRequest.builder()
                .bucket(bucketName)
                .key(objectKey)
                .build();


        GetObjectPresignRequest presignRequest = GetObjectPresignRequest.builder()
                .signatureDuration(Duration.ofMillis(1000L * 60 * 60 * 1))  // The URL will expire in 10 minutes.
                .getObjectRequest(objectRequest)
                .build();


        PresignedGetObjectRequest presignedRequest = presigner.presignGetObject(presignRequest);

        URL url = presignedRequest.url();

        // 打印预签名 URL
//        System.out.println("Pre-Signed URL: " + url.toString());
        return url.toString();
    }

}
