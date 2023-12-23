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
    <title>WEI Blog</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="css/all.css" />
    <link rel="stylesheet" type="text/css" href="css/window.css" />
    <link rel="stylesheet" type="text/css" href="css/navigator.css" />
    <link rel="stylesheet" type="text/css" href="./css/index.css"/>
    <link rel="stylesheet" type="text/css" href="css/content.css"/>
    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/all.js" type="text/javascript" charset="UTF-8"></script>
    <script src="./js/myjs/index.js" type="text/javascript" charset="UTF-8"></script>
    <script src="./js/myjs/navigator.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/content.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/sendContent.js" type="text/javascript" charset="UTF-8"></script>
</head>
<body>
<%--用span来储存session user.id的值--%>
<div class="d-none fakeSession"><span class="fs-id">${sessionScope.user.id}</span></div>
<%--<div class="d-none fakeSession"><span class="fs-id">68817854</span></div>--%>
<div class="d-none fakeSession"><span class="detailContent-id">${sessionScope.detailContent.id}</span></div>
<div class="d-none fakeSession"><span class="detailContent-level">${sessionScope.detailContent.level}</span></div>
<div class="row box p-0">
    <div class="fake_navigator col-2 col-lg-1 col-xl-3"></div>
    <div class="navigator col-2 col-lg-1 col-xl-3">
        <div class="top">
            <a href="#" id="logo" class="menu">
                WEI
            </a>
        </div>
        <div class="menu_box">
            <c:if test="${not empty sessionScope.user}">
                <a href="#" class="menu">
                    <img src="images/icon/home.png" />
                    <span>内容</span>
                </a>
            </c:if>
            <div class="menu">
                <img src="images/icon/explore.png" />
                <span>探索</span>
            </div>
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
                    <span>通知</span>
                </a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <a class="menu">
                    <img src="images/icon/message.png" />
                    <span>微聊</span>
                </a>
            </c:if>
            <c:if test="${not empty sessionScope.user}">
                <a class="menu">
                    <img src="images/icon/lists.png" />
                    <span>好友</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a href="#" class="menu">
                    <img src="images/icon/bookmark.png" />
                    <span>书签</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a class="menu">
                    <img src="images/icon/profile.png" />
                    <span>主页</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a class="menu">
                    <img src="images/icon/more.png" />
                    <span>更多</span>
                </a>
            </c:if>

            <c:if test="${not empty sessionScope.user}">
                <a href="" class="menu d-block menu_send" style="text-align: center;">
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

    <div class="window col-10 col-lg-9">
        <div class="top"></div>
        <div class="top center_top">
            <a href="javascript:void(0)" class="goback" onclick="javascript:history.back(-1);">
                <img src="images/icon/goback.png" >
            </a>
            <div>
                <span>WEISend</span>
            </div>
        </div>
        <div class="content">
            <div class="con_sender_info d-flex flex-row">
                <img src="${sessionScope.comIdMapUser[detailContent.id].profilePicUrl}" >
                <div class="flex-fill">
                    <span>${sessionScope.comIdMapUser[detailContent.id].name}</span>
                    <span class="d-block">@${sessionScope.comIdMapUser[detailContent.id].email}</span>
                </div>
                <div class="con_sender_info_more">
                    ...
                </div>
            </div>

            <c:if test="${detailContent.level != '0'}">
                <div class="comment-target">
                    <span>Replying to</span>
                    <span>@${sessionScope.comIdMapUser[detailContent.parentId].name}</span>
                </div>
            </c:if>

            <div class="content_box">
                <div class="text_content">
                    ${detailContent.textContent}
                </div>
                <div class="ac_picture">
                    <c:if test="${detailContent.pictureURL ne '0'}">
                        <c:if test="${fn:contains(detailContent.pictureURL,',')}" >
                            <c:set value="${ fn:split(detailContent.pictureURL, ',') }" var="pictureURLs" />
                            <div class="double_picture_frame aspectration" data-ratio="16:9">
                                <div class="d-flex flex-row">
                                    <div class="first_picture flex-fill">
                                        <img src="${pictureURLs[0]}" class="zoomable_pic" >
                                    </div>
                                    <div class="second_picture flex-fill">
                                        <img src="${pictureURLs[1]}" class="zoomable_pic">
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${!fn:contains(detailContent.pictureURL,',')}" >
                            <div class="single_picture_frame">
                                <img class="hpicture zoomable_pic" src="${detailContent.pictureURL}" />
                            </div>
                        </c:if>
                    </c:if>
                    <c:if test="${detailContent.videoURL ne '0'}">
                        <div class="content_video_frame">
                            <video style="max-width: 100%;" height="100%" controls autoplay muted loop>
                                <source src="${detailContent.videoURL}" type="video/mp4"></source>
                            </video>
                        </div>
                    </c:if>
                </div>

                <div class="content_date">
                    <fmt:parseDate value="${detailContent.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                    <span>
                          <fmt:formatDate value="${rtf}" pattern="h:mm a · MMM d, yyyy" />
                    </span>
                    <span> · </span>
                    <span>Twitter for iPhone</span>
                </div>
            </div>
            <div class="forwarding-data-message">
                <div class="overflow-hidden">
                    <span class="fdm-num">${detailContent.commentNum}</span>
                    <span class="fdm_bg mr-2">Comment</span>
                    <span class="fdm-num">${detailContent.transmitNum}</span>
                    <span class="fdm_bg mr-2">Quote WEISends</span>
                    <span id="content-liked-num" class="fdm-num"><fmt:formatNumber value="${detailContent.likeNum}" /></span>
                    <span class="fdm_bg">Likes</span>
                </div>
            </div>
            <div class="m_content_card_bottom d-flex flex-row justify-content-around">
                <div class="parent-content-func-box">
                    <div class="commentpicbox" class="d-inline-block">
                        <img class="commentpic" src="images/icon/comment.png" >
                    </div>
                </div>
                <div class="parent-content-func-box">
                    <div class="transmitpicbox" class="d-inline-block">
                        <img class="transmitpic" src="images/icon/transmit.png" >
                    </div>
                </div>
                <div class="parent-content-func-box">
                    <div class="likepicbox" class="d-inline-block">
                        <c:if test="${fn:contains(sessionScope.user.likedContentIds,detailContent.id)}">
                            <img class="likepic" src="images/icon/liked.png" >
                        </c:if>
                        <c:if test="${!fn:contains(sessionScope.user.likedContentIds,detailContent.id)}">
                            <img class="likepic" src="images/icon/like.png" >
                        </c:if>
                    </div>
                </div>
                <div class="parent-content-func-box">
                    <div class="forwardingpicbox" class="d-inline-block">
                        <img class="forwardingpic" src="images/icon/forwarding.png">
                    </div>
                </div>
            </div>
            <div class="reply-box position-relative">
                <%--                发送的时候要贴蒙层--%>
                <div class="reply-box-cover"></div>
                <div class="reply-box-t">
                    Replying to <span>@${sessionScope.comIdMapUser[detailContent.id].email}</span>
                </div>
                <div class="rb-input_box d-flex flex-row">
                    <img src="${sessionScope.user.profilePicUrl}" >
                    <div id="div-editable" class="rb-input" contenteditable="true" ><div class="d-flex flex-column" ><span></span></div></div>
                </div>

                <!-- 图片框架 -->
                <div class="pff uploaded-picture-box d-none">
                    <div class="aid-picture-position position-relative">
                        <div class="cancel-upload-file">
                            ×
                        </div>
                        <img class="single-ul-pic" src="images/profile/test3.jpeg" >
                    </div>
                </div>

                <div class="pfs uploaded-picture-box d-none">
                    <div class="double-reply-pic flex-row d-flex aspectration" data-ratio="16:9">
                        <div class="d-flex flex-row">
                            <div class="drp-item">
                                <div class="cancel-upload-file">
                                    ×
                                </div>
                                <img class="double-ul-picf" src="" >
                            </div>
                            <div class="drp-item"style="margin-left: 12px;">
                                <div class="cancel-upload-file">
                                    ×
                                </div>
                                <img class="double-ul-pics" src="" >
                            </div>
                        </div>
                    </div>
                </div>
                <!-- 图片框架 -->

                <!-- 视频框架 -->
                <div class="uploaded-video-box d-none">
                    <div class="send-video-frame position-relative">
                        <div class="cancel-upload-file">
                            ×
                        </div>
                        <video style="max-width: 100%;" controls autoplay muted loop>
                            <source src="videos/testvideo.mp4" type="video/mp4"></source>
                        </video>
                    </div>
                </div>
                <!-- 视频框架 -->


                <div class="reply-box-b d-flex flex-row">
                    <div class="rbb_p_box send-image-func rpb-hover">
                        <div class="rpb-cover" onclick="event.cancelBubble = true"></div>
                        <img src="images/icon/image.png" >
                    </div>
                    <div class="rbb_p_box open-stick-select position-relative rpb-hover">
                        <img src="images/icon/stick.png" >

                        <div class="sticks-list-box" onClick="event.cancelBubble = true">
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
                    <div class="rbb_p_box send-video-func rpb-hover">
                        <div class="rpb-cover" onclick="event.cancelBubble = true"></div>
                        <img src="images/icon/video.png" >
                    </div>
                    <div class="rp_button">
                        Reply
                    </div>
                    <form id="rbb-form" enctype="multipart/form-data" method="post">
                        <input type="file" name="firstFile" id="rbb-file" accept="image/*" class="d-none"/>
                        <input type="file" name="secondFile" id="rbb-file-second" accept="image/*" class="d-none"/>
                        <input type="file" name="video" id="rbb-video" accept="video/*" class="d-none" />
                        <%--                            <input type="submit" id="rbb-submit" class="d-none"/>--%>
                    </form>
                </div>
            </div>

            <c:forEach var="comment" items="${sessionScope.comments}">
                <div class = "total-reply-item-box">
                    <div class="parent-rib reply-item-box d-flex flex-row border-0">
                        <div class="fakeSession"><span class="comment-id">${comment.id}</span></div>
                        <!-- <a class="direct-b" href="#test" data-toggle="collapse"></a> -->
                        <div class="rib-left">
                            <img src="${comIdMapUser[comment.id].profilePicUrl}" >
                            <div class="line-bar-dec-t d-none">

                            </div>
                            <c:if test="${not empty comIdMapChildCom[comment.id]}">
                                <div class="line-bar-dec-b">

                                </div>
                            </c:if>
                        </div>
                        <div class="rib-text-box flex-fill">
                            <div class="ribtb-top">
                                <span><span>${comIdMapUser[comment.id].name}</span><span class="ml-1 d-inline-block">@${comIdMapUser[comment.id].email}</span> ·
                                    <span>
                                        <jsp:useBean id="now" class="java.util.Date" />
                                        <fmt:parseDate value="${comment.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                        <c:set var="intervalf" value="${now.time - rtf.time}"/>
                                        <fmt:formatNumber var="minute" value="${intervalf/1000/60}" pattern="#0"/>
                                        <fmt:formatNumber var="hour" value="${minute/60}" pattern="#0"/>
                                        <fmt:formatDate var="week"  value="${rtf}" pattern="E" />
                                        <fmt:formatDate var="tdate" value="${rtf}" pattern="MMM d" />
                                        <c:if test="${minute < 60}">${minute}m</c:if>
                                        <c:if test="${minute >= 60 && (minute/60) < 24}">${hour}h</c:if>
                                        <c:if test="${(minute/60) >= 24 && (minute/60/24) < 7}">${week}</c:if>
                                        <c:if test="${(minute/60/24) >= 7}">${tdate}</c:if>
                                    </span>
                                </span>
                                <div class="rib-more">...</div>
                                <div class="suspended_card_more shadow">
                                    <a href=""><img src="images/icon/follow.png" ><span>关注${comIdMapUser[comment.id].name}</span></a>
                                    <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>
                                    <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>
                                </div>
                            </div>
                            <div class="ribc-tarword">
                                Replying to <span>@${comIdMapUser[detailContent.id].name}</span>
                            </div>
                            <div class="rib-content">
                                <span>${comment.textContent}</span>
                                <c:if test="${comment.pictureURL ne '0'}">
                                    <c:if test="${fn:contains(comment.pictureURL,',')}" >
                                        <c:set value="${ fn:split(comment.pictureURL, ',') }" var="pictureURLs" />
                                        <div class="double_pciture_frame aspectration" data-ratio="16:9">
                                            <div class="d-flex flex-row">
                                                <div class="first_picture flex-fill">
                                                    <img src="${pictureURLs[0]}" class="zoomable_pic" >
                                                </div>
                                                <div class="second_picture flex-fill">
                                                    <img src="${pictureURLs[1]}" class="zoomable_pic">
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${!fn:contains(comment.pictureURL,',')}" >
                                        <div class="actual_content_picture">
                                            <div class="content_picture_frame" style="max-width: 100%;">
                                                <img class="hpicture zoomable_pic" src="${comment.pictureURL}" />
                                            </div>
                                        </div>
                                    </c:if>
                                </c:if>
                                <c:if test="${comment.videoURL ne '0'}">
                                    <div class="actual_content_picture">
                                        <div class="content_video_frame">
                                            <video style="max-width: 100%;" height="100%" controls autoplay muted loop>
                                                <source src="${comment.videoURL}" type="video/mp4"></source>
                                            </video>
                                        </div>
                                    </div>
                                </c:if>

                            </div>

                            <div class="rib_bottom d-flex flex-row">
                                <div class="flex-fill d-flex flex-row">
                                    <div class="commentpicbox">
                                        <img class="commentpic" src="images/icon/comment.png" >
                                    </div>
                                    <div class="d-inline-block">
                                        <span>${comment.commentNum}</span>
                                    </div>
                                </div>
                                <div class="flex-fill d-flex flex-row">
                                    <div class="transmitpicbox">
                                        <img class="transmitpic" src="images/icon/transmit.png" >
                                    </div>
                                    <!-- 转发suspend 要给父元素加relative -->
                                    <div class="suspended_card_more shadow">
                                        <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>
                                    </div>
                                    <div class="d-inline-block">
                                        <span>${comment.transmitNum}</span>
                                    </div>
                                </div>

                                <div class="flex-fill d-flex flex-row">
                                    <div class="likepicbox">
                                        <c:if test="${fn:contains(sessionScope.user.likedContentIds,comment.id)}">
                                            <img class="likepic" src="images/icon/liked.png" >
                                        </c:if>
                                        <c:if test="${!fn:contains(sessionScope.user.likedContentIds,comment.id)}">
                                            <img class="likepic" src="images/icon/like.png" >
                                        </c:if>
                                    </div>
                                    <div class="d-inline-block">
                                        <span>${comment.likeNum}</span>
                                    </div>
                                </div>

                                <div class="flex-fill d-flex flex-row">
                                    <div class="forwardingpicbox">
                                        <img class="forwardingpic" src="images/icon/forwarding.png">
                                    </div>
                                    <!-- 转发suspend 要给父元素加relative -->
                                    <div class="suspended_card_more shadow">
                                        <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>
                                    </div>
                                    <div class="d-inline-block">
                                        <span>${comment.bookmarkNum}</span>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <c:if test="${not empty comIdMapChildCom[comment.id]}">
                        <c:forEach var="l2com"  items="${comIdMapChildCom[comment.id]}">
                            <div class="coc-box">
                                <div class="fakeSession"><span class="comment-id">${l2com.id}</span></div>
                                <div class="reply-item-box d-flex flex-row border-0">
                                    <div class="rib-left">
                                        <img src="${comIdMapUser[l2com.id].profilePicUrl}" >
                                        <div class="line-bar-dec-t"></div>
                                        <div class="line-bar-dec-b"></div>
                                    </div>
                                    <div class="rib-text-box flex-fill">
                                        <div class="ribtb-top">
                                            <span><span>${comIdMapUser[l2com.id].name}</span><span class="ml-1 d-inline-block">@${comIdMapUser[l2com.id].email}</span> ·
                                                <span>
                                                    <jsp:useBean id="now1" class="java.util.Date" />
                                                    <fmt:parseDate value="${l2com.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                                    <c:set var="intervalf" value="${now1.time - rtf.time}"/>
                                                    <fmt:formatNumber var="minute" value="${intervalf/1000/60}" pattern="#0"/>
                                                    <fmt:formatNumber var="hour" value="${minute/60}" pattern="#0"/>
                                                    <fmt:formatDate var="week"  value="${rtf}" pattern="E" />
                                                    <fmt:formatDate var="tdate" value="${rtf}" pattern="MMM d" />
                                                    <c:if test="${minute < 60}">${minute}m</c:if>
                                                    <c:if test="${minute >= 60 && (minute/60) < 24}">${hour}h</c:if>
                                                    <c:if test="${(minute/60) >= 24 && (minute/60/24) < 7}">${week}</c:if>
                                                    <c:if test="${(minute/60/24) >= 7}">${tdate}</c:if>
                                                </span>
                                            </span>
                                            <div class="rib-more">...</div>
                                            <div class="suspended_card_more shadow">
                                                <a href=""><img src="images/icon/follow.png" ><span>关注${comIdMapUser[l2com.id].name}</span></a>
                                                <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>
                                                <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>
                                            </div>
                                        </div>
                                        <div class="ribc-tarword">
                                            Replying to <span>@${comIdMapUser[comment.id].name}</span>
                                        </div>
                                        <div class="rib-content">
                                            <span>${l2com.textContent}</span>
                                            <c:if test="${l2com.pictureURL ne '0'}">
                                                <c:if test="${fn:contains(l2com.pictureURL,',')}" >
                                                    <c:set value="${ fn:split(l2com.pictureURL, ',') }" var="pictureURLs" />
                                                    <div class="double_pciture_frame aspectration" data-ratio="16:9">
                                                        <div class="d-flex flex-row">
                                                            <div class="first_picture flex-fill">
                                                                <img src="${pictureURLs[0]}" class="zoomable_pic" >
                                                            </div>
                                                            <div class="second_picture flex-fill">
                                                                <img src="${pictureURLs[1]}" class="zoomable_pic">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${!fn:contains(l2com.pictureURL,',')}" >
                                                    <div class="actual_content_picture">
                                                        <div class="content_picture_frame" style="max-width: 100%;">
                                                            <img class="hpicture zoomable_pic" src="${l2com.pictureURL}" />
                                                        </div>
                                                    </div>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${l2com.videoURL ne '0'}">
                                                <div class="actual_content_picture">
                                                    <div class="content_video_frame">
                                                        <video style="max-width: 100%;" height="100%" controls autoplay muted loop>
                                                            <source src="${l2com.videoURL}" type="video/mp4"></source>
                                                        </video>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="rib_bottom d-flex flex-row">
                                            <div class="flex-fill d-flex flex-row">
                                                <div class="commentpicbox">
                                                    <img class="commentpic" src="images/icon/comment.png" >
                                                </div>
                                                <div class="d-inline-block">
                                                    <span>${l2com.commentNum}</span>
                                                </div>
                                            </div>
                                            <div class="flex-fill d-flex flex-row">
                                                <div class="transmitpicbox">
                                                    <img class="transmitpic" src="images/icon/transmit.png" >
                                                </div>
                                                <!-- 转发suspend 要给父元素加relative -->
                                                <div class="suspended_card_more shadow">
                                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>
                                                </div>
                                                <div class="d-inline-block">
                                                    <span>${l2com.transmitNum}</span>
                                                </div>
                                            </div>

                                            <div class="flex-fill d-flex flex-row">
                                                <div class="likepicbox">
                                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,l2com.id)}">
                                                        <img class="likepic" src="images/icon/liked.png" >
                                                    </c:if>
                                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,l2com.id)}">
                                                        <img class="likepic" src="images/icon/like.png" >
                                                    </c:if>
                                                </div>
                                                <div class="d-inline-block">
                                                    <span>${l2com.likeNum}</span>
                                                </div>
                                            </div>

                                            <div class="flex-fill d-flex flex-row">
                                                <div class="forwardingpicbox">
                                                    <img class="forwardingpic" src="images/icon/forwarding.png">
                                                </div>
                                                <!-- 转发suspend 要给父元素加relative -->
                                                <div class="suspended_card_more shadow">
                                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>
                                                </div>
                                                <div class="d-inline-block">
                                                    <span>${l2com.bookmarkNum}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="rib_showmore">
                            <img src="images/icon/rib-showmore.png" >
                            <span>Show more</span>
                        </div>
                    </c:if>

                </div>
            </c:forEach>

            <!-- 开始 -->
