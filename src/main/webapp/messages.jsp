<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<base href="<%=basePath%>">
<head>
    <meta charset="utf-8">
    <title>WEI Blog</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="./css/all.css" />
    <link rel="stylesheet" type="text/css" href="css/window.css" />
    <link rel="stylesheet" type="text/css" href="css/navigator.css" />
    <link rel="stylesheet" type="text/css" href="./css/index.css"/>
    <link rel="stylesheet" type="text/css" href="css/messages.css"/>
    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/all.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/index.js" type="text/javascript" charset="utf-8"></script>
    <script src="./js/myjs/messages.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/content.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/navigator.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<%--用span来储存session user.id的值--%>
<div class="d-none fakeSession"><span class="fs-id">${sessionScope.user.id}</span></div>
<div class="row box p-0">
    <div class="fake_navigator col-2 col-lg-1 col-xl-3"></div>
    <div class="navigator col-2 col-lg-1 col-xl-3">
        <div class="top">
            <a href="<%=basePath%>Content/explore" id="logo" class="menu">
                WEI
            </a>
        </div>
        <div class="menu_box">
            <c:if test="${not empty sessionScope.user}">
                <a href="<%=basePath%>Content/getHomeContents" class="menu">
                    <img src="images/icon/home.png" />
                    <span>Blogs</span>
                </a>
            </c:if>
            <a href="<%=basePath%>Content/explore" class="menu">
                <img src="images/icon/explore.png" />
                <span>Explore</span>
            </a>
            <c:if test="${not empty sessionScope.user}">
                <a href="<%=basePath%>Notifications" class="menu">
                    <div class="d-inline-block position-relative" style="vertical-align: top;">
                        <img src="images/icon/notification.png" />
                        <c:if test="${sessionScope.notificationNum > 0}">
                            <div class="notify-icon">
                                <c:if test="${sessionScope.notificationNum > 99}">
                                    <span>99</span>
                                </c:if>
                                <c:if test="${sessionScope.notificationNum <= 99}">
                                    <span>${sessionScope.notificationNum}</span>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                    <span>Notis</span>
                </a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <a href="<%=basePath%>Messages" class="menu">
                    <img src="images/icon/message.png" />
                    <span>Message</span>
                </a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <a class="menu">
                    <img src="images/icon/lists.png" />
                    <span>Friends</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a href="<%=basePath%>Topic/topics" class="menu">
                    <img src="images/icon/bookmark.png" />
                    <span>Topics</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a href="<%=basePath%>User/detailUser/${sessionScope.user.id}" class="menu">
                    <img src="images/icon/profile.png" />
                    <span>Profile</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a class="menu">
                    <img src="images/icon/more.png" />
                    <span>More</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a href="<%=basePath%>Content/getHomeContents" class="menu d-block menu_send" style="text-align: center;">
                    <img src="images/icon/send.png" />
                    <span>WEISend</span>
                </a>
            </c:if>
        </div>
        <c:if test="${not empty sessionScope.user}">
            <div class="current_account">

                <!-- 点击头像框弹出 -->
                <div class="tdb-show-box">
                    <div class="touxiang-details-box">
                        <div class="touxiang-details d-flex flex-row">
                            <img src="${sessionScope.user.profilePicUrl}" >
                            <div class="touxiang-details-text">
                                <span>${sessionScope.user.name}</span>
                                <span>@${sessionScope.user.email}</span>
                            </div>
                        </div>
                        <div class="tdb-item logout-button">
                            <span>Log out @${sessionScope.user.email}</span>
                        </div>
                    </div>
                    <div class="ca-triangle">
                        <div class="ca-triangle-icon"></div>
                        <div class="ca-triangle-icon ca-triangle-icon2"></div>
                    </div>
                </div>
                <!-- 点击头像框弹出 -->

                <div id="touxiang_box">
                    <img class="" src="${sessionScope.user.profilePicUrl}" >
                    <div class="account_info">
                        <span class="account-name">${sessionScope.user.name}</span>
                        <span class="account-id">@${sessionScope.user.email}</span>
                    </div>
                </div>
            </div>
        </c:if>

    </div>

    <div class="contact_list_box col-10 col-lg-4 col-xl-4">
        <div class="top">
            <div class="title">
                <span>Messages</span>
                <div class="add_contact_bt">
                    <img src="images/icon/addmess.png" >
                </div>
            </div>
        </div>
        <div class="contact_search_box">
            <div class="contact_search_border d-flex flex-row">
                <img src="images/icon/search.png" >
                <input type="text" id="contact_search_border_input" value="" placeholder="
