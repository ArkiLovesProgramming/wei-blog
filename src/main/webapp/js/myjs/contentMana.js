function content(id,textContent,pictureURL, videoURL,authorId,topicIds, likeNum,likeIds,commentNum, commentIds,bookmarkNum,bookmarkIds, transmitNum,transmitIds,level,parentId, releasingTime,childContentId,playNum,deleted,visible) {
    this.id = id;
    this.textContent = textContent;
    this.pictureURL = pictureURL;
    this.videoURL = videoURL;
    this.authorId = authorId;
    this.topicIds = topicIds;
    this.likeNum = likeNum;
    this.likeIds = likeIds;
    this.commentNum = commentNum;
    this.commentIds = commentIds;
    this.bookmarkNum = bookmarkNum;
    this.bookmarkIds = bookmarkIds;
    this.transmitNum = transmitNum;
    this.transmitIds = transmitIds;
    this.level = level;
    this.parentId = parentId;
    this.releasingTime = releasingTime;
    this.childContentId = childContentId;
    this.playNum = playNum;
    this.deleted = deleted;
    this.visible = visible;
}

function user(id,name,gender,password,accountId,email,region,birthday,
              profilePicUrl,topicIds,signature,followingNum,followerIds,
              likedContentIds,bookmarkContentIds,creatingTime){
    this.id = id;
    this.name = name;
    this.gender = gender;
    this.password = password;
    this.accountId = accountId;
    this.email = email;
    this.region = region;
    this.birthday = birthday;
    this.profilePicUrl = profilePicUrl;
    this.topicIds = topicIds;
    this.signature = signature;
    this.followingNum = followingNum;
    this.followerIds = followerIds;
    this.likedContentIds = likedContentIds;
    this.bookmarkContentIds = bookmarkContentIds;
    this.creatingTime = creatingTime;
}

function formatDoubleImage(obj){
    let h = $(obj).height();
    let w = $(obj).width();
    if(h/w < 1.127){
        type = "wp";
        $(obj).addClass(type);
    } else {
        type = "hp";
        $(obj).addClass(type);
    }
}

function formatSingleImage(obj){
    var w = $(obj).width();
    var h = $(obj).height();
    if(h/w < 1.1){
        $(obj).parent().css("max-width","100%");
    } else {

    }
}

function addPreZero(num){
    if(num<10){
        return '0'+num;
    }
}

function getMyDate(ds){
    // let ds = "2022/03/21 01/38";
    let datel2 = ds.split(" ");
    let secondl = datel2[1].replace("/",":");
    secondl = secondl+":00";
    let now = new Date();
    var d = datel2[0]+' '+secondl;
    let rt = new Date(d);
    let interval = now.getTime() - rt.getTime();
    // let minute = addPreZero(interval/1000/60);
    let minute = interval/1000/60;
    let hour = minute/60;
    let weekday = ["Mon","Tue","Wed","Thur","Fri","Sat","Sun"];
    let week = weekday[rt.getDay()-1];
    if(minute < 60){
        return parseInt(minute)+'m';
    } else if(minute >= 60 && (minute/60) < 24){
        return parseInt(hour)+'h';
    } else if((minute/60) >= 24 && (minute/60/24) < 7){
        return week;
    } else if((minute/60/24) >= 7){
        let month = rt.toDateString().split(" ")[1];
        return month;
    }
}

