package controller;

import java.util.Base64.Decoder;
import org.apache.commons.lang.RandomStringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

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
            if (!firstFile.isEmpty() && secondFile.isEmpty()){
//        通过commonsMultipartFile的方法直接写文件
                firstFile.transferTo(new File(picPath+"/"+firstFile.getOriginalFilename()));
                return "uploadFile/image/"+firstFile.getOriginalFilename()+"|0";
            } else if (firstFile.isEmpty() && !secondFile.isEmpty()){
                secondFile.transferTo(new File(picPath+"/"+secondFile.getOriginalFilename()));
                return "uploadFile/image/"+secondFile.getOriginalFilename()+"|0";
            } else if (!firstFile.isEmpty() && !secondFile.isEmpty()){
                firstFile.transferTo(new File(picPath+"/"+firstFile.getOriginalFilename()));
                secondFile.transferTo(new File(picPath+"/"+secondFile.getOriginalFilename()));
                return "uploadFile/image/"+firstFile.getOriginalFilename()+",uploadFile/image/"+secondFile.getOriginalFilename()+"|0";
            } else {
                System.out.println("p1 p2都为空");
                return "0|0";
            }
        } else {
            video.transferTo(new File(videoPath+"/"+video.getOriginalFilename()));
            return "0|"+"uploadFile/video/"+video.getOriginalFilename();
        }

    }

    @RequestMapping("Messages/uploadFile")
    @ResponseBody
    public String uploadFile2(@RequestParam("msgFile") CommonsMultipartFile msgFile,HttpServletRequest request) throws IOException {
        System.out.println(msgFile.getContentType());
        String mediaType = msgFile.getContentType();
        Boolean isImage;
        if (mediaType.startsWith("image/")){
            isImage = true;
        } else {
            isImage = false;
        }
        Boolean isVideo = !isImage;

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
        if (!msgFile.isEmpty()){
            if (isImage){
                msgFile.transferTo(new File(picPath+"/"+msgFile.getOriginalFilename()));
                return "uploadFile/image/"+msgFile.getOriginalFilename();
            } else if (isVideo){
                msgFile.transferTo(new File(videoPath+"/"+msgFile.getOriginalFilename()));
                return "uploadFile/video/"+msgFile.getOriginalFilename();
            }
        }
        return "error";
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
    public String cropper(String file,HttpServletRequest request) throws Exception {

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
            FileController c = new FileController();
            fileName = c.getFileName();
            String resultUrl = picPath+"/"+fileName;
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
        FileController c = new FileController();
        System.out.println(c.getFileName());
    }

}
