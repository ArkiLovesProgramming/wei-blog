function ajaxLoadParentCat(){
	let topicList;
	$.ajax({
		url : "Topic/getParentTopic",
		async : false,
		success : function (data) {
			topicList = data;
		}
	});
	return topicList;
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

$(document).ready(function(){
	ajaxLoadParentCat();
	
	// 注入蓝色方框类别
	function injectionCategories(){
		let topicList = ajaxLoadParentCat();
		for (let topic of topicList){
			let div = $("<div class='categories-item-box col-6 col-sm-4'><a href=\"Topic/detailTopic/"+topic.id+"\" class='d-block categories-item'><span>"+topic.name+"</span></a></div>");
			$(".allcategories .row").append(div);
		}
	}
	injectionCategories();

	// // 注入蓝色方框类别
	// function injectionCategories(names){
	// 	for(let i=1;i<names.length;i++){
	// 		var div = $("<div class='categories-item-box col-6 col-sm-4'><a href='topic.html' class='d-block categories-item'><span>"+names[i]+"</span></a></div>");
	// 		$(".allcategories .row").append(div);
	// 	}
	// }
	// var names = ["Fashion & beauty","Arts & Culture","Outdoors","Business & finance","Travel","Gaming","Fitness","Outdoors","Business & finance","Travel","Gaming","Fitness","Gaming","Fitness","Outdoors","Outdoors"];
	// injectionCategories(names);

	$(".ac-show-more").click(function(){
		var row = $(".allcategories .row");
		if(row.css("height") == "352px"){
			$(this).hide();
			row.animate(
			{
				height:'+=88px'
			},"fast");
		} else {
			row.animate(
			{
				height:'+=176px'
			},"fast");
		}
	});
	
	$(".detailcategorie-item").click(function(){
		let topicId = $(this).children(".dci-id").text();
		if($(this).css("color") == 'rgb(255, 255, 255)'){
			$(".dci-id").each(function() {
				if ($(this).text() == topicId){
					$(this).parent().css("background-color","white");
					$(this).parent().css("border-color","#d1d9dd");
					$(this).parent().css("color","black");
					$(this).parent().children("img").attr("src","images/icon/add.png");
				}
			});
			ajaxUnFollowTopic(topicId);
		} else {
			$(".dci-id").each(function() {
				if ($(this).text() == topicId){
					$(this).parent().css("background-color","#499bea");
					$(this).parent().css("border-color","#499bea");
					$(this).parent().css("color","white");
					$(this).parent().children("img").attr("src","images/icon/right.png");
				}
			});
			ajaxFollowTopic(topicId);
		}
		
	});
	$(".detailcategorie-item").hover(function(){
		if($(this).css("color") == 'rgb(255, 255, 255)'){
			$(this).css("background-color","#428cd2");
		}
	},function(){
		if($(this).css("color") == 'rgb(255, 255, 255)'){
			$(this).css("background-color","#499bea");
		}
	});
});