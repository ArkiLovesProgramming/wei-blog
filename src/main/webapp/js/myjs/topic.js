// function ajaxFollowTopic(topicId){
// 	$.ajax({
// 		url : "Topic/followTopic/"+topicId,
// 		success : function(data){
//
// 		}
// 	});
// }
//
// function ajaxUnFollowTopic(topicId){
// 	$.ajax({
// 		url : "Topic/unfollowTopic/"+topicId,
// 		success : function(data){
//
// 		}
// 	});
// }
// 移植到了all

$(document).ready(function(){

	$(".FollowBtn").click(function(){
		var span = $(this).children("span");
		let span2 = $(".top-FollowBtn").children("span");
		let detailId = $(".detailTopic-id").text();
		if(span.text()=="Follow"){
			ajaxFollowTopic(detailId);

			span2.text("Unfollow");
			$(".top-FollowBtn").addClass("top-FollowBtn-clicked");

			span.text("Unfollow");
			$(".cancelFollowBtn").parent().addClass("d-none");
			$(this).parent().removeClass("col-8");
			$(this).parent().removeClass("col-sm-6");
			$(this).parent().addClass("col-12");
			$(this).addClass("FollowBtnClicked");
		} else if(span.text()=="Following" || span.text()=="Unfollow") {
			ajaxUnFollowTopic(detailId);

			span2.text("Follow Topic");
			$(".top-FollowBtn").removeClass("top-FollowBtn-clicked");

			span.text("Follow");
			$(".cancelFollowBtn").parent().removeClass("d-none");
			$(this).parent().addClass("col-8");
			$(this).parent().addClass("col-sm-6");
			$(this).parent().removeClass("col-12");
			$(this).removeClass("FollowBtnClicked");
		}
	});

	$(".top-FollowBtn").click(function(){
		let span = $(this).children("span");
		var span2 = $(".FollowBtn").children("span");
		let detailId = $(".detailTopic-id").text();
		if (span.text() == "Follow Topic") {
			ajaxFollowTopic(detailId);
			span.text("Unfollow");
			$(this).addClass("top-FollowBtn-clicked");
			span2.text("Unfollow");
			$(".cancelFollowBtn").parent().addClass("d-none");
			$(".FollowBtn").parent().removeClass("col-8");
			$(".FollowBtn").parent().removeClass("col-sm-6");
			$(".FollowBtn").parent().addClass("col-12");
			$(".FollowBtn").addClass("FollowBtnClicked");
		} else {
			ajaxUnFollowTopic(detailId);
			span.text("Follow Topic");
			$(this).removeClass("top-FollowBtn-clicked");
			span2.text("Follow");
			$(".cancelFollowBtn").parent().removeClass("d-none");
			$(".FollowBtn").parent().addClass("col-8");
			$(".FollowBtn").parent().addClass("col-sm-6");
			$(".FollowBtn").parent().removeClass("col-12");
			$(".FollowBtn").removeClass("FollowBtnClicked");
		}

	});
	$(".top-FollowBtn").hover(function() {
		if($(this).hasClass("top-FollowBtn-clicked")){
			$(this).children("span").text("Unfollow");
		}
	},function() {
		if($(this).hasClass("top-FollowBtn-clicked")){
			$(this).children("span").text("Following");
		}
	});


	$(".FollowBtn").hover(function(){
		if($(this).hasClass("FollowBtnClicked")){
			$(this).children("span").text("Unfollow");
		}
	},function(){
		if($(this).hasClass("FollowBtnClicked")){
			$(this).children("span").text("Following");
		}
	});

	// 滑动出现follow topic
	$(window).scroll(function(){
		var btop = $(window).scrollTop();
		if(btop >= 190 ){
			setTimeout(function () {
				$(".top-FollowBtn").fadeIn(50);
				$(".ct-title span").text($(".topicIntroduction-box .tib-title").text());
			}, 300);
		} else if(btop < 190 ) {
			setTimeout(function () {
				$(".top-FollowBtn").fadeOut(50);
				$(".ct-title span").text("Topic");
			}, 300);
		}
	});
});