<%--            <div class = "total-reply-item-box">--%>
<%--                <div class="parent-rib reply-item-box d-flex flex-row border-0">--%>
<%--                    <!-- <a class="direct-b" href="#test" data-toggle="collapse"></a> -->--%>
<%--                    <div class="rib-left">--%>
<%--                        <img src="./images/profile/touxiang.png" >--%>
<%--                        <div class="line-bar-dec-t d-none">--%>

<%--                        </div>--%>
<%--                        <div class="line-bar-dec-b">--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="rib-text-box flex-fill">--%>
<%--                        <div class="ribtb-top">--%>
<%--                            <span><span>Mu Rui Qing🎭</span><span class="ml-1 d-inline-block">@betaSSQQ1314</span> · <span>7h</span></span>--%>
<%--                            <div class="rib-more">...</div>--%>
<%--                            <div class="suspended_card_more shadow">--%>
<%--                                <a href=""><img src="images/icon/follow.png" ><span>关注Mu Rui Qing🎭</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="ribc-tarword">--%>
<%--                            Replying to <span>@mengqidlufei</span>--%>
<%--                        </div>--%>
<%--                        <div class="rib-content">--%>
<%--                            The view they are facing is a beautiful one. That’s probably why it was placed there. Outside of it being the crash site, it looks as if they are walking toward a beautiful sky--%>
<%--                        </div>--%>

