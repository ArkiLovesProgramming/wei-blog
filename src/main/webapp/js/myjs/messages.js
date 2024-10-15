// 把新聊天的记录放在最上
function topContactListItem() {
	$(".contact_list_item").each(function () {
		if ($(this).css("border-right") == "2px solid rgb(73, 155, 234)"){
			let cliHtml = $(this).prop("outerHTML");
			$(".contact_list").prepend($(cliHtml));
			$(this).remove();
		}
	});
}

function changeCIMRadius(dom){
	if($(dom).siblings(".chating-tiem-media").length == 1){
		let ctm = $(dom).siblings(".chating-tiem-media");
		var ctmw;
		let type;
		if(ctm.children(".ctm-pic-box").length == 1){
			ctmw = ctm.children(".ctm-pic-box").width();
			type = 0 ;
		} else if (ctm.children(".ctm-video-box").length == 1){
			ctmw = ctm.children(".ctm-video-box").width();
			type = 1 ;
		}
		let thisw = $(dom).children(".general_content").innerWidth();
		if(ctmw == thisw){
			if(type == 0){
				ctm.children(".ctm-pic-box").css("border-bottom-left-radius","0px");
				ctm.children(".ctm-pic-box").css("border-bottom-right-radius","0px");
			} else if ( type == 1){
				ctm.children(".ctm-video-box").css("border-bottom-left-radius","0px");
				ctm.children(".ctm-video-box").css("border-bottom-right-radius","0px");
			}
		}
		$(dom).children(".general_content").css("border-top-left-radius","0px");
		$(dom).children(".general_content").css("border-top-right-radius","0px");
	}
}

// 默认让聊天界面翻到最下
function chatingscrollbottom() {undefined
	$('.chating').scrollTop($(".chating")[0].scrollHeight);
}
// 设置chating固定高度
function adjustchatingheight() {undefined
	var wh = $(window).height();
	var h1 = $(".chating_area .top").height();
	var h2 = $(".typing_area").height()+13;
	var res = wh-h2;
	$(".chating").css("height",res);
}

function flashTypingArea(){
	$(".tis-area").addClass("d-none");
	$(".typing-video-show").addClass("d-none");
	$(".typing-img-show").addClass("d-none");
	$("#msg-file-input").val("");
	$("#div-editable").html("<div class=\"d-flex flex-column\" ><span></span></div>");
	// 调整一下聊天框的高度
	adjustchatingheight();
	chatingscrollbottom();
}

function getChatDate(ds){
	// let ds = "2022/03/21 01/38/03";
	// ds = "2022/03/21 01/38/03";
	let datel2 = ds.split(" ");
	let secondl = datel2[1].replaceAll("/",":");
	let now = new Date();
	var d = datel2[0]+' '+secondl;
	let rt = new Date(d);
	let interval = now.getTime() - rt.getTime();
	// let minute = addPreZero(interval/1000/60);
	let minute = interval/1000/60;
	let month = rt.toDateString().split(" ")[1];
	let day = rt.getDate();
	let hour = rt.getHours()%12 == 0 ? 12 : rt.getHours()%12;
	let tt;
	if(rt.getHours() < 12){tt = "AM";}else{tt = "PM";}
	if(minute/60 >= 48){
		let dateStr = month + " " + day + ","+hour+":"+rt.getMinutes() + " "+tt;
		return dateStr;
	} else if (minute/60 >= 24 && minute/60 <48) {
		let dateStr = "Yesterday,"+hour+":"+rt.getMinutes() + " "+tt;
		return dateStr;
	} else if (minute/60 < 24){
		let dateStr = hour+":"+rt.getMinutes() + " "+tt;
		return dateStr;
	}
	return "";
}