Search for people and groups"/>
            </div>
        </div>

        <div class="contact_list">
            <c:forEach var="contact" items="${sessionScope.contacts}">
                <c:set var="user" value="${sessionScope.ctactIdMapUser[contact.id]}"/>
                <a href="<%=basePath%>Messages/${sessionScope.user.id}-${user.id}" class="contact_list_item d-flex flex-row"
                <c:if test="${requestScope.chatTargetUser.id == user.id}">
                style="border-right: #499bea solid 2px"
                </c:if>
                >
                    <img src="${user.profilePicUrl}" />
                    <div class="contact_list_content">
                        <div class="d-flex flex-row">
                            <span class="contact_item_name">${user.name}&nbsp;</span>
                            <span class="contact_item_id">@${user.email}</span>
                            <span class="ml-auto contact_item_date" <c:if test="${requestScope.chatTargetUser.id == user.id}"> style="left: 2px" </c:if> >
                                <c:if test="${contact.lastContactTime ne ''}">
                                    <jsp:useBean id="now" class="java.util.Date" />
                                    <fmt:parseDate value="${contact.lastContactTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                    <c:set var="intervalf" value="${now.time - rtf.time}"/>
                                    <fmt:formatNumber var="minute" value="${intervalf/1000/60}" pattern="#0"/>
                                    <fmt:formatNumber var="hour" value="${minute/60}" pattern="#0"/>
                                    <fmt:formatDate var="week"  value="${rtf}" pattern="E" />
                                    <fmt:formatDate var="tdate" value="${rtf}" pattern="MMM d" />
                                    <c:if test="${minute < 60}">${minute}m</c:if>
                                    <c:if test="${minute >= 60 && (minute/60) < 24}">${hour}h</c:if>
                                    <c:if test="${(minute/60) >= 24 && (minute/60/24) < 7}">${week}</c:if>
                                    <c:if test="${(minute/60/24) >= 7}">${tdate}</c:if>
                                </c:if>
                            </span>
                        </div>


                        <div class="contact_item_lastcontent d-block" >${contact.lastContent}</div>
                    </div>
                </a>
            </c:forEach>
