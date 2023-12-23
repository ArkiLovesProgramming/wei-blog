<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <title>WEIBlog logout</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        body{
            background-color: #999999;
        }
        .logout-page-area{
            padding: 32px;
            width: 320px;
            background-color: white;
            margin: 0 auto;
            margin-top: 12%;
            border-radius: 16px;
        }
        .lpa-logo{
            width: 100%;
            text-align: center;
            height: 46px;
            color: #3f9bff;
            font-size: 30px;
            font-weight: 900;
            line-height: 46px;
            margin: 0px;
            padding: 0px 0px 0px 8px;
            margin-bottom: 16px;
        }
        .lpa-alert{
            font-size: 18px;
            line-height: 24px;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .lpa-alert-detial{
            font-size: 15px;
            font-weight: 400;
            line-height: 20px;
            color: rgb(83, 100, 113);
            margin-bottom: 24px;
        }
        .lpa-button{
            width: 100%;
            font-weight: 700;
            font-size: 15px;
            line-height: 42px;
            text-align: center;
            height: 42px;
            margin-bottom: 12px;
            border-radius: 20px;
            border: rgb(207, 217, 222) solid 1px;
        }
        .lpa-confirm-button{
            background-color: #000000;
            color: white;
            border-color: #000000;
        }
        .lpa-confirm-button:hover{
            background-color: #282c30;
            cursor: pointer;
        }
        .lpa-cancel-button{
            background-color: white;
            margin-bottom: 0px;
        }
        .lpa-cancel-button:hover{
            background-color: #e7e7e8;
            cursor: pointer;
        }
    </style>
</head>
<body>
<div class="container h-100">
    <div class="logout-page-area">
        <div class="lpa-logo">
            WEI
        </div>
        <div class="lpa-alert">
            Log out of WEIBlog?
        </div>
        <div class="lpa-alert-detial">
            You can log in WEIBlog anytime you want!
        </div>
        <div class="lpa-confirm-button lpa-button confirm">
            Log out
        </div>
        <div class="lpa-cancel-button lpa-button cancel">
            Cancel
        </div>
<%--        <a class="lpa-cancel-button lpa-button" href="javascript :;" onclick="javascript:history.back(-1)">返回上一页</a>--%>
    </div>
</div>
<script>
    $(".confirm").click(function (){
        $(window).attr('location','User/logout');
    });
    $(".cancel").click(function () {
        history.go(-1);
    })
</script>
</body>
</html>

