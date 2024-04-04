function fadeAlert() {
	$('.fake-alert-box').delay(2500).fadeOut(500);
}

function myAlert(txt) {
	$(".alert-text").text(txt);
	$(".fake-alert-box").fadeIn(100);

	fadeAlert();
}

function delHtml(html){
	var regex = /(<([^>]+)>)/ig;
	html = html.replace(regex, " ");
	return html;
}
function delPreSpace(str) {
	var regex = /(^\s*)|(\s*$)/g;
	return str.replace(regex, "");
}
function listHtml(html){
	var regex = /(<([^>]+)>)/ig;
	html = html.split(regex);
	return html;
}

function openSuspendCover(){
	$(".suspend-cover").show();
}
function closeSuspendCover(){
	$(".suspend-cover").hide();
	$(".suspend-cover").html("");
}

// type表示加减法,num表示数字
function formatNum(num){
	if (num.toString().indexOf("k") == -1) {
		let tnum = parseFloat(num);
		if(tnum > 999){
			return (tnum/1000).toFixed(1)+"k";
		} else {
			return tnum;
		}
	} else{
		let tnum = parseFloat(num.replace("k",""));
		return tnum*1000;
	}

}
function formatOperationNum(num,type){
	if (type == '-') {
		let tnum = formatNum(num)-1;
		return formatNum(tnum);
	} else {
		let tnum = formatNum(num)+1;
		return formatNum(tnum);
	}
}

// 放入"是转发的"字样
function isReTransmit(dom,name){
	var div = $("<div class='whether-forward-box'><img src='./images/icon/transmited.png' ><span><span>"+name+"</span>Retweeted</span></div>");
	dom.prepend(div);
}
// example
// var div = $(".content_card_total");
// isReTransmit(div,"哈哈哈哈");

// 格式数字转数字
function stringToNum(string){
	var sList = string.split(",");
	var rList = "";
	for(let i=0;i<sList.length;i++){
		rList = rList+sList[i];
	}
	return rList;
}

// 数字转格式数字
function numToString(num) {
	return (num || 0).toString().replace(/(\d)(?=(?:\d{3})+$)/g, '$1,');
}

// 向上向下滑动的动效
function upSlide(dom,curentBottom){
	dom.animate({
		bottom:'+=20px'
	},100,function(){
		dom.css("bottom",(curentBottom-20)+"px");
	});
	dom.animate({
		bottom:curentBottom+'px'
	},100);
}
function downSlide(dom,curentBottom){
	dom.animate({
		bottom:'-=20px'
	},100,function(){
		dom.css("bottom",(curentBottom+20)+"px");
	});
	dom.animate({
		bottom:curentBottom+'px'
	},100);
}

function likeContentAjax(contentId,userId){
	let param = {
		contentId: contentId,
		userId: userId
	};
	$.ajax({
		type : "post",
		url : "Content/likeContent",
		dataType : "json",
		data: param,
		success : function(data) {

		}
	});
}
function unlikeContentAjax(contentId,userId){
	let param = {
		contentId: contentId,
		userId: userId
	};
	$.ajax({
		type : "post",
		url : "Content/unlikeContent",
		dataType : "json",
		data: param,
		success : function(data) {

		}
	});
}

function ajaxFollowTopic(topicId){
	$.ajax({
		url : "Topic/followTopic/"+topicId,
		success : function(data){

		}
	});
}

function ajaxUnFollowTopic(topicId){
	$.ajax({
		url : "Topic/unfollowTopic/"+topicId,
		success : function(data){

		}
	});
}

function followUser(userId){
	$.ajax({
		type : "GET",
		url : "User/followUser/"+userId,
		success : function (data) {
			let code = data.code;
			console.log(data.code);
			if (code == "1") {
				myAlert("Follow successfully!");
			} else {
				alert("error");
			}
		}
	});
}
function unfollowUser(userId){
	$.ajax({
		type : "GET",
		url : "User/unfollowUser/"+userId,
		success : function (data) {
			let code = data.code;
			console.log(data.code);
			if (code == "1") {
				myAlert("Cancel follow!");
			} else {
				alert("error!!!");
			}
		}
	});
}