<%--                        <div class="rib_bottom d-flex flex-row">--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="commentpicbox">--%>
<%--                                    <img class="commentpic" src="images/icon/comment.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="transmitpicbox">--%>
<%--                                    <img class="transmitpic" src="images/icon/transmit.png" >--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="likepicbox">--%>
<%--                                    <img class="likepic" src="images/icon/like.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="forwardingpicbox">--%>
<%--                                    <img class="forwardingpic" src="images/icon/forwarding.png">--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                    </div>--%>
<%--                </div>--%>

<%--                <div class="coc-box">--%>
<%--                    <div class="reply-item-box d-flex flex-row border-0">--%>
<%--                        <div class="rib-left">--%>
<%--                            <img src="./images/profile/touxiang.png" >--%>
<%--                            <div class="line-bar-dec-t">--%>

<%--                            </div>--%>
<%--                            <div class="line-bar-dec-b">--%>

<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="rib-text-box flex-fill">--%>
<%--                            <div class="ribtb-top">--%>
<%--                                <span><span>Mu Rui Qing🎭</span><span class="ml-1 d-inline-block">@betaSSQQ1314</span> · <span>7h</span></span>--%>
<%--                                <div class="rib-more">...</div>--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/follow.png" ><span>关注Mu Rui Qing🎭</span></a>--%>
<%--                                    <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>--%>
<%--                                    <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="ribc-tarword">--%>
<%--                                Replying to <span>@mengqidlufei</span>--%>
<%--                            </div>--%>
<%--                            <div class="rib-content">--%>
<%--                                The view they are facing is a beautiful one. That’s probably why it was placed there. Outside of it being the crash site, it looks as if they are walking toward a beautiful sky--%>
<%--                            </div>--%>