<%--            <div class="contact_list_item d-flex flex-row">--%>
<%--                <img src="images/profile/touxiang.png" />--%>
<%--                <div class="contact_list_content flex-fill">--%>
<%--                    <span class="contact_item_name">Mu Rui Qing🎭</span>--%>
<%--                    <span class="contact_item_id">@betaSSQQ1314</span>--%>
<%--                    <span class="contact_item_id float-right position-relative">1h</span>--%>
<%--                    <span class="contact_item_id d-block">hi</span>--%>
<%--                </div>--%>
<%--            </div>--%>
            <!-- ----- -->
        </div>

        <div class="cl-null-alert">
            <div>
                <div class="cna-alert-title">Send a message, get a message</div>
                <div class="cna-alert-content">Direct Messages are private conversations between you and other people on Twitter. Share Tweets, media, and more!</div>
                <div>
                    <div class="myButton">
                        <span>Start a conversation</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="chating_area position-relative d-none d-lg-flex flex-column col-lg-7 col-xl-5">
        <div id="currentChat-id" class="d-none">${requestScope.currentContactId}</div>
        <div id="currentChatUser-id" class="d-none">${requestScope.chatTargetUser.id}</div>
        <div id="realtop" class="top d-flex flex-row">
            <div class="gobacktolist">
                <img src="images/icon/goback.png" >
            </div>
            <img src="${requestScope.chatTargetUser.profilePicUrl}" >
            <div class="chating_area_top_info flex-fill">
                <span class="d-block">${requestScope.chatTargetUser.name}</span>
                <span>@${requestScope.chatTargetUser.email}</span>
            </div>
        </div>
        <div class="chating flex-fill">
            <div class="chating_info">
                <span class="chating_info_name" style="font-size: 15px;">${requestScope.chatTargetUser.name}</span>
                <span style="color: #566470;font-size: 15px;">@${requestScope.chatTargetUser.email}</span>
                <div class="personal_statement">
                    ${requestScope.chatTargetUser.signature}
                </div>
                <span class="d-inline-block following_span m-0"><span>${requestScope.chatTargetUser.followingNum}</span> Following</span>
                <span class="d-inline-block follower_span m-0"><span>${requestScope.chatTargetUser.followerNum}</span> Followers</span>
                <span class="joined_time d-block m-0"><img src="images/icon/calendar.png" >
                    <fmt:parseDate value="${requestScope.chatTargetUser.creatingTime}" var="thisCreatingTime"
                                   pattern="yyyy/MM/dd HH/mm" />
                    <fmt:formatDate var="joiningTime" value="${thisCreatingTime}" pattern="MMM yyyy" />
                    Joined ${joiningTime}
                </span>
            </div>


            <c:if test="${requestScope.chats != null}">
                <c:forEach var="chat" items="${requestScope.chats}">
                    <c:if test="${chat.senderId != sessionScope.user.id}">
                        <div class="others_chating_items">
                            <c:if test="${chat.videoURL != '0' || chat.pictureURL != '0'}">
                                <div class="chating-tiem-media" style="padding-left: 51px;">
                                    <c:if test="${chat.pictureURL != '0'}">
                                        <div class="ctm-pic-box" style="border-bottom-left-radius:0px">
                                            <img class="zoomable_pic" src="${chat.pictureURL}" >
                                        </div>
                                    </c:if>
                                    <c:if test="${chat.videoURL != '0'}">
                                        <div class="ctm-video-box" style="border-bottom-left-radius:0px">
                                            <video controls autoplay muted loop>
                                                <source src="${chat.videoURL}" type="video/mp4" />
                                            </video>
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>
                            <div class="chating_items_main position-relative d-flex flex-row">
                                <div style="width: 52px;"></div>
                                <img src="${requestScope.chatTargetUser.profilePicUrl}" >
                                <c:if test="${chat.textContent != ''}">
                                    <div class="others_chating_content general_content" style="border-bottom-left-radius: 0px;">
                                            ${chat.textContent}
                                    </div>
                                </c:if>
                            </div>
                            <div class="chating_items_date">
                                <jsp:useBean id="now1" class="java.util.Date" />
                                <fmt:parseDate value="${chat.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                <c:set var="intervalf" value="${now1.time - rtf.time}"/>
                                <fmt:formatNumber var="minute" value="${intervalf/1000/60}" pattern="#0"/>
                                <c:if test="${minute/60 >= 48}">
                                    <span><fmt:formatDate value="${rtf}" pattern="MMM dd,h:mm a" /></span>
                                </c:if>
                                <c:if test="${minute/60 >= 24 && minute/60 <48}">
                                    <span>Yesterday,<fmt:formatDate value="${rtf}" pattern="h:mm a" /></span>
                                </c:if>
                                <c:if test="${minute/60 < 24}">
                                    <span><fmt:formatDate value="${rtf}" pattern="h:mm a" /></span>
                                </c:if>
                            </div>
                        </div>
                    </c:if>


                    <c:if test="${chat.senderId == sessionScope.user.id}">
                        <div class="my_chating_items">
                            <c:if test="${chat.videoURL != '0' || chat.pictureURL != '0'}">
                                <div class="chating-tiem-media d-flex flex-row-reverse">
                                    <c:if test="${chat.pictureURL != '0'}">
                                        <div class="ctm-pic-box" style="border-bottom-right-radius:0px">
                                            <img class="zoomable_pic" src="${chat.pictureURL}" >
                                        </div>
                                    </c:if>
                                    <c:if test="${chat.videoURL != '0'}">
                                        <div class="ctm-video-box" style="border-bottom-right-radius:0px">
                                            <video controls autoplay muted loop>
                                                <source src="${chat.videoURL}" type="video/mp4" />
                                            </video>
                                        </div>
                                    </c:if>
                                </div>
                            </c:if>
                            <div class="chating_items_main d-flex flex-row-reverse">
                                <c:if test="${chat.textContent != ''}">
                                    <div class="my_chating_content general_content" style="border-bottom-right-radius: 0px">
                                            ${chat.textContent}
                                    </div>
                                </c:if>
                            </div>
                            <div class="chating_items_date d-flex flex-row-reverse">
                                <jsp:useBean id="now2" class="java.util.Date" />
                                <fmt:parseDate value="${chat.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                <c:set var="intervalf" value="${now2.time - rtf.time}"/>
                                <fmt:formatNumber var="minute" value="${intervalf/1000/60}" pattern="#0"/>
                                <c:if test="${minute/60 >= 48}">
                                    <span><fmt:formatDate value="${rtf}" pattern="MMM dd,h:mm a" /></span>
                                </c:if>
                                <c:if test="${minute/60 >= 24 && minute/60 <48}">
                                    <span>Yesterday,<fmt:formatDate value="${rtf}" pattern="h:mm a" /></span>
                                </c:if>
                                <c:if test="${minute/60 < 24}">
                                    <span><fmt:formatDate value="${rtf}" pattern="h:mm a" /></span>
                                </c:if>
                            </div>
                        </div>
                    </c:if>

                </c:forEach>
            </c:if>
        </div>

        <div class="typing_area d-flex flex-row">
            <div class="typingarea-cover" onClick="event.cancelBubble = true"></div>
            <!-- 滚动条 -->
            <div class="progress ta_uplaod_bar">
                <div class="progress-bar" style="width:0%"></div>
            </div>

            <div class="typing_img_box typing_img_box-hover send-img-func" style="margin-left: 6px;">
                <img src="images/icon/image.png" >
            </div>
            <form id="msgFile-form" enctype="multipart/form-data" method="post">
                <input type="file" name="msgFile" accept="image/*,video/*" id="msg-file-input" class="d-none"/>
            </form>

            <!-- 表情 -->
            <div class="typing_img_box typing_img_box-hover open-stick-select position-relative">
                <img src="images/icon/stick.png" >
                <div class="message-stick-box sticks-list-box" onClick="event.cancelBubble = true">
                    <div class="slb-title position-relative">
                        <div class="triangle-icon"></div>
                        <div class="triangle-icon triangle-icon2"></div>
                        <span>Smileys & people</span>
                    </div>
                    <div class="sticks-list-show">
                        <!-- <div class="stick-item-row d-flex flex-row">
                            <div class="stick-item flex-fill">
                                <img src="images/emojis/emoji_sprite_01.gif" >
                            </div>
                        </div> -->
                    </div>
                    <div class="sticks-show-box">
                        <img src="images/emojis/emoji_sprite_22.gif" >
                    </div>
                </div>
            </div>

            <div class="typing_input_box flex-fill">
                <div class="tis-area d-none">
                    <div class="typing-img-show d-none">
                        <div class="cancel-btn">
                            ×
                        </div>
                        <img src="./images/profile/bg.png" >
                    </div>

                    <div class="typing-video-show d-none">
                        <div class="cancel-btn">
                            ×
                        </div>
                        <video height="100%" controls autoplay muted loop>
                            <source src="#" type="video/mp4"></source>
                        </video>
                    </div>
                </div>

                <div id="div-editable" class="send-mess-input" contenteditable="true" ><div class="d-flex flex-column" ><span></span></div></div>
            </div>
            <div  id="send-message-btn" class="typing_img_box" style="padding-left: 6px;">
                <div class="btn-cover" onclick="event.cancelBubble = true"></div>
                <img src="images/icon/sendmess.png" >
            </div>

        </div>

        ${requestScope.chats}
        <c:if test="${requestScope.chats == null}">
            <div class="alertModel">
                <div>
                    <div class="am-alert-title">You don’t have a message selected</div>
                    <div class="am-alert-content">Choose one from your existing messages, or start a new one.</div>
                    <div>
                        <div class="myButton">
                            <span>New message</span>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

    </div>

    <!-- 弹窗蒙层 -->
    <div class="suspend-cover total-suspend" style="z-index: 5;"></div>

</div>

</div>
<!-- 点击放大图片 -->
<div id="picture_enlargement_box">
    <img id="large_pic" src="" >
</div>
<!-- 添加联系人 -->
<div id="addnewcontact_box">
    <div class="addnewcontact">
        <div class="top d-flex flex-row">
            <span>New message</span>
            <div class="anc-next-btn">
                <div class="anb-cover" onclick="event.cancelBubble = true"></div>
                <span>Next</span>
            </div>
        </div>
        <div class="searchnewcontact d-flex flex-row">
            <img src="images/icon/search.png" >
            <input type="text" class="flex-fill" placeholder="Search people"/>
        </div>
        <div class="peopleresult_box">

        </div>
    </div>



</div>
</body>
</html>