// 储存全局的selection，光标范围
var lastRange =null;

$(document).ready(function(){


	// 页面上面的心心,以及数字滚动效果
	$(".window .content").on('click','.likepicbox',function(){
		if($(this).parents(".parent-content-func-box").length != 0){
			return;
		}
		var userId = $(".fakeSession .fs-id").text();
		var contentId;
		if ($(this).parents(".content_card_total").length != 0){
			contentId = $(this).parents(".content_card_total").children(".content-card-id").eq(0).text();
		} else if ($(this).parents(".parent-rib").length != 0) {
			contentId = $(this).parents(".parent-rib").children(".fakeSession").children(".comment-id").eq(0).text();
		} else if ($(this).parents(".coc-box").length != 0) {
			contentId = $(this).parents(".coc-box").children(".fakeSession").children(".comment-id").eq(0).text();
		}
		var likepicSrc = $(this).children(".likepic").attr("src");
		var span = $(this).siblings("div").children("span");
		var num = span.text();
		if(likepicSrc == "images/icon/like.png" || likepicSrc == "images/icon/afterlike.png"){
			likeContentAjax(contentId,userId);
			span.text(formatOperationNum(num,'+'));
			$(this).children(".likepic").attr("src","images/icon/liked.png");
			span.css("color","#e53a7f");
			upSlide(span,0);
		} else if (likepicSrc == "images/icon/liked.png") {
			unlikeContentAjax(contentId,userId);
			span.text(formatOperationNum(num,'-'));
			$(this).children(".likepic").attr("src","images/icon/afterlike.png");
			span.css("color","#e53a7f");
			downSlide(span,0);
		}
	});


	// 内容下面的功能栏悬浮变色
	$(".window .content").on('mouseenter','.commentpicbox',function(){
		$(".commentpic").attr("src",'images/icon/aftercomment.png');
		var span = $(this).siblings("div").children("span");
		span.css("color","#499ae9");
	}).on('mouseleave','.commentpicbox',function(){
		$(".commentpic").attr("src",'images/icon/comment.png');
		var span = $(this).siblings("div").children("span");
		span.css("color","#44515d");
	});

	// 心心悬浮变色
	var originalSrc = null;
	$(".window .content").on('mouseenter','.likepicbox',function(){
		var likePic = $(this).children(".likepic");
		originalSrc =likePic.attr("src");
		var span = $(this).siblings("div").children("span");
		if(originalSrc == "images/icon/liked.png"){

		} else {
			likePic.attr("src",'images/icon/afterlike.png');
			span.css("color","#e53a7f");
		}
	}).on('mouseleave','.likepicbox',function(){
		var likePic = $(this).children(".likepic");
		var span = $(this).siblings("div").children("span");
		if(likePic.attr("src") == "images/icon/liked.png"){

		} else if (likePic.attr("src") == "images/icon/like.png"){

		} else if (likePic.attr("src") == "images/icon/afterlike.png"){
			likePic.attr("src","images/icon/like.png");
			span.css("color","#44515d");
		}
	});

	$(".window .content").on('mouseenter','.transmitpicbox',function(){
		$(".transmitpic").attr("src",'images/icon/aftertransmit.png');
		var span = $(this).siblings("div").children("span");
		span.css("color","#53b781");
	}).on('mouseleave','.transmitpicbox',function(){
		$(".transmitpic").attr("src",'images/icon/transmit.png');
		var span = $(this).siblings("div").children("span");
		span.css("color","#44515d");
	});

	$(".window .content").on('mouseenter','.forwardingpicbox',function(){
		$(".forwardingpic").attr("src",'images/icon/afterforwarding.png');
		var span = $(this).siblings("div").children("span");
		span.css("color","#499ae9");
	}).on('mouseleave','.forwardingpicbox',function(){
		$(".forwardingpic").attr("src",'images/icon/forwarding.png');
		var span = $(this).siblings("div").children("span");
		span.css("color","#44515d");
	});

	// 点击顶部跳上去
	// $(".center_top").click(function(){
	// 	$("html,body").scrollTop(0);
	// });



	// 获取最后的range，最后输入的位置，最后光标

	$("#div-editable").keyup(function(){
		var range = getSelection();
		lastRange = range.getRangeAt(0);
	});

	$("#div-editable").click(function(){
		var range = getSelection();
		lastRange = range.getRangeAt(0);
	});

	$("#div-editable").blur(function(){
		var range = getSelection();
		lastRange = range.getRangeAt(0);
	});




	// emoji
	// 注入一行emoji在表情列表里面
	var totalemojis = 52;
	var curentemojis = 1;
	function injectEmojisRow(){
		var div = $("<div class='stick-item-row d-flex flex-row'>");

		for(let i=0;i<9;i++){
			var divc = $("<div class='stick-item flex-fill'></div>");
			if(curentemojis<10){curentemojis='0'+curentemojis;}
			var img = $("<img src='images/emojis/emoji_sprite_"+curentemojis+".gif' >");
			if(curentemojis[0]== '0'){curentemojis=curentemojis.slice(1);}
			if(curentemojis > totalemojis){
				img = $("<img src='images/emojis/emoji_sprite_"+totalemojis+".gif' >");
			}
			divc.append(img);
			div.append(divc);
			curentemojis++;
		}

		$(".sticks-list-show").append(div);
	}
	// 注入全部emoji
	function injectEmojis(){
		for(let i=0;i<parseInt(52/9)+1;i++){
			injectEmojisRow();
		}
	}
	injectEmojis();



	// 往鼠标位置插入node
	function insertInCursor(node){
		var inputarea = $("#div-editable");
		let selection = getSelection();
		if(lastRange){
			selection.removeAllRanges();
			selection.addRange(lastRange);
		}
		let range = selection.getRangeAt(0);
		range.insertNode(node);
		range.collapse(false);
		lastRange = range;
	}

	// 点击输入emoji到输入框
	$(".stick-item").click(function(){
		let src = $(this).children("img").attr("src");
		var html = "<img src='"+src+"' class='emoji-item' >";
		var img = $(html).get(0);
		insertInCursor(img);
	});

	// 表情列表下面悬浮展示出来
	$(".stick-item").hover(function(){
		var src = $(this).children("img").attr("src");
		$(".sticks-show-box").children("img").attr("src",src);
	},function(){

	});

	// 函数只执行一次
	function onlyOnce(func){

	}

	// 函数节流
	var num = 0;
	var last;
	function throttle(func, duration){
		//duration 秒
		let now = Date.now();
		if (last != null && (now - last) < duration*1000){

		} else {
			last = now;
			console.log(++num);
			func();
		}
	}

	// 点击打开表情列表
	$(".open-stick-select").click(function(){
		$("#div-editable>div>span:first-child").focus();
		let toWinTopW = $(this).offset().top;
		let scrollTop = $(document).scrollTop();
		let result = toWinTopW - scrollTop;
		if(result < 380){
			$(this).find(".triangle-icon").eq(0).css("bottom","43px");
			$(this).find(".triangle-icon2").css("bottom","37px");
			$(this).children(".sticks-list-box").css("top","54px");
			$(".sticks-list-box").fadeIn();
		} else {
			$(this).find(".triangle-icon").eq(0).css("bottom","-241px");
			$(this).find(".triangle-icon2").css("bottom","-235px");
			$(this).children(".sticks-list-box").css("top","-302px");
			$(".sticks-list-box").fadeIn();
		}
	});

	// 关闭表情列表函数
	function closeEmojisList(){
		$(".sticks-list-box").delay(1000).fadeOut(500);
	}

	// 滑动屏幕关闭表情列表
	var lastScrollTop = 0;
	$(window).scroll(function(event){
		var st = $(this).scrollTop();

		if (st > lastScrollTop){
			// alert("down");
			// Scrolling down
			// 函数节流1.5秒只执行一次
			throttle(closeEmojisList,1.5);
		} else {
			// alert("up");
			// Scrolling up
			throttle(closeEmojisList,1.5);
		}
		lastScrollTop = st;
	});

	// 判断是否可以点击外部关闭表情框
	var whetherCloseEmojiNum = 0;
	$(document).click(function(event){
		whetherCloseEmojiNum++;
		var t=$(event.target);

		if(t.is(".open-stick-select")||t.is(".open-stick-select img")){
			whetherCloseEmojiNum = 3;
		}
		if(whetherCloseEmojiNum >= 4){
			if($(".sticks-list-box").is(':visible')){
				var spring = ".slb-title,.sticks-list-show div,.sticks-show-box";
				obj = $(event.target);
				if (obj.is(spring)) {
					// alert('内部区域');
				} else {
					$(".sticks-list-box").fadeOut(500);
					whetherCloseEmojiNum = 0;
				}
			} else {

			}
		}
	});


	// <===头像框===>
	// 通过蒙层打开头像框
	var susDom = null;
	$("#touxiang_box").click(function(){
		let top = $(this).offset().top;
		let top2 = $(window).scrollTop();
		let left = $(this).children("img").offset().left;
		let html = $(".tdb-show-box").prop("outerHTML");
		let result = top - top2;
		$(".total-suspend").show();
		$(".total-suspend").html(html);
		$(".total-suspend .tdb-show-box").fadeIn();
		$(".total-suspend .tdb-show-box").css("left",left-24);
		$(".total-suspend .tdb-show-box").css("top",result-166);
		susDom = $(this);
	});
	$(window).resize(function(){
		if($(".total-suspend").html() != "" && $(".total-suspend").children(".tdb-show-box").length == 1){
			let top = susDom.offset().top;
			let top2 = $(window).scrollTop();
			let left = susDom.children("img").offset().left;
			let result = top - top2;
			$(".total-suspend .tdb-show-box").css("left",left-24);
			$(".total-suspend .tdb-show-box").css("top",result-166);
		}
	});

	// 判断是否可以点击外部关闭头像框
	var whetherClosetouxiangBoxNum = 0;
	$(document).click(function(event){
		whetherClosetouxiangBoxNum++;
		var t=$(event.target);
		if(t.is("#touxiang_box")||t.is("#touxiang_box img") || t.is("#touxiang_box") || t.is(".account_info") || t.is(".account_info span")){
			whetherClosetouxiangBoxNum = 3;
		}
		if(whetherClosetouxiangBoxNum >= 4){
			if($(".tdb-show-box").is(':visible')){
				var spring = ".touxiang-details-box div,.touxiang-details-box span,.touxiang-details-box img";
				obj = $(event.target);
				if (obj.is(spring)) {
					// alert('内部区域');
				} else {
					$(".tdb-show-box").fadeOut(500);
					// $(".navigator>.suspend-cover").hide();
					closeSuspendCover();
					whetherClosetouxiangBoxNum = 0;
					susDom = null;
				}
			} else {

			}
		}
	});
	// <===头像框===>



	// <===输入类别选择框===>
	// 判断是否可以点击外部关闭输入框的类别选择box
	var whetherCloseCategoryBoxNum = 0;
	$(document).click(function(event){
		whetherCloseCategoryBoxNum++;
		var t=$(event.target);
		if(t.is(".openCagetory")||t.is(".openCagetory>img")){
			whetherCloseCategoryBoxNum = 3;
		}
		if(whetherCloseCategoryBoxNum >= 4){
			if($(".categoryBox").is(':visible')){
				var spring = ".categoryBox,.categoryBox div,.categoryBox span,.categoryBox div,.categoryBox img";
				obj = $(event.target);
				if (obj.is(spring)) {
					// alert('内部区域');
				} else {
					$(".categoryBox").fadeOut(500);
					// $(".navigator>.suspend-cover").hide();
					closeSuspendCover();
					whetherCloseCategoryBoxNum = 0;
					catDom = null;
				}
			} else {

			}
		}
	});


	var catDom = null;
	$(".openCagetory").click(function(){
		let top = $(this).offset().top;
		let top2 = $(window).scrollTop();
		let left = $(this).children("img").offset().left;
		let html = $(".categoryBox").prop("outerHTML");
		var cb = $(html);
		let result = top - top2;
		$(".total-suspend").show();
		$(".total-suspend").append(cb);
		$(".total-suspend .categoryBox").fadeIn();
		$(".total-suspend .categoryBox").css("left",left-166);
		$(".total-suspend .categoryBox").css("top",result+53);
		catDom = $(this);
	});
	function adjustCatBoxPosi(){
		if($(".total-suspend").html() != "" && $(".total-suspend").children(".categoryBox").length != 0){
			let top = catDom.offset().top;
			let top2 = $(window).scrollTop();
			let left = catDom.children("img").offset().left;
			let result = top - top2;
			$(".total-suspend .categoryBox").css("left",left-166);
			$(".total-suspend .categoryBox").css("top",result+53);
		}
	}
	$(window).resize(function(){
		adjustCatBoxPosi();
	});
	// 屏幕滑动随时调整类别选择列表的位置
	var indexlastScrollTop = 0;
	$(window).scroll(function(event){
		var st = $(this).scrollTop();
		if (st > indexlastScrollTop){
			adjustCatBoxPosi();
		} else {
			adjustCatBoxPosi();
		}
		indexlastScrollTop = st;
	});

	$(".total-suspend").on("click",".cb-childCategory .cbc-item",function(){
		if($(".selected-cat").children(".cbc-item:visible").length >= 5){
			myAlert("You can choose up to five topics.");
			return 0;
		}
		if ($(this).hasClass("selected-cat-item")) {
			return 0;
		}
		var itemid = $(this).children(".cat-item-id").text();
		$(".cb-childCategory .cbc-item").each(function(){
			let id = $(this).children(".cat-item-id").text();
			if (id == itemid) {
				$(this).addClass("selected-cat-item");
				$(this).children("img").attr("src","images/icon/right.png");
			}
		});
		// $(this).remove();
		var item = $($(this).prop("outerHTML"));
		item.children("img").attr("src","images/icon/right.png");
		$(".selected-cat").append(item);

		// 放到输入框下面去
		var scbItem = $('<div class="scb-item"><span></span><span class="cat-item-id d-none">456</span></div>');
		var name = item.children("span").eq(0).text();
		var id = item.children(".cat-item-id").eq(0).text();
		scbItem.children("span").eq(0).text(name);
		scbItem.children(".cat-item-id").eq(0).text(id);
		$(".selected-cat-box").append(scbItem);
		if($(".selected-cat-box").css("display") == "none"){
			$(".selected-cat-box").css("display","flex");
		}

		adjustCatBoxPosi();
	});

	$(".total-suspend").on("click",".selected-cat .cbc-item",function(){
		var thisid = $(this).children(".cat-item-id").text();
		$(".selected-cat .cbc-item").each(function(){
			let id = $(this).children(".cat-item-id").text();
			if (id == thisid) {
				$(this).fadeOut(50);
			}
		});
		var itemid = $(this).children(".cat-item-id").text();
		$(".cb-childCategory .cbc-item").each(function(){
			if (itemid == $(this).children(".cat-item-id").text()) {
				$(this).removeClass("selected-cat-item");
				$(this).children("img").attr("src","images/icon/add.png");
			}
		});

		// 从输入框下面拿走
		$(".selected-cat-box .scb-item").each(function () {
			var id = $(this).children(".cat-item-id").eq(0).text();
			if($(this).css("display") == "block"){
				if(id == itemid){
					$(this).fadeOut(50);
					if($(".selected-cat-box .scb-item:visible").length == 1){
						$(".selected-cat-box").css("display","none");
					}
				}
			}
		});
		$(".selected-cat .cbc-item").each(function () {
			var name3 = $(this).children("span").eq(0).text();
			if($(this).css("display") == "block"){
				if(name3 == name){
					$(this).fadeOut(50);
				}
			}
		});
		adjustCatBoxPosi();
	});

	$(".selected-cat-box").on("click",".scb-item",function(){
		$(this).fadeOut(50);
		if($(".selected-cat-box .scb-item").length == 0){
			$(".selected-cat-box").css("display","none");
		}
		var itemid = $(this).children(".cat-item-id").text();
		$(".selected-cat .cbc-item").each(function(){
			let id = $(this).children(".cat-item-id").text();
			if (id == itemid) {
				$(this).fadeOut(50);
			}
		});
		var itemid = $(this).children(".cat-item-id").text();
		$(".cb-childCategory .cbc-item").each(function(){
			if (itemid == $(this).children(".cat-item-id").text()) {
				$(this).removeClass("selected-cat-item");
				$(this).children("img").attr("src","images/icon/add.png");
			}
		});
	});


	// <===输入类别选择框===>


	$(".cts-follow-btn").click(function(){
		let span = $(this).children("span");
		let topicId = $(this).parent().children(".cts-id").children("span").text();
		if (span.text() == "Follow") {
			span.text("Unfollow");
			$(this).addClass("cts-follow-btn-clicked");
			ajaxFollowTopic(topicId);
		} else{
			span.text("Follow");
			$(this).removeClass("cts-follow-btn-clicked");
			ajaxUnFollowTopic(topicId);
		}
	});

	$(".cts-follow-btn").hover(function(){
		let span =$(this).children("span");
		if($(this).hasClass("cts-follow-btn-clicked")){
			span.text("Unfollow");
		}
	},function(){
		let span =$(this).children("span");
		if($(this).hasClass("cts-follow-btn-clicked")){
			span.text("Following");
		}
	});

	// 所有的follow people
	$(".follow-people-btn").click(function() {
		let text = $(this).children("span").text();
		let clicked = (text == "Following");
		let userId = $(this).parents(".peopleListItem").children(".pli-user-id").text();
		if (clicked){
			$(this).removeClass("follow-people-btn-clicked");
			$(this).children("span").text("Follow");
			unfollowUser(userId);
		} else {
			$(this).addClass("follow-people-btn-clicked");
			$(this).children("span").text("Unfollow");
			followUser(userId);
		}
	});

	$(".follow-people-btn").hover(function(){
		let span =$(this).children("span");
		if($(this).hasClass("follow-people-btn-clicked")){
			span.text("Unfollow");
		}
	},function(){
		let span =$(this).children("span");
		if($(this).hasClass("follow-people-btn-clicked")){
			span.text("Following");
		}
	});

	$(".wtf-follow-people-btn").click(function() {
		let text = $(this).children("span").text();
		let clicked = (text == "Unfollow");
		let userId = $(this).siblings(".wli-user-id").text();
		if (clicked){
			$(this).removeClass("follow-people-btn-clicked");
			$(this).children("span").text("Follow");
			unfollowUser(userId);
		} else {
			$(this).addClass("follow-people-btn-clicked");
			$(this).children("span").text("Following");
			followUser(userId);
		}
	});

	$(".wtf-follow-people-btn").hover(function(){
		let span =$(this).children("span");
		if($(this).hasClass("follow-people-btn-clicked")){
			span.text("Unfollow");
		}
	},function(){
		let span =$(this).children("span");
		if($(this).hasClass("follow-people-btn-clicked")){
			span.text("Following");
		}
	});


	$(".follow-topic-btn").click(function(){
		let span = $(this).children("span");
		let clicked = (span.text() == "Unfollow");
		if (clicked){
			$(this).removeClass("follow-people-btn-clicked");
			span.text("Follow");
		} else {
			$(this).addClass("follow-people-btn-clicked");
			span.text("Unfollow");
		}
	});
	$(".follow-topic-btn").hover(function(){
		let span =$(this).children("span");
		if($(this).hasClass("follow-people-btn-clicked")){
			span.text("Unfollow");
		}
	},function(){
		let span =$(this).children("span");
		if($(this).hasClass("follow-people-btn-clicked")){
			span.text("Following");
		}
	});

});