<%--                            <div class="rib_bottom d-flex flex-row">--%>
<%--                                <div class="flex-fill d-flex flex-row">--%>
<%--                                    <div class="commentpicbox">--%>
<%--                                        <img class="commentpic" src="images/icon/comment.png" >--%>
<%--                                    </div>--%>
<%--                                    <div class="d-inline-block">--%>
<%--                                        <span>2.7k</span>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                                <div class="flex-fill d-flex flex-row">--%>
<%--                                    <div class="transmitpicbox">--%>
<%--                                        <img class="transmitpic" src="images/icon/transmit.png" >--%>
<%--                                    </div>--%>
<%--                                    <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                    <div class="suspended_card_more shadow">--%>
<%--                                        <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                    </div>--%>
<%--                                    <div class="d-inline-block">--%>
<%--                                        <span>2.7k</span>--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="flex-fill d-flex flex-row">--%>
<%--                                    <div class="likepicbox">--%>
<%--                                        <img class="likepic" src="images/icon/like.png" >--%>
<%--                                    </div>--%>
<%--                                    <div class="d-inline-block">--%>
<%--                                        <span>54.1k</span>--%>
<%--                                    </div>--%>
<%--                                </div>--%>

<%--                                <div class="flex-fill d-flex flex-row">--%>
<%--                                    <div class="forwardingpicbox">--%>
<%--                                        <img class="forwardingpic" src="images/icon/forwarding.png">--%>
<%--                                    </div>--%>
<%--                                    <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                    <div class="suspended_card_more shadow">--%>
<%--                                        <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                    </div>--%>
<%--                                    <div class="d-inline-block">--%>
<%--                                        <span>54.1k</span>--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>
<%--                    </div>--%>

