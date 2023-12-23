
// 跳转到detailcontent的ajax
//update: 变成拼接字符串的形式，又controller负责转发，解决了返回不能到上一个内容的问题
function detailContentAjax(contentId){
	$(window).attr('location','Content/detailContent/'+contentId);
}
function detailUser(userId){
	$(window).attr('location','User/detailUser/'+userId);
}

function ajaxSearchResult(keyword){
	$.ajax({
		type : "GET",
		url : "Search/"+keyword,
		success : function (data) {
			console.log(data.resultUsers);
			let html2 = "<div class=\"search-result-item d-flex flex-row\">\n" +
				"\t\t\t\t\t\t\t<img src=\"images/icon/search-icon.png\" >\n" +
				"\t\t\t\t\t\t\t<div class=\"sri-info d-flex\">\n" +
				"\t\t\t\t\t\t\t\t<div class=\"d-flex flex-column\">\n" +
				"\t\t\t\t\t\t\t\t\t<span>"+keyword+"</span>\n" +
				"\t\t\t\t\t\t\t\t\t<span>"+data.resultContents.length+" WEISends</span>\n" +
				"\t\t\t\t\t\t\t\t</div>\n" +
				"\t\t\t\t\t\t\t</div>\n" +
				"\t\t\t\t\t\t</div>";
			$(".search-result-items").append($(html2));
			for (var i = 0; i < data.resultUsers.length; i++){
				let html = "<div class=\"search-result-item d-flex flex-row\">\n" +
					"\t\t\t\t\t\t\t<div class=\"d-none sri-people-id\">"+data.resultUsers[i].id+"</div>\n" +
					"\t\t\t\t\t\t\t<img src=\""+data.resultUsers[i].profilePicUrl+"\" >\n" +
					"\t\t\t\t\t\t\t<div class=\"sri-info d-flex\">\n" +
					"\t\t\t\t\t\t\t\t<div class=\"d-flex flex-column\">\n" +
					"\t\t\t\t\t\t\t\t\t<span>"+data.resultUsers[i].name+"</span>\n" +
					"\t\t\t\t\t\t\t\t\t<span>@"+data.resultUsers[i].email+"</span>\n" +
					"\t\t\t\t\t\t\t\t\t<span>"+data.resultUsers[i].followerNum+" Followers</span>\n" +
					"\t\t\t\t\t\t\t\t</div>\n" +
					"\t\t\t\t\t\t\t</div>\n" +
					"\t\t\t\t\t\t</div>";
				let dom = $(html);
				$(".search-result-items").append(dom);
			}
			$(".search-result-box>span").css("display","none");
			$(".search-result-items").show();
		}
	});
}

function search(type,keyword){
	let url = "Search/"+type+"/"+keyword;
	$(window).attr('location',url);
}

function editionUploadFile() {
	let url;
	$.ajax({
		type : "post",
		url : "File/User/Edition/uploadFile",
		data : new FormData($("#profile-edition-form")[0]),
		contentType: false,
		processData: false,
		async: false,
		success: function(data) {
			url = data;
		},
		error : function(data) {
			url = data;
		}
	});
	return url;
}

function editUser(){
	let name = $("#piia-name").val();
	let signature = $("#piia-bio").val();
	let region = $("#piia-location").val();
	let gender = $("#piia-gender-selection option:selected").val();
	let bgPicUrl = $("#realBgPicUrl").text();
	let profilePicUrl = $("#realPfPicUrl").text();
	let user = JSON.stringify({
		name: name,
		signature: signature,
		region: region,
		gender: gender,
		bgPicUrl: bgPicUrl,
		profilePicUrl: profilePicUrl,
	});
	console.log(user);
	$.ajax({
		type : "post",
		url : "User/updateUser",
		contentType : "application/json",
		data : user,
		success: function(data) {
			let result = JSON.parse(data);
			if (result.myStatus == "success"){
				location.reload();
			}
		}
	});
}