function createMyChat(chat){
	let myChatingItems = $("<div class=\"my_chating_items\"></div>");
	if(chat.videoURL != '0' || chat.pictureURL != '0'){
		let chatingItemMedia = $("<div class=\"chating-tiem-media d-flex flex-row-reverse\"></div>");
		if(chat.videoURL != '0'){
			let ctmVideoBox = $('<div class="ctm-video-box" style="border-bottom-right-radius:0px"><video controls autoplay muted loop><source src="'+chat.videoURL+'" type="video/mp4" /></video></div>');
			chatingItemMedia.append(ctmVideoBox);
		} else {
			let ctmPicBox = $('<div class="ctm-pic-box" style="border-bottom-right-radius:0px"><img class="zoomable_pic" src="'+chat.pictureURL+'" /></div>');
			chatingItemMedia.append(ctmPicBox);
		}
		myChatingItems.append(chatingItemMedia);
	}
	if(chat.textContent != ""){
		let chatingItemsMain = $('<div class="chating_items_main d-flex flex-row-reverse"><div class="my_chating_content general_content">'+chat.textContent+'</div></div>');
		myChatingItems.append(chatingItemsMain);
	}
	let dateStr = getChatDate(chat.releasingTime);
	let chatingItemsDate = $('<div class="chating_items_date d-flex flex-row-reverse"><span>'+dateStr+'</span></div>');
	myChatingItems.append(chatingItemsDate);
	return myChatingItems;
}

function createOtherChat(chat){
	let othersChatingItems = $("<div class=\"others_chating_items\"></div>");
	if(chat.videoURL != '0' || chat.pictureURL != '0'){
		let chatingItemMedia = $("<div class=\"chating-tiem-media\" style=\"padding-left: 51px;\"></div>");
		if(chat.videoURL != '0'){
			let ctmVideoBox = $('<div class="ctm-video-box" style="border-bottom-left-radius:0px"><video controls autoplay muted loop><source src="'+chat.videoURL+'" type="video/mp4"></source></video></div>');
			chatingItemMedia.append(ctmVideoBox);
		} else {
			let ctmPicBox = $('<div class="ctm-pic-box" style="border-bottom-left-radius:0px"><img class="zoomable_pic" src="'+chat.pictureURL+'" ></div>');
			chatingItemMedia.append(ctmPicBox);
		}
		othersChatingItems.append(chatingItemMedia);
	}
	if(chat.textContent != ""){
		let profilePicUrl = $(".chating_area #realtop>img").attr("src");
		let chatingItemsMain = $('<div class=\"chating_items_main position-relative d-flex flex-row\"><div style=\"width: 52px;\"></div><img src=\"'+profilePicUrl+'\" ><div class=\"others_chating_content general_content\" style=\"border-bottom-left-radius: 0px;\">'+chat.textContent+'</div></div>');
		othersChatingItems.append(chatingItemsMain);
	}
	let dateStr = getChatDate(chat.releasingTime);
	let chatingItemsDate = $('<div class="chating_items_date"><span>'+dateStr+'</span></div>');
	othersChatingItems.append(chatingItemsDate);
	return othersChatingItems;
}

function ajaxListContact(keyword){
	$.ajax({
		url : "Search/listContact/"+keyword,
		success : function(data){
			let users = data;
			$(".peopleresult_box").empty();
			if (users.length > 0) {
				for( let user of users){
					let html = "<div class=\"peopleresult_items peopleresult_items_hover d-flex flex-row\">\n" +
						"                <div class=\"pri-id d-none\">"+user.id+"</div>" +
						"                <div class=\"peopleresult_items-cover\" onClick=\"event.cancelBubble = true\"></div>\n" +
						"                <img src=\""+user.profilePicUrl+"\" >\n" +
						"                <div>\n" +
						"                    <span class=\"d-block\">"+user.name+"</span>\n" +
						"                    <span>@"+user.email+"</span>\n" +
						"                </div>\n" +
						"                <div class=\"selected-pic-box\">\n" +
						"                    <img src=\"images/icon/right.png\" >\n" +
						"                </div>\n" +
						"            </div>";
					$(".peopleresult_box").append($(html));
				}
			}
			$(".anc-next-btn").removeClass("anc-next-btn-hover");
			$(".anc-next-btn .anb-cover").show();
		}
	});
}

