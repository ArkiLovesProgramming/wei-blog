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
    <link rel="stylesheet" type="text/css" href="./css/explore.css"/>
    <link rel="stylesheet" type="text/css" href="./css/search.css"/>
    <link rel="stylesheet" type="text/css" href="./css/peoplelist.css"/>

    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/all.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/navigator.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/index.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/search.js" type="text/javascript" charset="UTF-8"></script>
</head>
<body>
<%--用span来储存session的值--%>
<div class="d-none fakeSession"><span class="fs-id">${sessionScope.user.id}</span></div>
<div class="d-none fakeRequest"><span class="keyword">${requestScope.keyword}</span></div>
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
                            <img src="images/icon/touxiang.png" >
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
        <div class="fake-search-func-area"></div>
        <div class="top center_top" style="height: 99px;">
            <div class="search-box-area">
                <div class="search_box d-flex flex-row">
                    <img src="images/icon/search.png" >
                    <input id="search_input" type="text" autocomplete="off" placeholder="Search WEISends" value="${keywordShow}"/>
                    <div class="search-text-reset ml-auto">
                        <span>×</span>
                    </div>
                </div>
                <div class="search-result-box">
                    <span>Try searching for people, topics, or keywords</span>
                    <div class="search-result-items">
<%--                        <div class="search-result-item d-flex flex-row">--%>
<%--                            <img src="images/icon/search-icon.png" >--%>
<%--                            <div class="sri-info d-flex">--%>
<%--                                <div class="d-flex flex-column">--%>
<%--                                    <span>Dil Dhadakne</span>--%>
<%--                                    <span>160 WEISends</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="search-result-item d-flex flex-row">--%>
<%--                            <img src="images/profile/touxiang.png" >--%>
<%--                            <div class="sri-info d-flex">--%>
<%--                                <div class="d-flex flex-column">--%>
<%--                                    <span>Dil Dhadakne</span>--%>
<%--                                    <span>@DDDthefilm</span>--%>
<%--                                    <span>12.1K Followers</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
                    </div>
                </div>
            </div>

            <div class="search-func-area d-flex flex-row">
                <div class="sfa-item flex-grow-1">
                    <c:if test="${requestScope.type eq 'Top'}">
                        <span class="si-selected">Top</span>
                    </c:if>
                    <c:if test="${requestScope.type ne 'Top'}">
                        <span>Top</span>
                    </c:if>
                </div>
                <div class="sfa-item flex-grow-1">
                    <c:if test="${requestScope.type eq 'Latest'}">
                        <span class="si-selected">Latest</span>
                    </c:if>
                    <c:if test="${requestScope.type ne 'Latest'}">
                        <span>Latest</span>
                    </c:if>
                </div>
                <div class="sfa-item flex-grow-1">
                    <c:if test="${requestScope.type eq 'People'}">
                        <span class="si-selected">People</span>
                    </c:if>
                    <c:if test="${requestScope.type ne 'People'}">
                        <span>People</span>
                    </c:if>
                </div>
                <div class="sfa-item flex-grow-1">
                    <c:if test="${requestScope.type eq 'Photos'}">
                        <span class="si-selected">Photos</span>
                    </c:if>
                    <c:if test="${requestScope.type ne 'Photos'}">
                        <span>Photos</span>
                    </c:if>
                </div>
                <div class="sfa-item flex-grow-1">
                    <c:if test="${requestScope.type eq 'Videos'}">
                        <span class="si-selected">Videos</span>
                    </c:if>
                    <c:if test="${requestScope.type ne 'Videos'}">
                        <span>Videos</span>
                    </c:if>
                </div>
            </div>

        </div>


        <div class="content">

            <c:if test="${requestScope.type eq 'Top'}">
                <c:if test="${fn:length(requestScope.schResultTopics) > 0}">
                    <div class="related-topic-box-area">
                        <div class="related-topic-box">
                            <div class="rtb-top d-flex flex-row">
                                <div class="rtb-top-img-box">
                                    <img src="images/icon/topic.png" >
                                </div>
                                <div class="rtb-top-title">
                                    <span>Related Topic</span>
                                </div>
                            </div>
                            <div class="rtb-bottom">
                                <span>See top Tweets about these</span>
                            </div>
                        </div>
                        <c:forEach var="topic" items="${requestScope.schResultTopics}">
                            <a href="<%=basePath%>Topic/detailTopic/${topic.id}" class="related-topic-show d-flex flex-row">
                                <div class="d-none schTopic-id">${topic.id}</div>
                                <div class="rts-info">
                                    <div>
                                        <span>${topic.name}</span>
                                    </div>
                                    <div>
                                        <span>All about ${topic.name}</span>
                                        <span class="d-none">Brand</span>
                                    </div>
                                </div>
                                <div class="follow-topic-btn ml-auto" onClick="event.preventDefault()">
                                    <span>Follow</span>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${fn:length(requestScope.schPeopleList)>0}">
                    <div class="content-title" >
                        <span>People</span>
                    </div>
                    <c:forEach var="user" items="${requestScope.schPeopleList}">
                        <div class="peopleListItem d-flex flex-row">
                            <span class="d-none pli-user-id">${user.id}</span>
                            <div class="pli-pic">
                                <img src="${user.profilePicUrl}" >
                            </div>
                            <div class="pli-info-detail">
                                <div class="pli-info-box d-flex flex-row">
                                    <div class="pli-info">
                                        <span>${user.name}</span>
                                        <span>@${user.email}</span>
                                    </div>
                                    <c:if test="${fn:contains(sessionScope.user.followingIds, user.id)}">
                                        <div class="pif-follow ml-auto follow-people-btn follow-people-btn-clicked">
                                            <span>Following</span>
                                        </div>
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.followingIds, user.id)}">
                                        <c:if test="${sessionScope.user.id ne user.id}">
                                            <div class="pif-follow ml-auto follow-people-btn">
                                                <span>Follow</span>
                                            </div>
                                        </c:if>
                                    </c:if>
                                </div>
                                <div class="hisSignature">
                                <span>
                                    <c:if test="${not empty user.signature}">
                                        ${user.signature}
                                    </c:if>
                                    <c:if test="${empty user.signature}">
                                        Nothing to see here yet
                                    </c:if>
                                </span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <div class="search-people-bottom">
                        <spann>View all</spann>
                    </div>
                </c:if>
                <c:forEach var="thiscontent" items="${requestScope.schTopContents}">
                    <div class="content_card_total">
                            <%--content的id--%>
                        <div class="content-card-id d-none">${thiscontent.id}</div>
                        <div class="content_card d-flex flex-row">
                            <div class="content_profile_picture_box position-relative">
                                <a href="#">
                                    <img class="content_profile_picture" src="${requestScope.schConIdMapUser[thiscontent.id].profilePicUrl}">
                                </a>
                                <div class="suspended_profile">
                                </div>
                            </div>
                            <div class="content_card_info_box">
                                <div class="content_card_info">
                            <span><span>${requestScope.schConIdMapUser[thiscontent.id].name}</span><span class="ml-1 d-inline-block">@${requestScope.schConIdMapUser[thiscontent.id].email}</span> · <span>
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
                                <c:if test="${thiscontent.parentId ne '0'}">
                                    <div class="ribc-tarword">
                                        Replying to <span>@${requestScope.schConIdMapUser[thiscontent.parentId].name}</span>
                                    </div>
                                </c:if>
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
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <img class="likepic" src="images/icon/liked.png" >
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <img class="likepic" src="images/icon/like.png" >
                                    </c:if>
                                </div>
                                    <%--                                测试：${sessionScope.user.likedContentIds} thisContentId:${thisContentId}--%>
                                <div class="d-inline-block">
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <span style="color: rgb(229, 58, 127)">${thiscontent.likeNum}</span>
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
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
                <c:if test="${requestScope.schTopContents.size()==0}">
                    <div class="null-alert">
                        <span>Noting to see here! there is not any contents about this topic yet</span>
                    </div>
                </c:if>
            </c:if>
            <c:if test="${requestScope.type eq 'Latest'}">
                <c:forEach var="thiscontent" items="${requestScope.schTopContents}">
                    <div class="content_card_total">
                            <%--content的id--%>
                        <div class="content-card-id d-none">${thiscontent.id}</div>
                        <div class="content_card d-flex flex-row">
                            <div class="content_profile_picture_box position-relative">
                                <a href="#">
                                    <img class="content_profile_picture" src="${requestScope.schConIdMapUser[thiscontent.id].profilePicUrl}">
                                </a>
                                <div class="suspended_profile">
                                </div>
                            </div>
                            <div class="content_card_info_box">
                                <div class="content_card_info">
                            <span><span>${requestScope.schConIdMapUser[thiscontent.id].name}</span><span class="ml-1 d-inline-block">@${requestScope.schConIdMapUser[thiscontent.id].email}</span> · <span>
                                <jsp:useBean id="now1" class="java.util.Date" />
                                <fmt:parseDate value="${thiscontent.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                <c:set var="intervalf" value="${now1.time - rtf.time}"/>
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
                                        <a href=""><img src="images/icon/follow.png" ><span>关注${requestScope.detailUser.name}</span></a>
                                        <a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>
                                        <a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>
                                    </div>
                                </div>
                                <c:if test="${thiscontent.parentId ne '0'}">
                                    <div class="ribc-tarword">
                                        Replying to <span>@${requestScope.schConIdMapUser[thiscontent.parentId].name}</span>
                                    </div>
                                </c:if>
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
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <img class="likepic" src="images/icon/liked.png" >
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <img class="likepic" src="images/icon/like.png" >
                                    </c:if>
                                </div>
                                    <%--                                测试：${sessionScope.user.likedContentIds} thisContentId:${thisContentId}--%>
                                <div class="d-inline-block">
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <span style="color: rgb(229, 58, 127)">${thiscontent.likeNum}</span>
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
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
                <c:if test="${requestScope.schTopContents.size()==0}">
                    <div class="null-alert">
                        <span>Noting to see here! there is not any contents about this topic yet</span>
                    </div>
                </c:if>            </c:if>
            <c:if test="${requestScope.type eq 'People'}">
                <c:forEach var="user" items="${requestScope.schPeopleList}">
                    <div class="peopleListItem d-flex flex-row">
                        <span class="d-none pli-user-id">${user.id}</span>
                        <div class="pli-pic">
                            <img src="${user.profilePicUrl}" >
                        </div>
                        <div class="pli-info-detail">
                            <div class="pli-info-box d-flex flex-row">
                                <div class="pli-info">
                                    <span>${user.name}</span>
                                    <span>@${user.email}</span>
                                </div>
                                <c:if test="${fn:contains(sessionScope.user.followingIds, user.id)}">
                                    <div class="pif-follow ml-auto follow-people-btn follow-people-btn-clicked">
                                        <span>Following</span>
                                    </div>
                                </c:if>
                                <c:if test="${!fn:contains(sessionScope.user.followingIds, user.id)}">
                                    <c:if test="${sessionScope.user.id ne user.id}">
                                        <div class="pif-follow ml-auto follow-people-btn">
                                            <span>Follow</span>
                                        </div>
                                    </c:if>
                                </c:if>
                            </div>
                            <div class="hisSignature">
                                <span>
                                    <c:if test="${not empty user.signature}">
                                        ${user.signature}
                                    </c:if>
                                    <c:if test="${empty user.signature}">
                                        Nothing to see here yet
                                    </c:if>
                                </span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${fn:length(requestScope.schPeopleList)<5}">
                    <div class="null-alert">
                        <span>unfortunately,there are only so many users that match your search results.</span>
                    </div>
                </c:if>
            </c:if>
            <c:if test="${requestScope.type eq 'Photos' or requestScope.type eq 'Videos'}">
                <c:forEach var="thiscontent" items="${requestScope.schPhotoContents}">
                    <div class="content_card_total">
                            <%--content的id--%>
                        <div class="content-card-id d-none">${thiscontent.id}</div>
                        <div class="content_card d-flex flex-row">
                            <div class="content_profile_picture_box position-relative">
                                <a href="#">
                                    <img class="content_profile_picture" src="${requestScope.schConIdMapUser[thiscontent.id].profilePicUrl}">
                                </a>
                                <div class="suspended_profile">
                                </div>
                            </div>
                            <div class="content_card_info_box">
                                <div class="content_card_info">
                            <span><span>${requestScope.schConIdMapUser[thiscontent.id].name}</span><span class="ml-1 d-inline-block">@${requestScope.schConIdMapUser[thiscontent.id].email}</span> · <span>
                                <jsp:useBean id="now2" class="java.util.Date" />
                                <fmt:parseDate value="${thiscontent.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
                                <c:set var="intervalf" value="${now2.time - rtf.time}"/>
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
                                <c:if test="${thiscontent.parentId ne '0'}">
                                    <div class="ribc-tarword">
                                        Replying to <span>@${requestScope.schConIdMapUser[thiscontent.parentId].name}</span>
                                    </div>
                                </c:if>
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
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <img class="likepic" src="images/icon/liked.png" >
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <img class="likepic" src="images/icon/like.png" >
                                    </c:if>
                                </div>
                                    <%--                                测试：${sessionScope.user.likedContentIds} thisContentId:${thisContentId}--%>
                                <div class="d-inline-block">
                                    <c:if test="${fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
                                        <span style="color: rgb(229, 58, 127)">${thiscontent.likeNum}</span>
                                    </c:if>
                                    <c:if test="${!fn:contains(sessionScope.user.likedContentIds,thiscontent.id)}">
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
                <c:if test="${requestScope.schPhotoContents.size()==0}">
                    <div class="null-alert">
                        <span>Noting to see here! there is not any contents about this topic yet</span>
                    </div>
                </c:if>
            </c:if>
        </div>
    </div>
    <!-- <div class="trends col-3 d-none d-md-block"> -->
    <div class="trends col-3 col-lg-4 col-xl-3">
        <!-- <div class="top">

        </div> -->
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
        <img id="large_pic" src="" >
    </div>
    <!-- 弹窗蒙层 -->
    <div class="suspend-cover total-suspend" style="z-index: 5;"></div>

</div>
</div>
</body>
</html>
