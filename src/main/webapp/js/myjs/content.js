// 包含了很多关于输入的js
$(document).ready(function(){

	var firstFileLength;
	var secondFileLength;
	var totalLength;

	function getPicNum(){
		firstFileLength = $("#rbb-file")[0].files.length;
		secondFileLength = $("#rbb-file-second")[0].files.length;
		totalLength = firstFileLength + secondFileLength;
	}

	function removeAllPicFra(){
		$(".pff").addClass("d-none");
		$(".pfs").addClass("d-none");
	}

	function openFirstPic(){
		$(".pff").removeClass("d-none");
	}
	function openSecondPic(){
		$(".pfs").removeClass("d-none");
	}

	function removeAllWp(){
		$('.double-ul-picf').removeClass("wp");
		$('.double-ul-pics').removeClass("wp");
	}

	// 点击判断该让哪个input打开的逻辑
	$(".send-image-func").click(function(){
		var isEmptyFile1 = $("#rbb-file")[0].files[0] == null;
		var isEmptyFile2 = $("#rbb-file-second")[0].files[0] == null;
		if(isEmptyFile1 && isEmptyFile2){
			$("#rbb-file").click();
		} else if(!isEmptyFile1 && isEmptyFile2){
			$("#rbb-file-second").click();
		} else if(isEmptyFile1 && !isEmptyFile2){
			$("#rbb-file").click();
		} else if(!isEmptyFile1 && !isEmptyFile2){
			myAlert("Please choose either 1 GIF or up to 2 photos.");
		}
	});

	$("#rbb-file").change(function(){
		forbidSbfItem($(".send-video-func"));
		getPicNum();
		if(totalLength == 1){
			openFirstPic();
			var ofReader = new FileReader();
			var file = document.getElementById('rbb-file').files[0];
			ofReader.readAsDataURL(file);
			ofReader.onloadend = function(ofrEvent){
				var src = ofrEvent.target.result;
				$('.single-ul-pic').attr("src",src);
			}
		} else if(totalLength == 2){
			originalSingleSrc = $(".single-ul-pic").attr("src");
			removeAllPicFra();
			openSecondPic();

			// 第一个view
			var ofReader = new FileReader();
			var file = document.getElementById('rbb-file').files[0];
			ofReader.readAsDataURL(file);
			ofReader.onloadend = function(ofrEvent){
				var src = ofrEvent.target.result;
				var dom = $('.double-ul-picf');
				dom.attr("src",src);
			}

			//第二个
			var sdom = $('.double-ul-pics');
			sdom.attr("src",originalSingleSrc);
		}
	});



	$("#rbb-file-second").change(function(){
		getPicNum();
		if(totalLength == 2){
			originalSingleSrc = $(".single-ul-pic").attr("src");
			removeAllPicFra();
			openSecondPic();


			// 第一个view
			var fdom = $('.double-ul-picf');
			fdom.attr("src",originalSingleSrc);

			//第二个view
			var ofReader = new FileReader();
			var file = document.getElementById('rbb-file-second').files[0];
			ofReader.readAsDataURL(file);
			ofReader.onloadend = function(ofrEvent){
				var src = ofrEvent.target.result;
				var dom = $('.double-ul-pics');
				dom.attr("src",src);
			}
		}
	});


	// img加载的时候判断一下长宽
	$(function(){
		$(".double-ul-picf").on("load",function(){ //核心
			var w = $(this).width();
			var h = $(this).height();
			if(h/w < 1.15){
				$(this).removeClass("hp");
				$(this).addClass("wp");
			} else {
				$(this).removeClass("wp");
				$(this).addClass("hp");
			}
		});
	});


	$(function(){
		$(".double-ul-pics").on("load",function(){ //核心
			var w = $(this).width();
			var h = $(this).height();
			if(h/w < 1.15){
				$(this).removeClass("hp");
				$(this).addClass("wp");
			} else {
				$(this).removeClass("wp");
				$(this).addClass("hp");
			}
		});
	});
	// img加载的时候判断一下长宽


	$(".cancel-upload-file").click(function(){
		var isFirstPic = $(this).siblings("img").hasClass("double-ul-picf");
		var isSecondPic = $(this).siblings("img").hasClass("double-ul-pics");
		var isSinglePic = $(this).siblings("img").hasClass("single-ul-pic");
		var isVideo = $(this).siblings("video").length == 1;
		if(isFirstPic){
			$("#rbb-file").val("");
			sPicSrc = $(".double-ul-pics").attr("src");
			removeAllPicFra();
			openFirstPic();
			$('.single-ul-pic').attr("src",sPicSrc);
		} else if (isSecondPic){
			$("#rbb-file-second").val("");
			fPicSrc = $(".double-ul-picf").attr("src");
			removeAllPicFra();
			openFirstPic();
			$('.single-ul-pic').attr("src",fPicSrc);
		} else if (isSinglePic){
			$("#rbb-file-second").val("");
			$("#rbb-file").val("");
			removeAllPicFra();
			allowSbfItem($(".send-video-func"));
		} else if (isVideo){
			closeVideoFrame();
			$("#rbb-video").val("");
			allowSbfItem($(".send-image-func"));
		}

	});

	// 在idea里已经移植到sendContent.js
	// content页面点击reply点击input submit，如果为空报错
	// $(".rp_button").click(function(){
	// 	getPicNum();
	// 	let spring = '<div class="d-flex flex-column"><span></span></div>';
	// 	if($("#div-editable").html() == spring && totalLength == 0){
	// 		myAlert("The reply you typed is empty.");
	// 	} else {
	// 		// $("#rbb-submit").click();
	// 	}
	// });
	// home页面发布自己的内容,空的话报错
	// $(".scb-submit-border").click(function(){
	// 	getPicNum();
	// 	let spring = '<div class="d-flex flex-column"><span></span></div>';
	// 	if($("#div-editable").html() == spring && totalLength == 0){
	// 		myAlert("The reply you typed is empty.");
	// 	} else {
	// 		// $("#rbb-submit").click();
	// 	}
	// });

	// 内容的点赞信息 content.jsp detailContent内容的
	$(".parent-content-func-box").children(".likepicbox").click(function(){
		// alert();
		var num = stringToNum($("#content-liked-num").text());
		var likePic = $(this).children(".likepic");
		var src =likePic.attr("src");
		let contentId = $(".detailContent-id").text();
		let userId = $(".fs-id").text();
		if(src == "images/icon/liked.png"){//不喜欢
			$("#content-liked-num").text(numToString(--num));
			downSlide($("#content-liked-num"),0);
			$(this).children(".likepic").attr("src","images/icon/afterlike.png");
			unlikeContentAjax(contentId,userId);
		} else if(src == "images/icon/afterlike.png") {//喜欢
			$("#content-liked-num").text(numToString(++num));
			upSlide($("#content-liked-num"),0);
			$(this).children(".likepic").attr("src","images/icon/liked.png");
			likeContentAjax(contentId,userId);
		}

	});

	$("#div-editable").click(function(){
		$(this).find("span:first-child").focus();
	});

	// 如果里面没有div先加一个div,保证都有div
	$("#div-editable").keydown(function(e){
		var divNum = $(this).children("div").length;
		var spanNum = $(this).children("div").children("span").length;
		console.log(divNum+" "+spanNum);
		// alert("divNum==>"+divNum+"  spanNum==>"+spanNum);
		if( divNum == 0){
			// alert("");
			var html = $(this).html();
			// alert(html);
			$(this).html("");
			var div = $("<div class='d-flex flex-column'></div>");
			var span =$("<span></span>");
			span.innerHTML = html;
			div.append(span);
			$(this).append(div);
		}
	});

	var divediJudge = 0;
	$("#div-editable").keydown(function(e){
		if(e.keyCode == 8){
			let text = $(this).text();
			console.log(text.length);
			if(text.length == 1){
				divediJudge = 1;
			} else if(text.length == 0){
				return false;
			}
		}
	}).keyup(function(){
		if(divediJudge == 1){
			$(this).empty();
			var div = $("<div class='d-flex flex-column'></div>");
			var span =$("<span></span>");
			div.append(span);
			$(this).append(div);
			divediJudge = 0;
		}
		if($(this).text() == "" && $(this).find("br").length == 1){
			$(this).find("br").remove();
		}
	});


	// 截获粘贴事件,然后保证粘贴入内的文件的正确性
	$("#div-editable").on("paste",function(e){
		console.log("截获粘贴事件");
		var pastedData = e.originalEvent.clipboardData.getData('text');
		// $(this).find("span:last-child").append(pastedData);
		if($(this).text() == ""){
			$(this).find("span").eq(0).focus();
		}
		let $dom = $("<span></span>");
		let dom = $dom.get(0);
		// let tempNode = document.createHTMLDocument();
		dom.innerText = pastedData;
		let selection = getSelection();
		if(lastRange){
			selection.removeAllRanges();
			selection.addRange(lastRange);
		}
		let range = selection.getRangeAt(0);
		range.insertNode(dom);
		range.collapse(false);
		lastRange = range;

		return false;
	});

	// 禁用sbf-item
	function forbidSbfItem(dom){
		dom.children(".sbf-item-cover").show();
		dom.removeClass("sbfi-hover");
		dom.children(".rpb-cover").show();
		dom.removeClass("rpb-hover");
	}
	// 启用sbf-item
	function allowSbfItem(dom){
		dom.children(".sbf-item-cover").hide();
		dom.addClass("sbfi-hover");
		dom.children(".rpb-cover").hide();
		dom.addClass("rpb-hover");
	}

	// 去焦点时候,复原
	$("#div-editable").blur(function(){
		var divNum = $(this).children("div").length;
		var spanNum = $(this).children("div").children("span").length;
		// alert("divNum==>"+divNum+"  spanNum==>"+spanNum);
		if( divNum == 0){
			// alert("");
			var html = $(this).html();
			// alert(html);
			$(this).html("");
			var div = $("<div class='d-flex flex-column'></div>");
			var span =$("<span></span>");
			span.innerHTML = html;
			div.append(span);
			$(this).append(div);
		}
	});


	// 视频框架
	function openVideoFrame(){
		$(".send-video-box").removeClass("d-none");
		$(".uploaded-video-box").removeClass("d-none");
	}
	function closeVideoFrame(){
		$(".send-video-box").addClass("d-none");
		$(".uploaded-video-box").addClass("d-none");
	}

	$(".send-video-func").click(function(){
		$("#rbb-video").click();
	});
	$("#rbb-video").change(function(){
		openVideoFrame();
		var ofReader = new FileReader();
		var file = document.getElementById('rbb-video').files[0];
		ofReader.readAsDataURL(file);
		ofReader.onloadend = function(ofrEvent){
			var src = ofrEvent.target.result;
			$(".send-video-frame video source").attr("src",src);
			$(".send-video-frame video")[0].load();
		}
		// 禁用掉发送图片的按钮
		forbidSbfItem($(".send-image-func"));
	});


});