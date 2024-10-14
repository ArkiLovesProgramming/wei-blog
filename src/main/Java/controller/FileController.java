package controller;

import java.security.Key;
import java.util.Base64.Decoder;

import config.S3ClientGetter;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.Bucket;
import software.amazon.awssdk.services.s3.model.ListBucketsResponse;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;

@Controller
@RequestMapping("/File")
public class FileController {

    S3Client s3Client = S3ClientGetter.s3Client();


    @RequestMapping("/uploadFile")
    @ResponseBody
    public String uploadFile(@RequestParam("firstFile")CommonsMultipartFile firstFile,@RequestParam("secondFile")CommonsMultipartFile secondFile,
                             @RequestParam("video")CommonsMultipartFile video,HttpServletRequest request) throws IOException {

//        System.out.println("上传图片保存地址=>"+picP);
//        System.out.println("上传视频保存地址=>"+vidP);
//        System.out.println("第一个=>"+firstFile.isEmpty());
//        System.out.println("第二个=>"+secondFile.isEmpty());
//        System.out.println("视频是=>"+video.isEmpty());
        if (video.isEmpty()){
            String firstfileName = new String(firstFile.getOriginalFilename().getBytes("ISO-8859-1"), "UTF-8");
            String secondfileName = new String(secondFile.getOriginalFilename().getBytes("ISO-8859-1"), "UTF-8");
            firstfileName = addTimestamp(firstfileName);
            secondfileName = addTimestamp(secondfileName);
            if (!firstFile.isEmpty() && secondFile.isEmpty()){
                PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                        .bucket(S3ClientGetter.bucketName)
                        .key("contents/image/" + firstfileName)
                        .build();
                s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(firstFile)));
                String url = "contents/image/" + firstfileName;
                return url +"|0";
            } else if (firstFile.isEmpty() && !secondFile.isEmpty()){
                PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                        .bucket(S3ClientGetter.bucketName)
                        .key("contents/image/" + secondfileName)
                        .build();
                s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(secondFile)));
                String url = "contents/image/" + secondfileName;
                return url +"|0";
            } else if (!firstFile.isEmpty() && !secondFile.isEmpty()){
                PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                        .bucket(S3ClientGetter.bucketName)
                        .key("contents/image/" + firstfileName)
                        .build();
                s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(firstFile)));
                String url = "contents/image/" + firstfileName;
                PutObjectRequest putObjectRequest2 = PutObjectRequest.builder()
                        .bucket(S3ClientGetter.bucketName)
                        .key("contents/image/" + secondfileName)
                        .build();
                s3Client.putObject(putObjectRequest2, RequestBody.fromFile(convertMultiPartToFile(secondFile)));
                String url2 = "contents/image/" + secondfileName;
                return url + "," + url2 + "|0";
            } else {
                System.out.println("p1 p2都为空");
                return "0|0";
            }
        } else {
            String videoName = new String(video.getOriginalFilename().getBytes("ISO-8859-1"), "UTF-8");
            videoName = addTimestamp(videoName);
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(S3ClientGetter.bucketName)
                    .key("contents/video/" + videoName)
                    .build();
            s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(video)));
            String url = "contents/video/" + videoName;
            return "0|" + url;
        }
    }

    @GetMapping("Messages/presignedUrl")
    @ResponseBody
    public String getPresignedUrl(@RequestParam("key") String key) {
        String presigned_url = S3ClientGetter.getS3PresignedUrl(key);
        return presigned_url;
    }

    @PostMapping("Messages/uploadFile")
    @ResponseBody
    public String uploadFile2(@RequestParam("msgFile") CommonsMultipartFile msgFile,HttpServletRequest request) throws IOException {
        String mediaType = msgFile.getContentType();
        Boolean isImage;
        if (mediaType.startsWith("image/")){
            isImage = true;
        } else {
            isImage = false;
        }
        Boolean isVideo = !isImage;

        if (!msgFile.isEmpty()){
            String filename = addTimestamp(msgFile.getOriginalFilename());
            if (isImage){
                PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                        .bucket(S3ClientGetter.bucketName)
                        .key("messages/image/" + filename)
                        .build();
                s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(msgFile)));
                String url = "messages/image/" + filename;
                return url;
            } else if (isVideo){
                PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                        .bucket(S3ClientGetter.bucketName)
                        .key("messages/video/" + filename)
                        .build();
                String url = "messages/video/" + filename;
                return url;
            }
        }
        return "error";
    }

    // 在文件名后添加时间戳
    public static String addTimestamp(String filename) {
        // 提取文件扩展名
        String extension = "";
        int dotIndex = filename.lastIndexOf(".");
        if (dotIndex > 0 && dotIndex < filename.length() - 1) {
            extension = filename.substring(dotIndex);
            filename = filename.substring(0, dotIndex); // 去掉扩展名的部分
        }

        // 生成当前时间的时间戳
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timestamp = sdf.format(new Date());

        // 拼接文件名、时间戳和扩展名
        return filename + "_" + timestamp + extension;
    }

    // 将 CommonsMultipartFile 转换为 File
    public File convertMultiPartToFile(CommonsMultipartFile file) throws IOException {
        File convFile = new File(file.getOriginalFilename());
        FileOutputStream fos = new FileOutputStream(convFile);
        fos.write(file.getBytes());
        fos.close();
        return convFile;
    }

    @RequestMapping("User/Edition/uploadFile")
    @ResponseBody
    public String uploadFile3(@RequestParam("bgPicUrl") CommonsMultipartFile bgFile,@RequestParam("profilePicUrl") CommonsMultipartFile pfFile,HttpServletRequest request) throws IOException {
        String picPath = request.getServletContext().getRealPath("/uploadFile/image");
//        如果路径不存在，创建一个
        File picP = new File(picPath);
        if (!picP.exists()){
            picP.mkdirs();
        }
        if (!bgFile.isEmpty() && pfFile.isEmpty()){
            String bgFileName = bgFile.getOriginalFilename();
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(S3ClientGetter.bucketName)
                    .key("users/image/" + bgFileName)
                    .build();
            s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(bgFile)));
            String url = "users/image/" + bgFileName;
            return url + "," + "0";
        }
        else if (!pfFile.isEmpty() && bgFile.isEmpty()){
            String pfFileName = pfFile.getOriginalFilename();
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(S3ClientGetter.bucketName)
                    .key("users/image/" + pfFileName)
                    .build();
            s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(pfFile)));
            String url = "users/image/" + pfFileName;
            return "0," + url;
        }
        else if (!pfFile.isEmpty() && !bgFile.isEmpty()){
            String bgFileName = bgFile.getOriginalFilename();
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(S3ClientGetter.bucketName)
                    .key("users/image/" + bgFileName)
                    .build();
            s3Client.putObject(putObjectRequest, RequestBody.fromFile(convertMultiPartToFile(bgFile)));
            String url = "users/image/" + bgFileName;
            String pfFileName = pfFile.getOriginalFilename();
            PutObjectRequest putObjectRequest2 = PutObjectRequest.builder()
                    .bucket(S3ClientGetter.bucketName)
                    .key("users/image/" + pfFileName)
                    .build();
            s3Client.putObject(putObjectRequest2, RequestBody.fromFile(convertMultiPartToFile(pfFile)));
            String url2 = "users/image/" + pfFileName;
            return "0," + url2;
        }
        else {
            return "0,0";
        }
    }


    @RequestMapping(value = "Cropper/uploadFile")
    @ResponseBody
    public String cropper(String file, HttpServletRequest request) throws Exception {

        System.out.println("到了！");
        Decoder decoder = Base64.getDecoder();

        // 去掉base64编码的头部
        file = file.substring(23);

        // 解码 base64 为字节数组
        byte[] imgByte = decoder.decode(file);

        String fileName = "";
        try {
            // 生成唯一的文件名
            fileName = getFileName() + ".png"; // 可以根据文件类型动态调整扩展名

            // 构建 S3 上传请求
            PutObjectRequest putObjectRequest = PutObjectRequest.builder()
                    .bucket(S3ClientGetter.bucketName) // 替换为你的 S3 存储桶名称
                    .key("users/image/" + fileName)    // S3 上的文件路径
                    .build();

            // 将字节数组直接上传到 S3
            s3Client.putObject(putObjectRequest, RequestBody.fromBytes(imgByte));

        } catch (Exception e) {
            e.printStackTrace();
            return "{\"error\":\"上传失败\"}";
        }

        // 返回文件的 S3 URL
        String s3Url = "users/image/" + fileName;
        return "{\"url\":\"" + s3Url + "\"}";
    }

    private String getFileName() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String timeStr = sdf.format(new Date());
        String str = RandomStringUtils.random(5,
                "abcdefghijklmnopqrstuvwxyz1234567890");
        String name = timeStr + str + ".jpeg";
        return name;
    }

    public static void main(String[] args) {
//        FileController c = new FileController();
//        System.out.println(c.getFileName());

//        S3Client s3Client = S3ClientGetter.s3Client();
//        ListBucketsResponse listBucketsResponse = s3Client.listBuckets();
//        for (Bucket bucket : listBucketsResponse.buckets()) {
//            System.out.println(bucket.name());
//        }
        S3ClientGetter.getS3PresignedUrl("img/arki_profile_pic.d3d24c33.jpg");
    }

}