function messageFileUpload(){
	let url;
	$.ajax({
		type : "post",
		url : "File/Messages/uploadFile",
		data : new FormData($("#msgFile-form")[0]),
		contentType: false,
		processData: false,
		async: false,
		success: function(data) {
			url = data;
		},
		error : function(data) {
			alert("上传失败");
		}
	});
	return url;
}

function messageFileUpload2() {
	return new Promise(function(resolve, reject) {
		$.ajax({
			type: "post",
			url: "File/Messages/uploadFile",
			data: new FormData($("#msgFile-form")[0]),
			contentType: false,
			processData: false,
			success: function(data) {
				resolve(data); // 成功时返回 URL
			},
			error: function(error) {
				alert("上传失败");
				console.log("失败原因：" + error);
				reject(error); // 错误时返回错误信息
			}
		});
	});
}

function changeLastCIMRadius(){
	changeCIMRadius($(".chating_items_main").last());
}

function getPresignedUrl(key) {
	let url = `File/Messages/presignedUrl?key=${key}`;
	return new Promise(function(resolve, reject) {
		$.ajax({
			type: "get",
			url: url,
			success: function(data) {
				resolve(data); // 成功时返回 URL
			},
			error: function(error) {
				reject(error); // 错误时返回错误信息
			}
		});
	});
}

async function addChat(textContent,contactId) {
	let url = await messageFileUpload2();
	let pictureURL;
	let videoURL;
	if (url.indexOf("/image/") != -1) {
		pictureURL = url;
		videoURL = "0";
	} else if(url.indexOf("/video/") != -1){
		videoURL = url;
		pictureURL = "0";
	} else {
		videoURL = "0";
		pictureURL = "0";
	}
	var chat = JSON.stringify({
		textContent: textContent,
		pictureURL: pictureURL,
		videoURL: videoURL,
		contactId: contactId,
	});
	$.ajax({
		type : "post",
		url : "Messages/addChat",
		contentType : "application/json",
		data : chat,
		success: async function(e) {
			let chat = e;
			console.log(chat);
			if (chat.videoURL !== "0") {
				chat.videoURL = await getPresignedUrl(chat.videoURL);
			}
			if (chat.pictureURL !== "0") {
				chat.pictureURL = await getPresignedUrl(chat.pictureURL);
			}
			let myChatItem = createMyChat(chat);
			$(".chating_area .chating").append(myChatItem);
			$(".typingarea-cover").hide();
			topContactListItem();
			changeLastCIMRadius();
			flashTypingArea();
			console.log(chat);
		},
		error: function() {
			alert("sendContent:error!");
		}
	});
}

function ajaxAddContact(targetUserId){
	$.ajax({
		url : "Messages/addContact/"+targetUserId,
		success : function(e) {

		}
	});
}


