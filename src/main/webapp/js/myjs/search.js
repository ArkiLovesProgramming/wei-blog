function changeSearchType(type,keyword){
	$(window).attr('location','Search/'+type+'/'+keyword);
}


$(document).ready(function(){
	$(".search-func-area .sfa-item").click(function(){
		$(".search-func-area .sfa-item").children("span").removeClass("si-selected");
		$(this).children("span").addClass("si-selected");

		let type = $(this).children("span").text();
		let keyword = $(".fakeRequest .keyword").text();
		changeSearchType(type,keyword);
	});

	// 有和关键词一样的语句用粗体
	$(".content_card_total .text_content").each(function (){
		let html = $(this).html();
		let keyword = $(".fakeRequest .keyword").text();
		let html1 = getBText(keyword,html);
		console.log(html);
		console.log(html1);
		$(this).html(html1);
	});

	function getBText(keyword,html) {
		// var keyword = "自己评论自己哈哈!aaa a there apple测试";
		var htmlReg = /(<([^>]+)>)/ig;
		var chiReg = /[\u4e00-\u9fa5]/g;
		var notReg = /[\~|\`|\!|\@|\#|\$|\%|\^|\&|\*|\(|\)|\-|\_|\+|\=|\||\\|\[|\]|\{|\}|\;|\:|\"|\'|\,|\<|\.|\>|\/|\?/\，/\。/\；/\：/\“/\”/\》/\《/\|/\{/\}/\、/\!/\~/\`]/g;
		var mutiSpace = /\s+/g;
		var mutiDash = /-+/g;
		keyword = keyword.replace(notReg," ");

		var chiList = new Array();
		console.log("test==>"+keyword.match(chiReg));
		if (keyword.match(chiReg)!=null){
			chiList = keyword.match(chiReg);
		}

		var english = keyword.replace(chiReg, " ").replaceAll(mutiSpace," ").replace(/(^\s*)|(\s*$)/g, "");
		var wordList = new Array();
		if (english.length>0){
			wordList = english.split(" ");
		}
		console.log(chiList+" === "+english+" === "+wordList);
		console.log(chiList.length+" === "+english.length+" === "+wordList.length);		// var html = "<div class=\"d-flex flex-column\"><span>测试！there is apple<img src=\"images/emojis/emoji_sprite_03.gif\" class=\"emoji-item\">哈哈哈哈</span></div>";
		var thishtml = html;
		thishtml = delPreSpace(thishtml);
		thishtml = thishtml.replace(htmlReg,"-");
		thishtml = thishtml.replace(mutiDash,"-");
		thishtml = thishtml.slice(1,-1);
		var conlist = thishtml.split("-");
		for (var con of conlist){
			var thiscon = con;
			if(chiList.length > 0){
				for (var str of chiList){
					if (thiscon.indexOf(str)!=-1){
						console.log("str==>"+str);
						console.log("转化前==>"+thiscon);
						var bStr = "<b>".concat(str,"</b>");
						console.log("bStr==>"+bStr);
						thiscon = thiscon.replace(str,bStr);
						console.log("转化后==>"+thiscon);
					}
				}
			}
			if (wordList.length > 0){
				for (var str2 of wordList){
					console.log("!!!!!!");
					if (thiscon.indexOf(str2)!=-1){
						var bStr2 = "<b>"+str2+"</b>";
						thiscon = thiscon.replace(str2,bStr2);
					}
				}
			}
			html = html.replace(con,thiscon);
		}
		return html;
		console.log(html);
		console.log(conlist);
	}
	// let html = "<div class=\"d-flex flex-column\"><span>测试！<img src=\"images/emojis/emoji_sprite_03.gif\" class=\"emoji-item\"></span></div>";
	// let keyword = "测试";
	// let html1 = getBText(keyword,html);
	// console.log(html);
	// console.log(html1);




});