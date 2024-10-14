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
        String picPath = request.getServletContext().getRealPath("/uploadFile/image");
//        如果路径不存在，创建一个
        File picP = new File(picPath);
        if (!picP.exists()){
            picP.mkdirs();
        }
        String videoPath = request.getServletContext().getRealPath("/uploadFile/video");
//        如果路径不存在，创建一个
        File vidP = new File(videoPath);
        if (!vidP.exists()){
            vidP.mkdirs();
        }

        System.out.println("上传图片保存地址=>"+picP);
        System.out.println("上传视频保存地址=>"+vidP);
        System.out.println("第一个=>"+firstFile.isEmpty());
        System.out.println("第二个=>"+secondFile.isEmpty());
        System.out.println("视频是=>"+video.isEmpty());
        if (video.isEmpty()){
            String firstfileName = new String(firstFile.getOriginalFilename().getBytes("ISO-8859-1"), "UTF-8");
            String secondfileName = new String(secondFile.getOriginalFilename().getBytes("ISO-8859-1"), "UTF-8");
            if (!firstFile.isEmpty() && secondFile.isEmpty()){
//        通过commonsMultipartFile的方法直接写文件
                firstFile.transferTo(new File(picPath+"/" + firstfileName));
                return "uploadFile/image/"+ firstfileName +"|0";
            } else if (firstFile.isEmpty() && !secondFile.isEmpty()){
                secondFile.transferTo(new File(picPath+"/" + secondfileName));
                return "uploadFile/image/"+ secondfileName +"|0";
            } else if (!firstFile.isEmpty() && !secondFile.isEmpty()){
                firstFile.transferTo(new File(picPath+"/"+firstfileName));
                secondFile.transferTo(new File(picPath+"/"+secondfileName));
                return "uploadFile/image/"+firstfileName+",uploadFile/image/"+secondfileName+"|0";
            } else {
                System.out.println("p1 p2都为空");
                return "0|0";
            }
        } else {
            String videoName = new String(video.getOriginalFilename().getBytes("ISO-8859-1"), "UTF-8");
            video.transferTo(new File(videoPath+"/" + videoName));
            return "0|"+"uploadFile/video/"+videoName;
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
            bgFile.transferTo(new File(picPath+"/"+bgFile.getOriginalFilename()));
            return "uploadFile/image/"+bgFile.getOriginalFilename() + "," + "0";
        }
        else if (!pfFile.isEmpty() && bgFile.isEmpty()){
            pfFile.transferTo(new File(picPath+"/"+pfFile.getOriginalFilename()));
            return "0,uploadFile/image/"+pfFile.getOriginalFilename();
        }
        else if (!pfFile.isEmpty() && !bgFile.isEmpty()){
            bgFile.transferTo(new File(picPath+"/"+bgFile.getOriginalFilename()));
            pfFile.transferTo(new File(picPath+"/"+pfFile.getOriginalFilename()));
            return "0,uploadFile/image/"+pfFile.getOriginalFilename();
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
        // 去掉base64编码的头部 如："data:image/jpeg;base64," 如果不去，转换的图片不可以查看
        file = file.substring(23);
        //解码
        byte[] imgByte = decoder.decode(file);

        String fileName = "";
        try {
            String picPath = request.getServletContext().getRealPath("/uploadFile/image");
//        如果路径不存在，创建一个
            File picP = new File(picPath);
            if (!picP.exists()){
                picP.mkdirs();
            }
            fileName = getFileName();
            String resultUrl = picPath + "/" + fileName;
            FileOutputStream out = new FileOutputStream(resultUrl); // 输出文件路径
            out.write(imgByte);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "{\"url\":\""+"uploadFile/image/"+fileName+"\"}";
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
