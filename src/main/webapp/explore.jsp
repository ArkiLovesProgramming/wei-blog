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
	<script src="./js/jquery-3.5.1.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/bootstrap.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/myjs/all.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/myjs/navigator.js" type="text/javascript" charset="utf-8"></script>
	<script src="js/myjs/index.js" type="text/javascript" charset="UTF-8"></script>
	<script src="js/myjs/lr.js" type="text/javascript" charset="UTF-8"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			if ($(".login-box").is(':visible')) {
				$(".login-email").click();
			} else {
				$(".register-name").click();
			}

		});
	</script>
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
			<div class="search-box-area">
				<div class="search_box d-flex flex-row">
					<img src="images/icon/search.png" >
					<input id="search_input" class="" type="text" autocomplete="off" placeholder="Search WEISends"/>
					<div class="search-text-reset ml-auto">
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
<%--						<div class="search-result-item d-flex flex-row">--%>
<%--							<img src="images/profile/touxiang.png" >--%>
<%--							<div class="sri-info d-flex">--%>
<%--								<div class="d-flex flex-column">--%>
<%--									<span>Dil Dhadakne</span>--%>
<%--									<span>@DDDthefilm</span>--%>
<%--									<span>12.1K Followers</span>--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
					</div>
				</div>
			</div>

		</div>
		<div class="content">
			<div class="explore-trends position-relative">
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

					<span class="foryou_item_cat">Olympics·Trending</span>
					<span class="foryou_item_smcat">Beijing</span>
					<span class="foryou_num">29.2k WEISends</span>
				</div>
				<div class=" d-flex flex-row">
					<a class="who_list_show_more disabled" href="###">Show more</a>
				</div>
			</div>

			<c:if test="${not empty requestScope.expTopics}">
				<c:forEach var="topic" items="${requestScope.expTopics}">
					<div class="content-title" >
						<img src="images/icon/topic.png" >
						<span>${topic.name}</span>
					</div>
					<c:forEach var="content" items="${requestScope.expTopicIdMapCons[topic.id]}">
						<div class="content_card_total">
								<%-- content的id--%>
							<div class="content-card-id d-none">${content.id}</div>
							<div class="content_card d-flex flex-row">
								<div class="content_profile_picture_box position-relative">
									<img class="content_profile_picture" src="${requestScope.expConIdMapUser[content.id].profilePicUrl}">
									<div class="suspended_profile">
									</div>
								</div>
								<div class="content_card_info_box">
									<div class="content_card_info">
									<span><span>${requestScope.expConIdMapUser[content.id].name}</span><span class="ml-1 d-inline-block">@${requestScope.expConIdMapUser[content.id].email}</span> · <span>
										<jsp:useBean id="now" class="java.util.Date" />
										<fmt:parseDate value="${content.releasingTime}" var="rtf" pattern="yyyy/MM/dd HH/mm" />
										<c:set var="intervalf" value="${now.time - rtf.time}"/>
										<fmt:formatNumber var="minute" value="${intervalf/1000/60}" pattern="#0"/>
										<fmt:formatNumber var="hour" value="${minute/60}" pattern="#0"/>
										<fmt:formatDate var="week"  value="${rtf}" pattern="E" />
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
												${content.textContent}
										</div>
										<c:if test="${content.pictureURL ne '0'}">
											<c:if test="${fn:contains(content.pictureURL,',')}" >
												<c:set value="${ fn:split(content.pictureURL, ',') }" var="pictureURLs" />
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
											<c:if test="${!fn:contains(content.pictureURL,',')}" >
												<div class="actual_content_picture">
													<div class="content_picture_frame">
														<img class="hpicture zoomable_pic" src="${content.pictureURL}" />
													</div>
												</div>
											</c:if>
										</c:if>
										<c:if test="${content.videoURL ne '0'}">
											<div class="actual_content_picture">
												<div class="content_video_frame">
													<video style="max-width: 100%;" controls autoplay muted loop>
														<source src="${content.videoURL}" type="video/mp4"></source>
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
										<span>${content.commentNum}</span>
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
										<span>${content.transmitNum}</span>
									</div>
								</div>

								<div class="flex-fill d-flex flex-row">
									<div class="likepicbox">
										<c:if test="${fn:contains(sessionScope.user.likedContentIds,content.id)}">
											<img class="likepic" src="images/icon/liked.png" >
										</c:if>
										<c:if test="${!fn:contains(sessionScope.user.likedContentIds,content.id)}">
											<img class="likepic" src="images/icon/like.png" >
										</c:if>
									</div>
										<%--                                测试：${sessionScope.user.likedContentIds} thisContentId:${thisContentId}--%>
									<div class="d-inline-block">
										<c:if test="${fn:contains(sessionScope.user.likedContentIds,content.id)}">
											<span style="color: rgb(229, 58, 127)">${content.likeNum}</span>
										</c:if>
										<c:if test="${!fn:contains(sessionScope.user.likedContentIds,content.id)}">
											<span>${content.likeNum}</span>
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
										<span>${content.bookmarkNum}</span>
									</div>
								</div>

							</div>
						</div>
					</c:forEach>
					<div class="content-topic-show d-flex flex-row">
						<div class="d-none cts-id"><span>${topic.id}</span></div>
						<div class="topic-a-box">
							<img src="images/icon/topic-a.png" >
						</div>
						<div class="cts-content">
							<div class="cts-title">${topic.name}</div>
							<div cl ass="cts-detail">All about ${topic.name}</div>
						</div>
						<c:if test="${fn:contains(sessionScope.user.topicIds, topic.id)}">
							<div class="cts-follow-btn cts-follow-btn-clicked ml-auto"><span>Following</span></div>
						</c:if>
						<c:if test="${!fn:contains(sessionScope.user.topicIds, topic.id)}">
							<div class="cts-follow-btn ml-auto"><span>Follow</span></div>
						</c:if>
					</div>
				</c:forEach>

			</c:if>