<%--                    <div id="" class="rib_showmore">--%>
<%--                        <img src="images/icon/rib-showmore.png" >--%>
<%--                        <span>Show more</span>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- 第二个test -->--%>

<%--            <div class = "total-reply-item-box">--%>
<%--                <div class="parent-rib reply-item-box d-flex flex-row border-0">--%>
<%--                    <!-- <a class="direct-b" href="#test" data-toggle="collapse"></a> -->--%>
<%--                    <div class="rib-left">--%>
<%--                        <img src="./images/profile/touxiang.png" >--%>
<%--                        <div class="line-bar-dec-t d-none">--%>

<%--                        </div>--%>
<%--                        <div class="line-bar-dec-b d-none">--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="rib-text-box flex-fill">--%>
<%--                        <div class="ribtb-top">--%>
<%--                            <span><span>Mu Rui Qing🎭</span><span class="ml-1 d-inline-block">@betaSSQQ1314</span> · <span>7h</span></span>--%>
<%--                            <div class="rib-more">...</div>--%>
<%--                            <div class="suspended_card_more shadow">--%>
<%--                                <a href=""><img src="images/icon/follow.png" ><span>关注Mu Rui Qing🎭</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="ribc-tarword">--%>
<%--                            Replying to <span>@mengqidlufei</span>--%>
<%--                        </div>--%>
<%--                        <div class="rib-content">--%>
<%--									<span>The view they are facing is a beautiful one. That’s probably why it was placed there. Outside of it being the crash site, it looks as if they are walking toward a beautiful sky--%>
<%--									</span>--%>
<%--                            <div class="actual_content_picture">--%>
<%--                                <div class="content_picture_frame" style="max-width: 100%;">--%>
<%--                                    <img class="hpiture zoomable_pic" src="images/profile/test.jpeg" />--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>

