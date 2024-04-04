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
    <title>WEIBlog login page</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="css/all.css"/>
    <link rel="stylesheet" type="text/css" href="css/login.css"/>

    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/all.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/lr.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(document).ready(function() {
            myAlert("Email authentication successful! try to log in!");
            if ($(".login-box").is(':visible')) {
                $(".login-email").click();
            } else {
                $(".register-name").click();
            }

        });
    </script>
</head>
<body>
<div class="">
    <div class="login-area">
        <div class="la-logo">
            <span>WEI</span>
        </div>
        <div class="register-login-box">
            <div class="login-box">
                <div class="lb-title d-flex flex-column">
                    <span>现在就登录WEIBlog!</span>
                    <span>立即登录！获取你自己的个性化内容！</span>
                </div>
                <div class="lb-form">
                    <div class="lb-form-input">
                        <div class="lbf-item email login-email">
                            <span>Email</span>
                            <input type="text" />
                        </div>
                        <div class="lbf-item password login-password">
                            <span>Password</span>
                            <input type="text" />
                        </div>
                    </div>
                    <div class="lb-alert-area">
                        <span>Authenticate email successfully! Registration completed, try to log in!</span>
                        <img src="images/icon/success.png" >
                    </div>
                    <div class="lb-buttons">
                        <div class="lbf-button toLogin">
                            <span>To Login</span>
                        </div>
                        <div class="lbf-button forgetPassword">
                            <span>Forgot password?</span>
                        </div>
                        <div class="lbf-lrSwitch">
                            <span>No account?</span>
                            <span class="rl-switch">register</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="register-box" style="display: none;">
                <div class="lb-title d-flex flex-column">
                    <span>还没有WEI博客账号？</span>
                    <span>立即注册！获取你自己的个性化内容！</span>
                </div>
                <div class="lb-form">
                    <div class="lb-form-input">
                        <div class="lbf-item name register-name">
                            <span>Name</span>
                            <input type="text" />
                        </div>
                        <div class="lbf-item email register-email">
                            <span>Email</span>
                            <input type="text" />
                        </div>
                        <div class="lbf-item password register-password">
                            <span>Password</span>
                            <input type="text" />
                        </div>
                    </div>
                    <div class="lb-alert-area">
                        <span>The authentication information has been sent to your email address</span>
                        <img src="images/icon/success.png" >
                    </div>
                    <div class="lb-buttons">
                        <div class="lbf-button toRegister">
                            <span>To register</span>
                        </div>
                        <!-- <div class="lbf-button forgetPassword">
                            <span>Forgot password?</span>
                        </div> -->
                        <div class="lbf-lrSwitch">
                            <span>Existing account?</span>
                            <span class="rl-switch">login in</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 点击放大图片 -->
<div id="picture_enlargement_box">
    <img id="large_pic" src="" >
</div>
<div class="fake-alert-box">
    <div class="alert-box">
        <span></span>
        <span class="alert-text"></span>
    </div>
</div>
<!-- 弹窗蒙层 -->
<div class="suspend-cover total-suspend" style="z-index: 5;"></div>
</body>
</html>