<%--			<div class="content_card_total">--%>
<%--				<div class="content_card d-flex flex-row">--%>
<%--					<div class="content_profile_picture_box position-relative">--%>
<%--						<img class="content_profile_picture" src="./images/profile/touxiang.png">--%>
<%--						<div class="suspended_profile">--%>
<%--						</div>--%>
<%--					</div>--%>
<%--					<div class="content_card_info_box">--%>
<%--						<div class="content_card_info">--%>
<%--							<span><span>Mu Rui Qing🎭</span><span class="ml-1 d-inline-block">@betaSSQQ1314</span> · <span>7h</span></span>--%>
<%--							<div class="content_card_more">...</div>--%>
<%--							<div class="suspended_card_more shadow">--%>
<%--								<a href=""><img src="images/icon/follow.png" ><span>关注Mu Rui Qing🎭</span></a>--%>
<%--								<a href=""><img src="images/icon/report.png" ><span>删除内容</span></a>--%>
<%--								<a href=""><img src="images/icon/report.png" ><span>举报内容</span></a>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--						<div class="actual_content">--%>
<%--							<div class="text_content">--%>
<%--								哇，贝塔塔也太帅了吧，不可思议呀！！！！👿<br><br><br>--%>


<%--								Wow, Betta is too handsome, incredible ！！！！--%>
<%--							</div>--%>
<%--							<div class="actual_content_picture">--%>
<%--								<div class="content_picture_frame">--%>
<%--									<img class="hpicture zoomable_pic" src="images/profile/test4.jpeg" />--%>
<%--								</div>--%>
<%--							</div>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--				</div>--%>
<%--				<div class="content_card_bottom d-flex flex-row">--%>
<%--					<div class="flex-fill d-flex flex-row">--%>
<%--						<div class="commentpicbox">--%>
<%--							<img class="commentpic" src="images/icon/comment.png" >--%>
<%--						</div>--%>
<%--						<div class="d-inline-block">--%>
<%--							<span>2.7k</span>--%>
<%--						</div>--%>
<%--					</div>--%>
<%--					<div class="flex-fill d-flex flex-row">--%>
<%--						<div class="transmitpicbox">--%>
<%--							<img class="transmitpic" src="images/icon/transmit.png" >--%>
<%--						</div>--%>
<%--						<!-- 转发suspend 要给父元素加relative -->--%>
<%--						<div class="suspended_card_more shadow">--%>
<%--							<a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--						</div>--%>
<%--						<div class="d-inline-block">--%>
<%--							<span>2.7k</span>--%>
<%--						</div>--%>
<%--					</div>--%>

<%--					<div class="flex-fill d-flex flex-row">--%>
<%--						<div class="likepicbox">--%>
<%--							<img class="likepic" src="images/icon/like.png" >--%>
<%--						</div>--%>
<%--						<div class="d-inline-block">--%>
<%--							<span>54.1k</span>--%>
<%--						</div>--%>
<%--					</div>--%>

<%--					<div class="flex-fill d-flex flex-row">--%>
<%--						<div class="forwardingpicbox">--%>
<%--							<img class="forwardingpic" src="images/icon/forwarding.png">--%>
<%--						</div>--%>
<%--						<!-- 转发suspend 要给父元素加relative -->--%>
<%--						<div class="suspended_card_more shadow">--%>
<%--							<a href=""><img src="images/icon/transmit.png" ><span>ReWEISend</span></a>--%>
<%--						</div>--%>
<%--						<div class="d-inline-block">--%>
<%--							<span>54.1k</span>--%>
<%--						</div>--%>
<%--					</div>--%>

<%--				</div>--%>
<%--			</div>--%>


		</div>
	</div>
	<!-- <div class="trends col-3 d-none d-md-block"> -->
	<div class="trends col-3 col-lg-4 col-xl-3">
		<!-- <div class="top">

        </div> -->
		<div class="content ">

			<div class="trends_content" style="position: fixed;">
				<c:if test="${empty sessionScope.user}">
					<div class="register-login-box">
						<div class="register-box">
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

						<div class="login-box" style="display: none;">
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
									<span>Login successfully!</span>
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

					</div>
				</c:if>

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
	<div class="fake-alert-box">
		<div class="alert-box">
			<span></span>
			<span class="alert-text"></span>
		</div>
	</div>
	<!-- 弹窗蒙层 -->
	<div class="suspend-cover total-suspend" style="z-index: 5;"></div>

	<!-- /* 探索页面未登录时候下面的登录提醒 */ -->
	<c:if test="${empty sessionScope.user}">
		<div class="bottomLoginAlert d-flex flex-row">
			<div class="bla-info flex-fill">
				<span>Share your thoughts</span>
				<span>People on the WEIBlog feel more connected.</span>
				<!-- <span>分享你的看法</span>
                <span>WEIBlog上的人们感到更加紧密。</span> -->
			</div>
			<div class="bla-func d-flex flex-row">
				<div class="bla-func-item">
					<span>Login in</span>
				</div>
				<div class="bla-func-item">
					<span>Sign up</span>
				</div>
			</div>
		</div>
	</c:if>

</div>
</body>
</html>