<%--                        <div class="rib_bottom d-flex flex-row">--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="commentpicbox">--%>
<%--                                    <img class="commentpic" src="images/icon/comment.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="transmitpicbox">--%>
<%--                                    <img class="transmitpic" src="images/icon/transmit.png" >--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="likepicbox">--%>
<%--                                    <img class="likepic" src="images/icon/like.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="forwardingpicbox">--%>
<%--                                    <img class="forwardingpic" src="images/icon/forwarding.png">--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- 第三个test -->--%>
<%--            <div class = "total-reply-item-box">--%>
<%--                <div class="parent-rib reply-item-box d-flex flex-row border-0">--%>
<%--                    <!-- <a class="direct-b" href="#test" data-toggle="collapse"></a> -->--%>
<%--                    <div class="rib-left">--%>
<%--                        <img src="./images/profile/touxiang.png" >--%>
<%--                        <div class="line-bar-dec-t d-none">--%>

<%--                        </div>--%>
<%--                        <div class="line-bar-dec-b d-none">--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="rib-text-box flex-fill">--%>
<%--                        <div class="ribtb-top">--%>
<%--                            <span><span>Mu Rui Qing🎭</span><span class="ml-1 d-inline-block">@betaSSQQ1314</span> · <span>7h</span></span>--%>
<%--                            <div class="rib-more">...</div>--%>
<%--                            <div class="suspended_card_more shadow">--%>
<%--                                <a href=""><img src="images/icon/follow.png" ><span>关注Mu Rui Qing🎭</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="ribc-tarword">--%>
<%--                            Replying to <span>@mengqidlufei</span>--%>
<%--                        </div>--%>
<%--                        <div class="rib-content">--%>
<%--									<span>The view they are facing is a beautiful one. That’s probably why it was placed there. Outside of it being the crash site, it looks as if they are walking toward a beautiful sky--%>
<%--									</span>--%>
<%--                            <div class="actual_content_picture">--%>
<%--                                <div class="content_video_frame">--%>
<%--                                    <video style="max-width: 100%;" height="100%" controls autoplay muted loop>--%>
<%--                                        <source src="videos/testvideo.mp4" type="video/mp4"></source>--%>
<%--                                    </video>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>

