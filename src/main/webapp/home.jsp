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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
    <meta charset="utf-8">
    <title>WEI Blog</title>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="css/all.css" />
    <link rel="stylesheet" type="text/css" href="css/navigator.css" />
    <link rel="stylesheet" type="text/css" href="./css/window.css" />
    <link rel="stylesheet" type="text/css" href="./css/index.css"/>
    <link rel="stylesheet" type="text/css" href="./css/home.css"/>
    <link rel="stylesheet" type="text/css" href="css/topics.css"/>

    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/all.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/navigator.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/index.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/content.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/categories.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/home.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/sendContent.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/contentMana.js" type="text/javascript" charset="UTF-8"></script>
</head>
<body>
<%--用span来储存session的值--%>
<div class="d-none fakeSession"><span class="fs-id">${sessionScope.user.id}</span></div>
<%--<div class="d-none fakeSession"><span class="fs-id">68817854</span></div>--%>
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
    <div class="window col-10 col-lg-9">
        <div class="top"></div>
        <div class="top center_top">
            <div class="ct-title">
                <span>Home</span>
            </div>
        </div>
        <div class="content">
            <div class="sendContentBox d-flex flex-row position-relative">
<%--                发送的时候要贴蒙层--%>
                <div class="scb-cover"></div>
                <div class="scb-image-box">
                    <div>
                        <img src="${sessionScope.user.profilePicUrl}" >
                    </div>
                </div>
                <div class="scb-main-box">
                    <div class="send-input_box">
                        <div id="div-editable" class="send-input"c contenteditable="true" ><div class="d-flex flex-column" ><span></span></div></div>
                    </div>
                    <!-- 图片框架 -->
                    <div class="pff send-pic-box d-none">
                        <div class="aid-picture-position position-relative">
                            <div class="cancel-upload-file">
                                ×
                            </div>
                            <img class="single-ul-pic" src="images/profile/hp.png" >
                        </div>
                    </div>

                    <div class="pfs send-pic-box d-none">
                        <div class="double-reply-pic flex-row d-flex aspectration" data-ratio="16:9">
                            <div class="d-flex flex-row">
                                <div class="drp-item">
                                    <div class="cancel-upload-file">
                                        ×
                                    </div>
                                    <img class="double-ul-picf" src="images/profile/bg.png" >
                                </div>

                                <div class="drp-item"style="margin-left: 12px;">
                                    <div class="cancel-upload-file">
                                        ×
                                    </div>
                                    <img class="double-ul-pics" src="images/profile/bg.png" >
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 图片框架 -->

                    <!-- 视频框架 -->
                    <div class="send-video-box d-none">
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

                    <!-- 显示已选择的类别 -->
                    <div class="selected-cat-box flex-row">