function getContentHtml(content,user) {
    if (user.profilePicUrl == ""){
        user.profilePicUrl = "images/icon/touxiang.png";
    }

    let rt2 = getMyDate(content.releasingTime);

    var content_card_total = $("<div class=\"content_card_total\"></div>");
    var content_card_id = $("<div class=\"content-card-id d-none\">"+content.id+"</div>");
    var content_card = $("<div class=\"content_card d-flex flex-row\"></div>");
    var content_profile_picture_box = $("<div class=\"content_profile_picture_box position-relative\"><img class=\"content_profile_picture\" src=\""+user.profilePicUrl+"\"><div class=\"suspended_profile d-none\"></div></div>");
    var content_card_info_box = $("<div class=\"content_card_info_box\"></div>");
    var content_card_info = $("<div class=\"content_card_info\"><span><span>"+user.name+"</span><span class=\"ml-1 d-inline-block\">"+user.email+"</span> · <span>"+rt2+"</span></span><div class=\"content_card_more\">...</div><div class=\"suspended_card_more shadow\"><a href=\"\"><img src=\"images/icon/follow.png\" ><span>关注Mu Rui Qing🎭</span></a><a href=\"\"><img src=\"images/icon/report.png\" ><span>删除内容</span></a><a href=\"\"><img src=\"images/icon/report.png\" ><span>举报内容</span></a></div></div>");
    var actual_content = $("<div class=\"actual_content\"></div>");
    var text_content = $("<div class=\"text_content\">"+content.textContent+"</div>");
    var content_card_bottom = $("<div class=\"content_card_bottom d-flex flex-row\">\n" +
        "                    <div class=\"flex-fill d-flex flex-row\">\n" +
        "                        <div class=\"commentpicbox\">\n" +
        "                            <img class=\"commentpic\" src=\"images/icon/comment.png\" >\n" +
        "                        </div>\n" +
        "                        <div class=\"d-inline-block\">\n" +
        "                            <span>"+content.commentNum+"</span>\n" +
        "                        </div>\n" +
        "                    </div>\n" +
        "                    <div class=\"flex-fill d-flex flex-row\">\n" +
        "                        <div class=\"transmitpicbox\">\n" +
        "                            <img class=\"transmitpic\" src=\"images/icon/transmit.png\" >\n" +
        "                        </div>\n" +
        "                        <!-- 转发suspend 要给父元素加relative -->\n" +
        "                        <div class=\"suspended_card_more shadow\">\n" +
        "                            <a href=\"\"><img src=\"images/icon/transmit.png\" ><span>ReWEISend</span></a>\n" +
        "                        </div>\n" +
        "                        <div class=\"d-inline-block\">\n" +
        "                            <span>"+content.transmitNum+"</span>\n" +
        "                        </div>\n" +
        "                    </div>\n" +
        "\n" +
        "                    <div class=\"flex-fill d-flex flex-row\">\n" +
        "                        <div class=\"likepicbox\">\n" +
        "                            <img class=\"likepic\" src=\"images/icon/like.png\" >\n" +
        "                        </div>\n" +
        "                        <div class=\"d-inline-block\">\n" +
        "                            <span>"+content.likeNum+"</span>\n" +
        "                        </div>\n" +
        "                    </div>\n" +
        "\n" +
        "                    <div class=\"flex-fill d-flex flex-row\">\n" +
        "                        <div class=\"forwardingpicbox\">\n" +
        "                            <img class=\"forwardingpic\" src=\"images/icon/forwarding.png\">\n" +
        "                        </div>\n" +
        "                        <!-- 转发suspend 要给父元素加relative -->\n" +
        "                        <div class=\"suspended_card_more shadow\">\n" +
        "                            <a href=\"\"><img src=\"images/icon/transmit.png\" ><span>ReWEISend</span></a>\n" +
        "                        </div>\n" +
        "                        <div class=\"d-inline-block\">\n" +
        "                            <span>"+content.bookmarkNum+"</span>\n" +
        "                        </div>\n" +
        "                    </div>\n" +
        "\n" +
        "                </div>");

    if (content.pictureURL != '0') {
        if(content.pictureURL.indexOf(',') != -1){
            var pics = content.pictureURL.split(",");
            var pic1 = pics[0];
            var pic2 = pics[1];

            let s1 = "<div class=\"actual_content_picture\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<div class=\"double_picture_frame aspectration\" data-ratio=\"16:9\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<div class=\"d-flex flex-row\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t\t<div class=\"first_picture flex-fill\">";
            let m1 = "<img onload=\"formatDoubleImage(this)\" src=\"" + pic1 + "\" class=\"zoomable_pic\" >";
            let s2 = "\n" +
                "\t\t\t\t\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\t\t\t\t\t\t\t<div class=\"second_picture flex-fill\">";
            let m2 = "<img onload=\"formatDoubleImage(this)\" src=\"" + pic2 + "\" class=\"zoomable_pic\">";
            let s3 = "\n" +
                "\t\t\t\t\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\t\t\t\t</div>";
            let doubleFrameHtml = s1 + m1 + s2 + m2 + s3;

            var doubleFrame = $(doubleFrameHtml);
        } else if (content.pictureURL.indexOf(',') == -1){
            let picUrl = content.pictureURL;
            let actual_content_picture = $("<div class=\"actual_content_picture\"></div>");
            let content_picture_frame = $("<div class=\"content_picture_frame\">");
            let img = $("<img onload=\"formatSingleImage(this)\" class=\"hpicture zoomable_pic\" src=\""+picUrl+"\">");
            var singleFrame = actual_content_picture.append(content_picture_frame.append(img));
        }
    } else if(content.videoURL != '0'){
        let videoUrl = content.videoURL;
        let actual_content_picture = $("<div class=\"actual_content_picture\"></div>");
        let content_video_frame = $("<div class=\"content_video_frame\"></dive");
        let video = $("<video style=\"max-width: 100%;\" height=\"100%\" controls autoplay muted loop><source src=\""+videoUrl+"\" type=\"video/mp4\"></source></video>");
        var videoFrame = actual_content_picture.append(content_video_frame.append(video));
    }

    actual_content.append(text_content);
    // 特殊
    if (doubleFrame!=null){
        actual_content.append(doubleFrame);
    }
    if (singleFrame!=null){
        actual_content.append(singleFrame);
    }
    if (videoFrame!=null){
        actual_content.append(videoFrame);
    }
    //
    if (content.likeIds.indexOf($(".fs-id").text()) != -1){
        console.log("喜欢你");
        content_card_bottom.find(".likepicbox").children("img").attr("src","images/icon/liked.png");
    }
    content_card_info_box.append(content_card_info);
    content_card_info_box.append(actual_content);
    content_card.append(content_profile_picture_box);
    content_card.append(content_card_info_box);
    content_card_total.append(content_card_id);
    content_card_total.append(content_card);
    content_card_total.append(content_card_bottom);
    return content_card_total;
}