<%--                        <div class="rib_bottom d-flex flex-row">--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="commentpicbox">--%>
<%--                                    <img class="commentpic" src="images/icon/comment.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="transmitpicbox">--%>
<%--                                    <img class="transmitpic" src="images/icon/transmit.png" >--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="likepicbox">--%>
<%--                                    <img class="likepic" src="images/icon/like.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="forwardingpicbox">--%>
<%--                                    <img class="forwardingpic" src="images/icon/forwarding.png">--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- 第四个div -->--%>
<%--            <div class = "total-reply-item-box">--%>
<%--                <div class="parent-rib reply-item-box d-flex flex-row border-0">--%>
<%--                    <!-- <a class="direct-b" href="#test" data-toggle="collapse"></a> -->--%>
<%--                    <div class="rib-left">--%>
<%--                        <img src="./images/profile/touxiang.png" >--%>
<%--                        <div class="line-bar-dec-t d-none">--%>

<%--                        </div>--%>
<%--                        <div class="line-bar-dec-b d-none">--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="rib-text-box flex-fill">--%>
<%--                        <div class="ribtb-top">--%>
<%--                            <span><span>Mu Rui Qing🎭</span><span class="ml-1 d-inline-block">@betaSSQQ1314</span> · <span>7h</span></span>--%>
<%--                            <div class="rib-more">...</div>--%>
<%--                            <div class="suspended_card_more shadow">--%>
<%--                                <a href=""><img src="images/icon/follow.png" ><span>关注Mu Rui Qing🎭</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="ribc-tarword">--%>
<%--                            Replying to <span>@mengqidlufei</span>--%>
<%--                        </div>--%>
<%--                        <div class="rib-content">--%>
<%--									<span>The view they are facing is a beautiful one. That’s probably why it was placed there. Outside of it being the crash site, it looks as if they are walking toward a beautiful sky--%>
<%--									</span>--%>
<%--                            <div class="double_pciture_frame aspectration" data-ratio="16:9">--%>
<%--                                <div class="d-flex flex-row">--%>
<%--                                    <div class="first_picture flex-fill">--%>
<%--                                        <img src="images/profile/test5.jpeg" class="zoomable_pic" >--%>
<%--                                    </div>--%>
<%--                                    <div class="second_picture flex-fill">--%>
<%--                                        <img src="images/profile/test6.jpeg" class="zoomable_pic">--%>
<%--                                    </div>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>

<%--                        <div class="rib_bottom d-flex flex-row">--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="commentpicbox">--%>
<%--                                    <img class="commentpic" src="images/icon/comment.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="transmitpicbox">--%>
<%--                                    <img class="transmitpic" src="images/icon/transmit.png" >--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="likepicbox">--%>
<%--                                    <img class="likepic" src="images/icon/like.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="forwardingpicbox">--%>
<%--                                    <img class="forwardingpic" src="images/icon/forwarding.png">--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

<%--            <!-- 第五个测试 -->--%>
<%--            <div class = "total-reply-item-box">--%>
<%--                <div class="parent-rib reply-item-box d-flex flex-row border-0">--%>
<%--                    <!-- <a class="direct-b" href="#test" data-toggle="collapse"></a> -->--%>
<%--                    <div class="rib-left">--%>
<%--                        <img src="./images/profile/touxiang.png" >--%>
<%--                        <div class="line-bar-dec-t d-none">--%>

<%--                        </div>--%>
<%--                        <div class="line-bar-dec-b d-none">--%>

<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="rib-text-box flex-fill">--%>
<%--                        <div class="ribtb-top">--%>
<%--                            <span><span>Mu Rui Qing🎭</span><span class="ml-1 d-inline-block">@betaSSQQ1314</span> · <span>7h</span></span>--%>
<%--                            <div class="rib-more">...</div>--%>
<%--                            <div class="suspended_card_more shadow">--%>
<%--                                <a href=""><img src="images/icon/follow.png" ><span>关注Mu Rui Qing🎭</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>--%>
<%--                                <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="ribc-tarword">--%>
<%--                            Replying to <span>@mengqidlufei</span>--%>
<%--                        </div>--%>
<%--                        <div class="rib-content">--%>
<%--									<span>The view they are facing is a beautiful one. That’s probably why it was placed there. Outside of it being the crash site, it looks as if they are walking toward a beautiful sky--%>
<%--									</span>--%>
<%--                            <div class="actual_content_picture">--%>
<%--                                <div class="content_picture_frame">--%>
<%--                                    <img class="hpiture zoomable_pic" src="images/profile/test4.jpeg" />--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                        </div>--%>

<%--                        <div class="rib_bottom d-flex flex-row">--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="commentpicbox">--%>
<%--                                    <img class="commentpic" src="images/icon/comment.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="transmitpicbox">--%>
<%--                                    <img class="transmitpic" src="images/icon/transmit.png" >--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>2.7k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="likepicbox">--%>
<%--                                    <img class="likepic" src="images/icon/like.png" >--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>

<%--                            <div class="flex-fill d-flex flex-row">--%>
<%--                                <div class="forwardingpicbox">--%>
<%--                                    <img class="forwardingpic" src="images/icon/forwarding.png">--%>
<%--                                </div>--%>
<%--                                <!-- 转发suspend 要给父元素加relative -->--%>
<%--                                <div class="suspended_card_more shadow">--%>
<%--                                    <a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--                                </div>--%>
<%--                                <div class="d-inline-block">--%>
<%--                                    <span>54.1k</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>

