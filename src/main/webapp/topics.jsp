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
    <link rel="stylesheet" type="text/css" href="css/navigator.css" />
    <link rel="stylesheet" type="text/css" href="./css/window.css" />
    <link rel="stylesheet" type="text/css" href="./css/index.css"/>
    <link rel="stylesheet" type="text/css" href="./css/home.css"/>
    <link rel="stylesheet" type="text/css" href="./css/topics.css"/>

    <script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/all.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/navigator.js" type="text/javascript" charset="utf-8"></script>
    <script src="js/myjs/index.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/content.js" type="text/javascript" charset="UTF-8"></script>
    <script src="js/myjs/topics.js" type="text/javascript" charset="UTF-8"></script>
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
        <div class="top center_top">
            <div class="ct-title">
                <span>All Topics</span>
            </div>
        </div>
        <div class="content">
            <div class="categories-box">
                <div class="cb-title">
                    <span>Categories</span>
                </div>
                <div class="allcategories">
                    <div class="row">
                        <!-- <div class="categories-item-box col-6 col-sm-4">
                            <div class="categories-item">
                                <span>Fashion & beauty</span>
                            </div>
                        </div> -->
                    </div>
                    <div class="ac-show-more">
                        <span>Show more</span>
                    </div>
                </div>
            </div>
            
            <div class="detailcategories">
                <div class="dc-title">
                    <span>For you</span>
                </div>
                <div class="detailcategorie-row d-flex flex-row">
                    <c:forEach var="topic" items="${requestScope.foryouTopics}" varStatus="topicStatus">
                        <c:if test="${topicStatus.index % 3 == 0}">
                            <div class="detailcategorie-column d-flex flex-column">
                        </c:if>
                        <c:if test="${fn:contains(sessionScope.user.topicIds, topic.id)}">
                            <div class="detailcategorie-item" style="background-color: #499bea;border-color: #499bea;color: white">
                                <span>${topic.name}</span>
                                <span class="di">+</span>
                                <img src="images/icon/right.png" >
                                <span class="d-none dci-id">${topic.id}</span>
                            </div>
                        </c:if>
                        <c:if test="${!fn:contains(sessionScope.user.topicIds, topic.id)}">
                            <div class="detailcategorie-item">
                                <span>${topic.name}</span>
                                <span class="di">+</span>
                                <img src="images/icon/add.png" >
                                <span class="d-none dci-id">${topic.id}</span>
                            </div>
                        </c:if>
                        <c:if test="${(topicStatus.index+1) % 3 == 0 or topicStatus.last }">
                        </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>

            <c:forEach var="topics" items="${requestScope.topicsList}" varStatus="topicsStatus">
                <div class="detailcategories">
                    <div class="dc-title">
                        <span>${requestScope.topicsParentList[topicsStatus.index].name}</span>
                    </div>
                    <div class="detailcategorie-row d-flex flex-row">
                        <c:forEach var="topic" items="${topics}" varStatus="topicStatus">
                            <c:if test="${topicStatus.index % 3 == 0}">
                                <div class="detailcategorie-column d-flex flex-column">
                            </c:if>
                            <c:if test="${fn:contains(sessionScope.user.topicIds, topic.id)}">
                                <div class="detailcategorie-item" style="background-color: #499bea;border-color: #499bea;color: white">
                                    <span>${topic.name}</span>
                                    <span class="di">+</span>
                                    <img src="images/icon/right.png" >
                                    <span class="d-none dci-id">${topic.id}</span>
                                </div>
                            </c:if>
                            <c:if test="${!fn:contains(sessionScope.user.topicIds, topic.id)}">
                                <div class="detailcategorie-item">
                                    <span>${topic.name}</span>
                                    <span class="di">+</span>
                                    <img src="images/icon/add.png" >
                                    <span class="d-none dci-id">${topic.id}</span>
                                </div>
                            </c:if>
                            <c:if test="${(topicStatus.index+1) % 3 == 0 or topicStatus.last }">
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
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

