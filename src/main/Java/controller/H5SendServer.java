package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Random;

@Controller
@RequestMapping("/send")
public class H5SendServer {
    @RequestMapping(value = "/serverSend",produces = "text/event-stream;charset=UTF-8;")
    @ResponseBody
    public String serverSend(HttpServletResponse response)
    {
        try{
            Thread.sleep(5000);
        }catch(Exception e){
            e.printStackTrace();
        }
        return "data: {\n" +
                "data: \"foo\" : \"bar\",\n" +
                "data: \"baz\" : 555\n" +
                "data: }\n\n";
    }
}