<%--                        <div class="scb-item">--%>
<%--                            <span>Career</span>--%>
<%--                            <span class="scb-id d-none">123</span>--%>
<%--                        </div>--%>
<%--                        <div class="scb-item">--%>
<%--                            <span>Career</span>--%>
<%--                            <span class="cat-item-id d-none">456</span>
<%--                        </div>--%>
                    </div>

                    <div class="Whocansee-box">
                        <div class="wcs-border">
                            <img src="images/icon/earth.png" >
                            <span>Everyone can reply</span>
                        </div>
                    </div>
                    <div class="send-box-bottom d-flex flex-row">
                        <div class="send-box-func d-flex flex-row">
                            <div class="sbf-item send-image-func  sbfi-hover">
                                <div class="sbf-item-cover" onclick="event.cancelBubble = true"></div>
                                <img src="images/icon/image.png" >
                            </div>
                            <div class="sbf-item open-stick-select  sbfi-hover">
                                <img src="images/icon/stick.png" >

                                <!-- 表情列表-->
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
                                <!-- 表情列表-->

                            </div>

                            <div class="sbf-item openCagetory sbfi-hover">
                                <img src="images/icon/category.png" >
                                <!-- 类别box -->
                                <div class="categoryBox">
                                    <div class="categoryBox-title">
                                        <div class="triangle-icon"></div>
                                        <div class="triangle-icon triangle-icon2"></div>
                                        <span>Categories</span>
                                    </div>
                                    <div class="cb-parentCategory d-flex flex-row">
                                        <!-- <div class="cpc-item">
                                            <span>Business</span>
                                            <span class="cat-item-id d-none">456</span>
                                        </div>  -->

                                    </div>
                                    <div class="categoryBox-title">
                                        <span>Child categories</span>
                                    </div>
                                    <div class="cb-childCategory d-flex flex-row">
                                        <!-- <div class="cbc-item">
                                            <span>Career</span>
                                            <span class="di">+</span>
                                            <img src="images/icon/add.png" >
                                            <span class="cat-item-id d-none">456</span>
                                        </div> -->
                                    </div>
                                    <div class="categoryBox-title">
                                        <span>Selected categories</span>
                                    </div>
                                    <div class="selected-cat d-flex flex-row">
                                        <!-- <div class="cbc-item selected-cat-item">
                                            <span>Career</span>
                                            <span class="di">+</span>
                                            <img src="images/icon/right.png" >
                                        </div> -->
                                    </div>
                                </div>
                            </div>

                            <div class="sbf-item send-video-func sbfi-hover">
                                <div class="sbf-item-cover" onclick="event.cancelBubble = true"></div>
                                <img src="images/icon/video.png" >
                            </div>
                        </div>
                        <div class="scb-submit-border">
                            <span>WEISend</span>
                        </div>
                        <form id="rbb-form" enctype="multipart/form-data" method="post">
                            <input type="file" name="firstFile" id="rbb-file" accept="image/*" class="d-none"/>
                            <input type="file" name="secondFile" id="rbb-file-second" accept="image/*" class="d-none"/>
                            <input type="file" name="video" id="rbb-video" accept="video/*" class="d-none" />
<%--                            <input type="submit" id="rbb-submit" class="d-none"/>--%>
                        </form>
                    </div>
                </div>
            </div>

            <div class="content-title" >
                <img src="images/icon/topic.png" >
                <span>What’s happening</span>
            </div>

            <div class="content-area">
                <c:forEach var="thiscontent" items="${sessionScope.homeContents}">
                    <div class="content_card_total">
<%--                        content的id--%>
                        <div class="content-card-id d-none">${thiscontent.id}</div>
                        <!-- <div class="whether-forward-box">
                            <img src="./images/icon/transmited.png" >
                            <span><span>小惡魔AnnaImp</span>Retweeted</span>
                        </div> -->
                        <div class="content_card d-flex flex-row">
                            <c:set var="thisContentId" value="${thiscontent.id}"/>
                            <div class="content_profile_picture_box position-relative">
                                <a href="<%=basePath%>User/detailUser/${sessionScope.conIdMapUser[thisContentId].id}">
                                    <img class="content_profile_picture" src="${sessionScope.conIdMapUser[thisContentId].profilePicUrl}">
                                </a>
                                <div class="suspended_profile d-none">

                                </div>
                            </div>
                            <div class="content_card_info_box">
                                <div class="content_card_info">
                                    <span><span>${sessionScope.conIdMapUser[thisContentId].name}</span><span class="ml-1 d-inline-block">${sessionScope.conIdMapUser[thisContentId].email}</span> ·<span>
                                            <jsp:useBean id="now" class="java.util.Date" />
                                            <fmt:parseDate value="${thiscontent.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                            <c:set var="intervalf" value="${now.time - rtf.time}"/>
                                            <fmt:formatNumber var="minute" value="${intervalf/1000/60}" pattern="#0"/>
                                            <fmt:formatNumber var="hour" value="${minute/60}" pattern="#0"/>
                                            <fmt:formatDate var="week"  value="${rtf}" pattern="E" />
                                            <fmt:formatDate var="tdate" value="${rtf}" pattern="MMM d" />
                                            <c:if test="${minute < 60}">${minute}m</c:if>
                                            <c:if test="${minute >= 60 && (minute/60) < 24}">${hour}h</c:if>
                                            <c:if test="${(minute/60) >= 24 && (minute/60/24) < 7}">${week}</c:if>
                                            <c:if test="${(minute/60/24) >= 7}">${tdate}</c:if>
                                        </span></span>
                                    <div class="content_card_more">...</div>
                                    <div class="suspended_card_more shadow">
                                        <a class="disabled" href=""><img src="images/icon/follow.png" ><span>关注${requestScope.detailUser.name}</span></a>
                                        <a class="disabled" href=""><img src="images/icon/report.png" ><span>删除内容</span></a>
                                        <a class="disabled" href=""><img src="images/icon/report.png" ><span>举报内容</span></a>
                                    </div>
                                </div>
                                <div class="actual_content">
                                    <div class="text_content">
                                        ${thiscontent.textContent}
                                    </div>