// $(document).ready(function(){
//     let contentObject = new content("123","text_content","0","videos/testvideo.mp4","123","",1,"",1,"",1,"",1,"",'0',"0","2022/03/21 01/38","0",0,0,1);
//     let userObject = new user("123","WWW","","123","","123@QQ.COM","","","","images/profile/bg.png","","",0,"",0,"","","","");
//     let html = getContentHtml(contentObject,userObject);
//     // alert(html.html());
//     $(".window .content").append(html);
// });
function ajaxLoadContent(){
    let num = $(".content-area").children(".content_card_total").length;
    $.ajax({
        type : "GET",
        url : "Content/getHomeContents/"+num,
        success: function(data) {
            console.log("sucscess");
            console.log(data);
            let contents = data.contents;
            let conIdMapUser = data.conIdMapUser;
            for(content of contents){
                let contentDom = getContentHtml(content,conIdMapUser[content.id]);
                $(".content-area").append(contentDom);
            }
        },
        error: function(data) {
            alert("getHomeContents:error!");
        }
    })
}

$(document).ready(function() {

    // 函数节流
    var num2 = 0;
    var alclast;
    function ajaxLoadContentThrottle(func,duration){
        //duration 秒
        let now = Date.now();
        if (alclast != null && (now - alclast) < duration*1000){

        } else {
            alclast = now;
            console.log("执行ajaxLoadContent的第"+(++num2)+"  ");
            func();
        }
    }

    $(window).scroll(function () {
        let dh = $(document.body).height();
        let wh = window.innerHeight;
        let top = $(document).scrollTop();
        let st =top + wh;
        let result = dh - st;
        if (result <= 300) {
            ajaxLoadContentThrottle(ajaxLoadContent,2);
        }
    });
});