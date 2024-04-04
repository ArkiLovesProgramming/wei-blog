<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<base href="<%=basePath%>">
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>WEIGlog注册成功</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .area{
            text-align: center;
        }
        .picbox{
            margin-top: 18px;
            margin-bottom: 10px;
        }
        .picbox img{
            width: 48px;
            height: 48px;
            position: relative;
            bottom: 1px;
            border-radius: 50%;
            background-color: #499BEA;
        }
        .la-logo{
            margin-top: 100px;
            height: 46px;
            color: #3f9bff;
            font-size: 30px;
            font-weight: 900;
            line-height: 46px;
            /* text-align: center; */
        }
        .textContent span{
            display: block;
            font-size: 20px;
            font-weight: 700;
        }
        .time{
            margin-top: 12px;
            font-size: 16px;
            font-weight: 500;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function(){
            function jump(){
                $(window).attr('location','login.jsp');
                setTimeout("jump()", 5000);
            }
            setTimeout(function(){jump();}, 5000);
            var num=0;
            var original = 5;
            $("#second").text(original--);
            setInterval(function(){
                $("#second").text(original--);
            },1000);
        });
    </script>
</head>
<body>
<div class="area">
    <div class="la-logo">
        <span>WEI</span>
    </div>
    <div class="picbox">
        <img src="images/icon/success.png" >
    </div>
    <div class="textContent">
        <span>Verify your email successful! </span>
        <span>WEIBlog account has been opened for you!</span>
    </div>
    <div class="time">
        <span>After <span id="second">5</span> seconds, the login page is displayed.</span>
    </div>
</div>
</body>
</html>