<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>

            <!-- -- -->
        </div>
    </div>
    <!-- <div class="trends col-3 d-none d-md-block"> -->
    <div class="trends col-3 col-lg-4 col-xl-3">
        <div class="top">
            <div class="search-box-area">
                <div class="search_box d-flex flex-row">
                    <img src="images/icon/search.png" >
                    <input id="search_input" class="" type="text" placeholder="Search WEISends"/>
                    <div class="search-text-reset">
                        <span>×</span>
                    </div>
                </div>
                <div class="search-result-box">
                    <span>Try searching for people, topics, or keywords</span>
                    <div class="search-result-items">
                        <div class="search-result-item d-flex flex-row">
                            <img src="images/icon/search-icon.png" >
                            <div class="sri-info d-flex">
                                <div class="d-flex flex-column">
                                    <span>Dil Dhadakne</span>
                                    <span>160 WEISends</span>
                                </div>
                            </div>
                        </div>
                        <div class="search-result-item d-flex flex-row">
                            <img src="images/profile/touxiang.png" >
                            <div class="sri-info d-flex">
                                <div class="d-flex flex-column">
                                    <span>Dil Dhadakne</span>
                                    <span>@DDDthefilm</span>
                                    <span>12.1K Followers</span>
                                </div>
                            </div>
                        </div>
                        <div class="search-result-item d-flex flex-row">
                            <img src="images/profile/touxiang.png" >
                            <div class="sri-info d-flex">
                                <div class="d-flex flex-column">
                                    <span>Dil Dhadakne</span>
                                    <span>@DDDthefilm</span>
                                    <span>12.1K Followers</span>
                                </div>
                            </div>
                        </div>
                        <div class="search-result-item d-flex flex-row">
                            <img src="images/profile/touxiang.png" >
                            <div class="sri-info d-flex">
                                <div class="d-flex flex-column">
                                    <span>Dil Dhadakne</span>
                                    <span>@DDDthefilm</span>
                                    <span>12.1K Followers</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <div class="content ">
            <div class="trends_content">
                <c:if test="${not empty sessionScope.user and sessionScope.wtfUsers ne null}">
                    <div class="who_to_follow explore-wtf">
						<span class="trends_box_title">
							Who to follow
						</span>
                        <c:forEach var="user" items="${sessionScope.wtfUsers}">
                            <div class="who_list_item d-flex flex-row">
                                <img class="who_list_item_pic" src="${user.profilePicUrl}" >
                                <div class="who_list_item_info">
									<span class="wlii_name">
                                            ${user.name}
                                    </span>
                                    <span class="wlii_id">
										@${user.email}
									</span>
                                </div>
                                <c:if test="${fn:contains(sessionScope.user.followingIds, user.id)}">
                                    <div class="flex-fill">
                                        <div class="wli-user-id d-none">${user.id}</div>
                                        <div class="who_list_item_follow wtf-follow-people-btn follow-people-btn-clicked"><span>Following</span></div>
                                    </div>
                                </c:if>
                                <c:if test="${!fn:contains(sessionScope.user.followingIds, user.id)}">
                                    <c:if test="${sessionScope.user.id ne user.id}">
                                        <div class="flex-fill">
                                            <div class="wli-user-id d-none">${user.id}</div>
                                            <div class="who_list_item_follow wtf-follow-people-btn"><span>Follow</span></div>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                        </c:forEach>
                        <div class=" d-flex flex-row">
                            <a class="who_list_show_more" href="###">Show more</a>
                        </div>
                    </div>
                </c:if>

                <div class="trends_foryou">
							<span class="trends_box_title">
								Trends for you
							</span>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>
                        <!-- 蒙层 -->
                        <div style="z-index: 3;" class="suspend-cover"></div>

                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>
                        <!-- 蒙层 -->
                        <div style="z-index: 3;" class="suspend-cover"></div>

                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>
                        <!-- 蒙层 -->
                        <div style="z-index: 3;" class="suspend-cover"></div>

                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>
                        <!-- 蒙层 -->
                        <div style="z-index: 3;" class="suspend-cover"></div>

                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>
                        <!-- 蒙层 -->
                        <div style="z-index: 3;" class="suspend-cover"></div>

                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class=" d-flex flex-row">
                        <a class="who_list_show_more" href="###">Show more</a>
                    </div>
                </div>

                <!-- <div class="footer_info">
                    <span>WEIWEI 2022 毕业设计个人博客系统</span>
                </div> -->
            </div>

        </div>





    </div>
    <!-- 点击放大图片 -->
    <div id="picture_enlargement_box">
        <img id="large_pic" src="" >
    </div>
    <!-- 提示框 -->
    <div class="fake-alert-box">
        <div class="alert-box">
            <span></span>
            <span class="alert-text"></span>
        </div>
    </div>
    <!-- 弹窗蒙层 -->
    <div class="suspend-cover total-suspend" style="z-index: 5;"></div>

</div>
</div>
</body>
</html>