$(document).ready(function(){

	// 实现div变fixed,设置宽度100%不能匹配父元素的问题，并且实时设置账号模块的padding-top，这样账号模块就可以在最下面, 还有让accoutnid的span
	function adjustCurrentAccountPT(){
		var winh = $(".navigator").height();
		var h = 46+$(".menu_box .menu").length*62+94;
		var result = winh-h;
		if(result<=0){result = 0;}
		$(".current_account").css("padding-top",result);
	}
	function adjustWidth() {undefined
		var parentwidth = $(".window").width();
		$(".center_top").width(parentwidth);
	}
	function adjustSearchFuncWidth() {undefined
		var parentwidth = $(".window").width();
		$(".search-func-area").width(parentwidth);
	}
	function adjusAcountIdSpanWidth(){
		var parentwidth = $("#touxiang_box").width();
		var w = parentwidth - 48;
		$("#touxiang_box .account_info").css("width",w+"px");
	}
	adjustSearchFuncWidth();
	adjustCurrentAccountPT();
	adjustWidth();
	adjusAcountIdSpanWidth();
	$(window).resize(
		function() {
			var winw = $(window).height();
			adjustCurrentAccountPT()
			if(winw >1200){
				adjusAcountIdSpanWidth();
			}
			adjustWidth();
			adjustSearchFuncWidth();
		});

	// 点击index的follow的一些操作
	$(".follow_box_follow").click(function(){
		let text = $(this).text();
		let clicked = (text == "Following");
		if (clicked){
			$(".follow_box_follow").removeClass("follow_box_follow-clicked");
			$(".follow_box_follow").text("Follow");
			let dom = $(".follower_span span");
			let num = parseInt(dom.text());
			dom.text(--num);
			downSlide(dom,0);
			let userId = $(".fakeSession .detailUser-id").text();
			unfollowUser(userId);
		} else {
			$(".follow_box_follow").addClass("follow_box_follow-clicked");
			$(".follow_box_follow").text("Following");
			let dom = $(".follower_span span");
			let num = parseInt(dom.text());
			dom.text(++num);
			upSlide(dom,0);
			let userId = $(".fakeSession .detailUser-id").text();
			followUser(userId);
		}
	});

	// 点击profile三个选项
	$(".profile_select").children(".flex-fill").click(function(){
		$(".profile_select").find(".flex-fill").removeClass("profile_select_clicked");
		$(this).addClass("profile_select_clicked");
	});

	// 点击profile 的 likes选项
	$(".index-like-button").click(function() {
		let userId = $(".detailUser-id").text();
		$(window).attr('location','User/detailUser/'+userId+"/likes");
	});
	$(".index-normal-button").click(function() {
		let userId = $(".detailUser-id").text();
		$(window).attr('location','User/detailUser/'+userId);
	});
	$(".index-media-button").click(function() {
		let userId = $(".detailUser-id").text();
		$(window).attr('location','User/detailUser/'+userId+"/medias");
	});

	// 动态控制搜索结果的宽度
	function adjustSearchResultWidth(){
		var dom = $(".search-result-box");
		var pw = $(".search_box").width();
		dom.css("width",(pw+20)+"px");
	}
	//动态控制搜索结果的高度
	function adjustSearchResultHeight(){
		var winw = $(window).height();
		var tw = winw - 140;
		$(".search-result-box").css("max-height",tw+"px");
	}
	adjustSearchResultHeight();
	adjustSearchResultWidth();
	$(window).resize(
		function() {
			adjustSearchResultWidth()
			adjustSearchResultHeight()
		});



	// 滑动出现follow
	$(window).scroll(function(){
		var btop = $(window).scrollTop();
		if(btop >= 205.5 ){
			$("#follow_button_top").show();
		} else if(btop < 205.5 ) {
			$("#follow_button_top").hide();
		}
	});

	// 点击放大图片
	// $("#picture_enlargement_box").hide();
	$(document).on("click",".zoomable_pic",function (){
		$("#picture_enlargement_box").show();
		var currentpic = $(this)[0].src;
		$("#picture_enlargement_box").children("img").attr("src",currentpic);
		// 禁止页面滚动
		var top = $(document).scrollTop();
		$(document).on('scroll.unable', function (e) {
			$(document).scrollTop(top);
		});
	});

	// 关闭放大的图片
	$("#picture_enlargement_box").click(function(){
		$(document).unbind("scroll.unable");
		$("#picture_enlargement_box").hide();
	});

	// 设置了图片不继承父元素的点击事件,所以这个用不了了
	// var x = 0;
	// // 鼠标点击获取标签对象
	// $(document).click(function(event){
	// 	if($('#picture_enlargement_box').is(':visible')){
	// 		var t=$(event.target).attr("id");
	// 		var c=$("#large_pic").attr("id");
	// 		if(t != c){
	// 			if(x == 0){
	// 				x = 1;
	// 			} else {
	// 				$(document).unbind("scroll.unable");
	// 				$("#picture_enlargement_box").hide();
	// 				x = 0;
	// 			}
	// 		}
	// 	} else{

	// 	}
	// });


	// function oppenSuspendCover(){
	// 	$(".suspend-cover").show();
	// }
	// function closeSuspendCover(){
	// 	$(".suspend-cover").hide();
	// }

	var certainDom = null;
	function suspendFunc(dom){
		let top = dom.offset().top;
		let top2 = $(window).scrollTop();
		let left = dom.offset().left;
		let html = dom.siblings(".suspended_card_more").prop("outerHTML");
		let result = top - top2;
		// alert(html);
		// alert(top+" "+top2+" "+result+" "+left);
		$(".total-suspend").show();
		$(".total-suspend").html(html);
		$(".total-suspend .suspended_card_more").show();
		$(".total-suspend .suspended_card_more").css("left",left-201);
		$(".total-suspend .suspended_card_more").css("top",result+18);
		certainDom = dom;
	}

	// 点击内容卡片或者趋势推荐的更多,出现选项卡
	$(".window .content").on("click",".rib-more",function (){
		suspendFunc($(this));
	});
	$(".window .content").on("click",".transmitpicbox",function (){
		suspendFunc($(this));
	});
	$(".window .content").on("click",".forwardingpicbox",function (){
		suspendFunc($(this));
	});
	$(".window .content").on("click",".content_card_more",function (){
		suspendFunc($(this));
	});
	// 在非js动态输入中，正常页面展示，如下代码无效
	// $(document).on("click",".content_card_more",function(){
	// 	alert("execute");
	// 	suspendFunc($(this));
	// });
	$(".trends_foryou_item_more").click(function(){
		suspendFunc($(this));
	});

	$(".explore-trends .trends_foryou_item_more").click(function(){
		suspendFunc($(this));
	});
	// 点击让suspendcard消失
	$(".suspend-cover").click(function(){
		if ($(this).children(".categoryBox").length == 0){
			closeSuspendCover();
		}
	});
	// var ccmi = 0;
	// $(document).click(function(event){
	// 	ccmi++;
	// 	var t=$(event.target);
	// 	// alert(t.hasClass("suspended_card_more"));
	// 	if(t.hasClass("content_card_more")||t.hasClass("trends_foryou_item_more") || t.hasClass("rib-more") || t.hasClass("transmitpicbox") || t.hasClass("transmitpic") || t.hasClass("forwardingpicbox") || t.hasClass("forwardingpic")){
	// 		ccmi = 3;
	// 	}
	// 	if(ccmi >= 4){
	// 		if($(".suspended_card_more").is(':visible')){
	// 			var spring = ".suspended_card_more,.suspended_card_more a";
	// 			obj = $(event.target);
	// 			if (obj.is(spring)) {
	// 				// alert('内部区域');
	// 			} else {
	// 				closeSuspendCover();
	// 				certainDom = null;
	// 			}
	// 		} else {
	//
	// 		}
	// 	}
	//
	// });

	// 屏幕滑动随时调整悬浮框的位置
	var indexlastScrollTop = 0;
	$(window).scroll(function(event){
		var st = $(this).scrollTop();
		if (st > indexlastScrollTop){
			adjustSuspendBox();
		} else {
			adjustSuspendBox();
		}
		indexlastScrollTop = st;
	});

	// 屏幕改变尺寸随时调整悬浮框的位置
	$(window).resize(function(){
		adjustSuspendBox();
		if(certainDom != null){
			if(certainDom.parents(".trends").css("display") == "none"){
				closeSuspendCover();
				certainDom = null;
			}
		}
	});

	function adjustSuspendBox(){
		if($(".total-suspend").html() != "" && $(".total-suspend .suspended_card_more").length != 0){
			let top = certainDom.offset().top;
			let top2 = $(window).scrollTop();
			let left = certainDom.offset().left;
			let result = top - top2;
			$(".total-suspend .suspended_card_more").css("left",left-201);
			$(".total-suspend .suspended_card_more").css("top",result+18);
		}
	}

	// 点击搜索框改变边框和样式
	$("#search_input").focus(function(){
		$(".search_box img").attr("src","images/icon/search_focus.png")
		$(".search_box").css("border-color","#499bea");
		$(".search_box").css("background-color","rgba(255, 255, 255, 0)");
		$(".search_box").css("top","2px")
		$(this).css("background-color","rgba(255, 255, 255, 0)");
		if($(this).val()!=""){
			$(this).siblings(".search-text-reset").css("display","flex");
			$(".search-result-box").show();
			$(".search-result-box>span").css("display","none");

			$(".search-result-items").show();
			$("#search_input").keyup();
		} else {
			$(this).siblings(".search-text-reset").css("display","none");
			$(".search-result-box").show();
			$(".search-result-box>span").css("display","flex");

			$(".search-result-items").hide();
		}
	});
	$("#search_input").blur(function(e){
		setTimeout(function() {
			$(".search_box img").attr("src","images/icon/search.png")
			$(".search_box").css("border-color","#f0f3f4");
			$(".search_box").css("background-color","#f0f3f4");
			$(".search_box").css("top","2px")
			$(this).css("background-color","#f0f3f4");
			setTimeout(function(){undefined
				$(this).siblings(".search-text-reset").css("display","none");
			}, 10);
			$(".search-result-box").hide();
		},10);
	});

	$(".search-result-items").on("mousedown",".search-result-item",function(e) {
		let id = $(this).children(".sri-people-id").text();
		$(window).attr('location','User/detailUser/'+id);
	});

	var stTimeout;
	$("#search_input").keyup(function(){
		clearTimeout(stTimeout);
		if($(this).val()!=""){
			$(this).siblings(".search-text-reset").css("display","flex");
		} else {
			$(this).siblings(".search-text-reset").css("display","none");
		}
		$(".search-result-items").empty();
		$(".search-result-box>span").css("display","flex");
		let keyword = $(this).val();
		stTimeout = setTimeout(function (){
			ajaxSearchResult(keyword);
		},300);
	});

	$(".search-text-reset").click(function(){
		setTimeout(function(){undefined
			// alert("");
			$("#search_input").val("");
			$("#search_input").focus();
		}, 15);

	});

	$("#search_input").keydown(function(event){
		let keyword = $(this).val();
		var type;
		if ($(".search-func-area .si-selected").length > 0){
			type = $(".search-func-area .si-selected").text();
		} else {
			type = "Top";
		}
		if(event.keyCode==13){
			search(type,keyword);
		}
	});



	// // 红心心特效
	// $('body').on("click",'.heart',function()
	// {

	// 	var A=$(this).attr("id");
	// 	var B=A.split("like");
	// 	var messageID=B[1];
	// 	var C=parseInt($("#likeCount"+messageID).html());
	// 	$(this).css("background-position","")
	// 	var D=$(this).attr("rel");

	// 	if(D === 'like') 
	// 	{      
	// 	$("#likeCount"+messageID).html(C+1);
	// 	$(this).addClass("heartAnimation").attr("rel","unlike");

	// 	}
	// 	else
	// 	{
	// 	$("#likeCount"+messageID).html(C-1);
	// 	$(this).removeClass("heartAnimation").attr("rel","like");
	// 	$(this).css("background-position","left");
	// 	}


	// });



	// 转发框,突然发现因为高度只设置了最高高度,因此不用想content和home的输入框一样要设置hp或者wp.
	// // img加载的时候判断一下长宽
	// $(function(){
	// 	$(".tf-singlePic").on("load",function(){ //核心
	// 		var w = $(this).width();
	// 		var h = $(this).height();
	// 		if(w/h > 1.574){
	// 			$(this).removeClass("hp");
	// 			$(this).addClass("wp");
	// 		} else {
	// 			$(this).removeClass("wp");
	// 			$(this).addClass("hp");
	// 		}
	// 	});
	// });
	// // 加载页面的时候判断转发框里的pic的长宽
	// function adjustTransmitFramePic(){
	// 	var sp = $(".tf-singlePic");
	// 	alert("");
	// 	var w = sp.width();
	// 	var h = sp.height();
	// 	if(w/h > 1.574){
	// 		sp.removeClass("hp");
	// 		sp.addClass("wp");
	// 	} else {
	// 		sp.removeClass("wp");
	// 		sp.addClass("hp");
	// 	}
	// }
	// adjustTransmitFramePic();

	// 让content内容框里面的doublePic配对正确的显示形式
	function reLoadSource(img){
		let d = new Date;
		src = img.attr("src");
		img.attr("src",src+"?timestamp="+d.getTime());
	}

	$(".double_picture_frame img").on("load",function(){
		var w = $(this).width();
		var h = $(this).height();
		if(h/w < 1.127){
			$(this).removeClass("hp");
			$(this).addClass("wp");
		} else {
			$(this).removeClass("wp");
			$(this).addClass("hp");
		}
	});
	$(".hpicture").on("load",function(){
		var w = $(this).width();
		var h = $(this).height();
		if(h/w < 1.1){
			$(this).parent().css("max-width","100%");
		} else {

		}
	});
	$(".index-medias-show .two-photos-show img").on("load",function() {
		var w = $(this).width();
		var h = $(this).height();
		if(h/w < 1.176){
			$(this).removeClass("hp");
			$(this).addClass("wp");
		} else {
			$(this).removeClass("wp");
			$(this).addClass("hp");
		}
	});
	$(".index-medias-show .sixfour-photos-show img").on("load",function() {
		var w = $(this).width();
		var h = $(this).height();
		if(h/w < 0.855){
			$(this).removeClass("hp");
			$(this).addClass("wp");
		} else {
			$(this).removeClass("wp");
			$(this).addClass("hp");
		}
	});

	$(".hpicture").each(function(){
		reLoadSource($(this));
	});
	$(".double_picture_frame img").each(function(){
		reLoadSource($(this));
	});
	if(!$(".index-medias-show img").eq(0).hasClass("wp") && !$(".index-medias-show img").eq(0).hasClass("hp")){
		$(".index-medias-show img").each(function(){
			reLoadSource($(this));
		});
	}


	// 由于动态加入content，因此改了代码，原版在前端有
	// 点击内容跳转detail content.html
	$(".window .content").on("click",".content_card_total",function(event){
		let dom = $(event.target);
		let spring =".content_card_total .actual_content_picture img,.content_card_total .actual_content_picture .content_video_frame,.content_card_total .actual_content_picture .content_video_frame video,.content_card_bottom>.flex-fill>div,.content_card_bottom>.flex-fill img,.content_card_bottom>.flex-fill span,.content_card_total .content_card_more,.content_card_total .content_profile_picture_box img";
		if(!dom.is(spring)){
			var contentId = $(this).children(".content-card-id").text();
			detailContentAjax(contentId);
		}
	});

	$(".window .content").on("click",".parent-rib",function(event){
		let dom = $(event.target);
		let spring =".parent-rib .rib-left img,.parent-rib .rib-more,.parent-rib .rib_bottom>div>div,.parent-rib .rib_bottom>div>div img,.parent-rib .rib_bottom>div>div span," +
			".parent-rib .double_picture_frame,parent-rib .double_picture_frame img,.parent-rib .content_video_frame,.parent-rib .content_video_frame video,.parent-rib .content_picture_frame img";
		if(!dom.is(spring)){
			var contentId = $(this).children(".fakeSession").children(".comment-id").text();
			detailContentAjax(contentId);
		}
	});

	$(".window .content").on("click",".coc-box",function(event){
		let dom = $(event.target);
		let spring =".coc-box .rib-left img,.coc-box .rib-more,.coc-box .rib_bottom>div>div,.coc-box .rib_bottom>div>div img,.coc-box .rib_bottom>div>div span," +
			".coc-box .double_picture_frame,.coc-box .double_picture_frame img,.coc-box .content_video_frame,.coc-box .content_video_frame video,.coc-box .content_picture_frame img";
		if(!dom.is(spring)){
			var contentId = $(this).children(".fakeSession").children(".comment-id").text();
			detailContentAjax(contentId);
		}
	});


	// 编辑个人资料
	$(".piia-item").click(function(){
		// if ($(this).children("input").is(':visible')) {
		// 	$(this).children("input").focus();
		// } else {
		$(this).children("span").css("color","#499bea");
		$(this).css("border","#499bea solid 1px");
		$(this).animate({
			padding: '1px 8px'
		},100);
		$(this).children("span").animate({
			fontSize: '14px',
		},100);
		$(this).children("input").show();
		$(this).children("input").focus();
		// }

	});

	$(".pea-info-input-area select").click(function(){
		$(this).css("border","#499bea solid 1px");
	});
	$(".pea-info-input-area select").blur(function(){
		$(this).css("border","rgb(237, 240, 242) solid 1px");
	});

	$(".piia-item-select").change(function(){
		judgePiiaItemSelection();
	});

	function judgePiiaItemSelection(){
		if ($("#piia-gender-selection option:selected").val() == 1 || $("#piia-gender-selection option:selected").val() == 0){
			$("#piia-gender-selection").removeClass("piia-item-select-font");
		} else if ($("#piia-gender-selection option:selected").val() == -1) {
			$("#piia-gender-selection").addClass("piia-item-select-font");
		}
	}
	judgePiiaItemSelection();


	$(".piia-item input").blur(function(){
		var val = $(this).val();
		// alert();
		if(val == ""){
			var item = $(this).parent();
			item.children("input").hide();
			item.children("span").css("color","#6b7781");
			item.css("border","rgb(237, 240, 242) solid 1px");
			item.animate({
				padding: '15px 8px'
			},100);
			item.children("span").animate({
				fontSize: '16px',
			},100);
		} else {
			var item = $(this).parent();
			item.children("span").css("color","#6b7781");
			item.css("border","rgb(237, 240, 242) solid 1px");
		}

	});

	function flashEditProfileInfo(){
		let bpeImage = $("#bk_picture").attr("src");
		$(".backgroung-pic-edtion>img").attr("src",bpeImage);
		let ppurl = $("#portrait").attr("src");
		$(".profile-pic-edtion>img").attr("src",ppurl);
		$(".pea-info-input-area input").val("");
	}

	$("#edit-profile-button").click(function() {
		// flashEditProfileInfo();
	    if ($(".profile-edition-area-back").is(':visible')){
			$(".profile-edition-area-back").css("display","none");
			$(document).unbind("scroll.unable");
		} else {
			$(".profile-edition-area-back").css("display","flex");
			// 禁止页面滚动
			var top = $(document).scrollTop();
			$(document).on('scroll.unable', function (e) {
				$(document).scrollTop(top);
			});
		}
	});
	$(".profile-edition-area-back").click(function() {
		$(document).unbind("scroll.unable");
	    $(this).hide();
		$(".realBgPicUrl").text("");
		$(".realPfPicUrl").text("");
	});

	$(".profile-edition-area").click(function (e) {
		e.stopPropagation();
	});

	$(".profile-edition-area .pea-save-btn").click(function(e) {
	    editUser();
	});

	// 点击叉叉关闭editionprofile界面
	$(".pea-cancel-btn").click(function(e) {
		$(document).unbind("scroll.unable");
		$(".profile-edition-area-back").hide();
		$(".realBgPicUrl").text("");
		$(".realPfPicUrl").text("");
	});

	// edition area的照片及时显示
	$(".backgroung-pic-edtion .bpe-addphoto-box").click(function(e) {
		$("#pe-bgPicUrl-input").click();
	});
	$("#pe-bgPicUrl-input").change(function() {
		var ofReader = new FileReader();
		var file = document.getElementById('pe-bgPicUrl-input').files[0];
		ofReader.readAsDataURL(file);
		ofReader.onloadend = function(ofrEvent){
			var src = ofrEvent.target.result;

			if ($(".picture-edition-area-back").is(":visible")){
				$(".picture-edition-area-back").hide();
			} else {
				$(".picture-edition-area-back").css("display","flex");
			}
			$(".operation-area #imgBox img").attr("src",src);
			createCanvas("bg");
		}
	});

	$(".profile-pic-edtion .bpe-addphoto-box").click(function(e) {
		$("#pe-profilePicUrl-input").click();
	});
	$("#pe-profilePicUrl-input").change(function() {
		var ofReader = new FileReader();
		var file = document.getElementById('pe-profilePicUrl-input').files[0];
		ofReader.readAsDataURL(file);
		ofReader.onloadend = function(ofrEvent){
			var src = ofrEvent.target.result;

			if ($(".picture-edition-area-back").is(":visible")){
				$(".picture-edition-area-back").hide();
			} else {
				$(".picture-edition-area-back").css("display","flex");
			}
			$(".operation-area #imgBox img").attr("src",src);
			createCanvas("pf");
		}
	});

});