<%--                                    <img src="${pictureURLs[0]}" class="zoomable_pic" >--%>
<%--                                    <img src="${pictureURLs[1]}" class="zoomable_pic">--%>
                                    <c:if test="${thiscontent.pictureURL ne '0'}">
                                        <c:if test="${fn:contains(thiscontent.pictureURL,',')}" >
                                            <c:set value="${ fn:split(thiscontent.pictureURL, ',') }" var="pictureURLs" />
                                            <div class="actual_content_picture">
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
                                            </div>
                                        </c:if>
                                        <c:if test="${!fn:contains(thiscontent.pictureURL,',')}" >
                                            <div class="actual_content_picture">
                                                <div class="content_picture_frame">
                                                    <img class="hpicture zoomable_pic" src="${thiscontent.pictureURL}" />
                                                </div>
                                            </div>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${thiscontent.videoURL ne '0'}">
                                        <div class="actual_content_picture">
                                            <div class="content_video_frame">
                                                <video style="max-width: 100%;" controls autoplay muted loop>
                                                    <source src="${thiscontent.videoURL}" type="video/mp4"></source>
                                                </video>
                                            </div>
                                        </div>
                                    </c:if>

                                </div>
                            </div>
                        </div>

                        <div class="content_card_bottom d-flex flex-row">
                            <div class="flex-fill d-flex flex-row">
                                <div class="commentpicbox">
                                    <img class="commentpic" src="images/icon/comment.png" >
                                </div>
                                <div class="d-inline-block">
                                    <span>${thiscontent.commentNum}</span>
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
                                    <span>${thiscontent.transmitNum}</span>
                                </div>
                            </div>

                            <div class="flex-fill d-flex flex-row">
                                <div class="likepicbox">
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thisContentId)}">
                                        <img class="likepic" src="images/icon/liked.png" >
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thisContentId)}">
                                        <img class="likepic" src="images/icon/like.png" >
                                    </c:if>
                                </div>
<%--                                测试：${sessionScope.user.likedContentIds} thisContentId:${thisContentId}--%>
                                <div class="d-inline-block">
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thisContentId)}">
                                        <span style="color: rgb(229, 58, 127)">${thiscontent.likeNum}</span>
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thisContentId)}">
                                        <span>${thiscontent.likeNum}</span>
                                    </c:if>
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
                                    <span>${thiscontent.bookmarkNum}</span>
                                </div>
                            </div>

                        </div>

                    </div>
                </c:forEach>
            </div>


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
                                <img class="who_list_item_pic" src="${user.profilePicUrl}" data-user-id="${user.id}">
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
                            <a class="who_list_show_more disabled" href="###">Show more</a>
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
                            <a href="###" class="disabled"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>

                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###" class="disabled"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>


                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###" class="disabled"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>


                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###" class="disabled"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>


                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class="trends_foryou_item">
                        <div class="trends_foryou_item_more">
                            ...
                        </div>
                        <div class="suspended_card_more shadow">
                            <a href="###" class="disabled"><img src="images/icon/cryface.png" /><span>Not interested in this</span></a>
                        </div>


                        <span class="foryou_item_cat">Olympics·Trending</span>
                        <span class="foryou_item_smcat">Beijing</span>
                        <span class="foryou_num">29.2k WEISends</span>
                    </div>
                    <div class=" d-flex flex-row">
                        <a class="who_list_show_more disabled" href="###">Show more</a>
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
        <img id="large_pic" src="" onclick="event.cancelBubble = true">
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