$(document).ready(function(){
	// 通讯录搜索栏颜色
	$("#contact_search_border_input").focus(function(){
		$(".contact_search_border").css("border","#499bea solid 1px");
	});
	$("#contact_search_border_input").blur(function(){
		$(".contact_search_border").css("border","#dce1e1 solid 1px");
	});

	// 通讯录item右边点击蓝色
	$(".contact_list_item").click(function(){
		$(".contact_list_item").css("border-right","none");
		$(".contact_list_item").css("padding-right","16px");
		$(this).css("padding-right","14px");
		$(this).css("border-right","#499bea solid 2px");
	});


	// 实现div变fixed,设置宽度100%不能匹配父元素的问题
	function adjustWidth() {undefined
		var parentwidth = $(".chating_area").width();
		$(".chating_area #realtop").width(parentwidth);
		$(".typing_area").width(parentwidth);
	}
	adjustWidth();
	$(window).resize(
		function() {
			adjustWidth();
	});

	// 调整输入框最大宽度
	function adjustFTWidth() {undefined
		var ftMaxw = $(".typing_input_box").width();
		$(".send-mess-input").css("max-width",ftMaxw);
	}
	adjustFTWidth();
	$(window).resize(function(){
		adjustFTWidth();
	});

	// 调整email的宽度,保证contactlistitem不被撑破
	// $(".contact_list_content>div .contact_item_id").each(function(){
	// 	let divw = $(this).parent().width();
	// 	let span1w = $(this).siblings(".contact_item_name").width();
	// 	let span2w = $(this).siblings(".contact_item_date").width();
	// 	$(this).css("width",divw-span1w-span2w-16);
	// });

	// 保证输入框旁边的图片垂直居中
	// function adjust_tib() {undefined
	//     var h = $(".typing_area").height();
	// 	var result = (h-34)/2;
	// 	$(".typing_img_box").css("margin-top",result);
	// }
	// $(".typing_area").resize(function(){
	// 	alert("h变化");
	// 	adjust_tib();
	// });


	// 发消息处聚焦有输入框边框
	$(".send-mess-input").focus(function(){
		$(".typing_input_box").css("border","#499bea solid 1px");
	});
	$(".send-mess-input").blur(function(){
		$(".typing_input_box").css("border","#d1d9dd solid 1px");
	});


	// 设置contact_list的固定高度
	function adjustcontactlistheight() {undefined
		var wh = $(window).height();
		var h1 = $(".contact_list_box .top").height();
		var h2 = $(".contact_search_box").height();
		var res = wh-h1-h2-24;
		$(".contact_list").css("height",res);
	}
	adjustcontactlistheight();
	$(window).resize(
		function() {
			adjustcontactlistheight();
		});

	// 固定alertModel的高度
	function adjustAlertModelHeight(){
		if($(".alertModel").is(':visible')){
			var wh = $(window).height();
			$(".alertModel").css("height",wh);
		}
	}

	adjustAlertModelHeight();
	adjustchatingheight();
	$(window).resize(
		function() {
			adjustchatingheight();
			adjustAlertModelHeight();
		});

	$(".send-mess-input").keyup(function(){
		adjustchatingheight();
		chatingscrollbottom();
		// 判断一下该不该禁用发送按钮
		toggleSendMessageBtn();
	});

	chatingscrollbottom();

	// 已经没用了,用css解决了
	// 改变聊天记录最大宽度
	// function changechatingwinmaxwidth(){undefined
	//     var w = $(".general_content").css("max-width");
	// 	if(w == "356px"){
	// 		alert("356px");
	// 		$(".general_content").css("max-width","260px");
	// 	} else {
	// 		$(".general_content").css("max-width","356px");
	// 	}
	// }
	// changechatingwinmaxwidth();


	// <<<点击item进入聊天界面
	$(".contact_list_item").click(function(){
		if($(window).width() < 992){
			$(".contact_list_box").removeClass("col-10 col-lg-4 col-xl-4");
			$(".contact_list_box").addClass("d-none d-lg-flex flex-column col-lg-7 col-xl-5");
			$(".chating_area").removeClass("d-none d-lg-flex col-lg-7 col-xl-5");
			$(".chating_area").addClass("col-10 col-lg-4 col-xl-4 d-flex");
			$(".chating_area .gobacktolist").show();
			$(".typing_area").width($(".chating_area").width());
			adjustFTWidth();
			adjustWidth();
			adjustchatingheight();
			chatingscrollbottom();
		}
	});

	function cssbeforeclick(){
		$(".contact_list_box").removeClass("d-none d-lg-flex flex-column col-lg-7 col-xl-5");
		$(".contact_list_box").addClass("col-10 col-lg-4 col-xl-4");
		$(".chating_area").removeClass("col-10 col-lg-4 col-xl-4 d-flex");
		$(".chating_area").addClass("d-none d-lg-flex col-lg-7 col-xl-5");
		$(".typing_area").width($(".chating_area").width());
		$(".chating_area .gobacktolist").hide();
	}
	$(window).resize(function(){
		if($(window).width() >= 992){
			cssbeforeclick();
		}
	});
	$(".chating_area .gobacktolist").click(function(){
		cssbeforeclick();
	});
	// 点击item进入聊天界面>>>


	// 点击出现新增联系人窗口
	$(".add_contact_bt").click(function(){
		$("#addnewcontact_box").show();
	});

	// 点击让新增联系人窗口消失
	$(document).click(function(event){
		var t=$(event.target);
		if($("#addnewcontact_box").is(':visible')){
			var spring = "#addnewcontact_box";
			obj = $(event.target);
			if (obj.is(spring)) {
				$("#addnewcontact_box").hide();
			} else {

			}
		}
	});



	// $(window).keydown(function(e){
	// 	var key = window.event?e.keyCode:e.which;
	// 	if(key.toString() == "13"){
	// 		insertHtml("<br>");
	// 		return false;
	// 	}
	// });

	$(".chating_items_main").each(function(){
		changeCIMRadius(this);
	});

	function toggleVideo($video) {
		let video = $video[0];
		if (video.paused) { //如果已暂停则播放
			$('.video-play').hide();
			video.play(); //播放控制
		} else { // 已播放点击则暂停
			$('.video-play').show();
			video.pause(); //暂停控制
		}
	}

	$(".ctm-video-box").click(function(){
		let video = $(this).children("video");
		toggleVideo(video);
	});

	function reLoadSource(img){
		let d = new Date;
		src = img.attr("src");
		img.attr("src",src+"?timestamp="+d.getTime());
	}
	// 视频的完全没用
	function reLoadVideo(video){
		let d = new Date;
		src = video.children("source").attr("src");
		alert(src);
	}

	$(".typing-img-show img").on("load",function(){
		let w = $(this).width();
		let h = $(this).height();
		if(h/w < 1){
			$(this).css("width","auto");
			$(this).css("height","150px");
		} else {
			$(this).css("height","auto");
			$(this).css("width","150px");
		}
	});
	// reLoadSource($(".typing-img-show img"));

	$(".tis-area .cancel-btn").click(function(){
		$(".tis-area").addClass("d-none");
		$(".typing-video-show").addClass("d-none");
		$(".typing-img-show").addClass("d-none");
		$("#msg-file-input").val("");
		// 调整一下聊天框的高度
		adjustchatingheight();
		chatingscrollbottom();
		// 判断一下该不该禁用发送按钮
		toggleSendMessageBtn();
	});

	$(".send-img-func").click(function(){
		$("#msg-file-input").click();
	});

	$("#msg-file-input").change(function(){
		let progress = $(this).siblings(".ta_uplaod_bar");
		progress.css("display","flex");
		var ofReader = new FileReader();
		var file = document.getElementById('msg-file-input').files[0];
		var total = file.size;
		let isImg = file.type.startsWith("image/");
		ofReader.readAsDataURL(file);
		ofReader.onloadend = function(ofrEvent){
			var src = ofrEvent.target.result;
			$(".tis-area").removeClass("d-none");
			toggleSendMessageBtn();
			if(isImg){
				$(".typing-img-show").removeClass("d-none");
				$(".typing-video-show").addClass("d-none");
				$(".typing-img-show img").attr("src",src);
				// reLoadSource($(".typing-img-show img"));
			} else {
				$(".typing-video-show").removeClass("d-none");
				$(".typing-img-show").addClass("d-none");
				$(".typing-video-show video source").attr("src",src);
				$(".typing-video-show video")[0].load();
			}
			// 调整一下聊天框的高度
			adjustchatingheight();
			chatingscrollbottom();
		}
		ofReader.onprogress = function(e) {
			progress.children("div").css("width",(e.loaded/total)*100+"%");
		}

		ofReader.onload = function() {
			setTimeout(function(){
				progress.css("display","none");
			},100);
		}
	});

	$(".searchnewcontact input").focus(function(){
		$(this).siblings("img").attr("src","images/icon/search_focus.png");
	});
	$(".searchnewcontact input").blur(function(){
		$(this).siblings("img").attr("src","images/icon/search.png");
	});

	var sncTimeout;
	$(".searchnewcontact input").keyup(function(e) {
		clearTimeout(sncTimeout);
		let keyword = $(this).val();
		sncTimeout = setTimeout(function (){
			ajaxListContact(keyword);
		},300);
	});

	$(".searchnewcontact input").focus(function(){
		$(this).siblings("img").attr("src","images/icon/search_focus.png");
	});
	$(".searchnewcontact input").blur(function(){
		$(this).siblings("img").attr("src","images/icon/search.png");
	});


	$(".peopleresult_box").on("click",".peopleresult_items",function (){
		if(!$(this).children(".selected-pic-box").is(':visible')){
			$(".peopleresult_box").children(".peopleresult_items").each(function(){
				$(this).children(".peopleresult_items-cover").show();
				$(this).removeClass("peopleresult_items_hover");
				$(this).children(".selected-pic-box").hide();
			});

			$(this).children(".peopleresult_items-cover").hide();
			$(this).addClass("peopleresult_items_hover");
			$(this).children(".selected-pic-box").show();

			$(".anc-next-btn").addClass("anc-next-btn-hover");
			$(".anc-next-btn .anb-cover").hide();
		} else {
			$(".peopleresult_box").children(".peopleresult_items").each(function(){
				$(this).children(".peopleresult_items-cover").hide();
				$(this).addClass("peopleresult_items_hover");
				$(this).children(".selected-pic-box").hide();
			});

			$(".anc-next-btn").removeClass("anc-next-btn-hover");
			$(".anc-next-btn .anb-cover").show();
		}
	});


	$(".anc-next-btn").click(function() {
		let targetUserId = "";
		$(".peopleresult_box .peopleresult_items").each(function (){
			if ($(this).children(".selected-pic-box").is(':visible')){
				targetUserId = targetUserId +","+ $(this).children(".pri-id").text();
			}
		});
		if (targetUserId.startsWith(",")){
			targetUserId = targetUserId.substring(1);
		}
		ajaxAddContact(targetUserId);
		let myid = $(".fakeSession .fs-id").text();
		$(window).attr('location','Messages/'+myid+"-"+targetUserId);
	});


	function toggleSendMessageBtn(){
		if($("#send-message-btn .btn-cover").is(':visible')){
			if($(".tis-area").is(':visible') || $(".send-mess-input").text() != ''){
				$("#send-message-btn .btn-cover").hide();
				$("#send-message-btn").addClass("typing_img_box-hover");
			}
		} else {
			if(!$(".tis-area").is(':visible') && $(".send-mess-input").text() == ''){
				$("#send-message-btn .btn-cover").show();
				$("#send-message-btn").removeClass("typing_img_box-hover");
			}
		}
	}

	$("#send-message-btn").click(function(){
		$(".typingarea-cover").show();
		let textContent = $("#div-editable").html();
		let contactId = $("#currentChat-id").text();
		addChat(textContent,contactId);
	});


	// sse服务器端轮询
	if(!!window.EventSource){
		let senderId = $("#currentChatUser-id").text();
		let receiverId = $(".fakeSession .fs-id").text();
		if (senderId != "" && receiverId != "" ){
			// If a connection exists, close it.
			if (source) {
				source.close();
			}

			// var source = new EventSource("Messages/pushImprove");
			var source = new EventSource("Messages/msgReceivedListener1/"+senderId+"/"+receiverId);

			source.addEventListener('message', function(e) {
				if (e.data != ""){
					let otherChats =JSON.parse(e.data);
					for (let chat of otherChats){
						let chatDom = createOtherChat(chat);
						$(".chating").append(chatDom);
						topContactListItem();
						changeLastCIMRadius();
						chatingscrollbottom();
						adjustchatingheight();
					}
				}
			});

			source.addEventListener('open', function(e) {
				console.log("Connected");
			}, false);

			source.addEventListener('error', function(e) {
				if (e.target.readyState == EventSource.CLOSED) {
					console.log('Disconnected');
				} else if (e.target.readyState == EventSource.CONNECTING) {
					console.log('controller执行return');
					source.close();
				}
			}, false);

		} else {
		    console.log("运行错误！");
		}
	} else {
		console.log('您的浏览器不支持SSE');
	}


});