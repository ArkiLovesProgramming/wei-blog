$(document).ready(function(){

    // 刷新输入页面
    function flashSendContentBox(){
        $("#rbb-file").val("");
        $("#rbb-file-second").val("");
        $("#rbb-video").val("");
        $("#div-editable>div>span").html("");
        $(".pff").addClass("d-none");
        $(".pfs").addClass("d-none");
        $(".send-video-box").addClass("d-none");
        $(".selected-cat-box").html("");
        $(".selected-cat").html("");
        $(".cb-parentCategory").html("");
        $(".cb-childCategory").html("");
        allowSbfItem($(".send-video-func"));
        allowSbfItem($(".send-image-func"));
        injectCategories();
    }

    function uploadFile() {
        let url;
        $.ajax({
            type : "post",
            url : "File/uploadFile",
            data : new FormData($("#rbb-form")[0]),
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

    function sendContent() {
        // 作者id
        let authorId = $(".fakeSession .fs-id").text();
        // 如果没有登录直接报错
        if (authorId == ""){
            myAlert("Error:null userId!");
            return null;
        }
        // 打开发送蒙层
        $(".sendContentBox .scb-cover").show();
        // 内容
        let textContent = $("#div-editable").html();
        // picurl && videUrl
        let url = uploadFile();
        let urlList = url.split('|');
        let picUrl = urlList[0];
        let videoUrl = urlList[1];
        // topicids数组
        let topicIds = "";
        $(".selected-cat-box .scb-item:visible").each(function() {
            let text = $(this).children(".cat-item-id").text();
            if (text != ""){
                topicIds = topicIds+text+",";
            }
        });
        topicIds = topicIds.slice(0,topicIds.length-1);
        let level = 0;
        let parentId = 0;
        let childContentId = 0;
        let playNum = 0;
        let deleted = 0;
        let visible = 1;
        var content = JSON.stringify({
            textContent: textContent,
            pictureURL: picUrl,
            videoURL: videoUrl,
            authorId: authorId,
            topicIds: topicIds,
            level: level,
            parentId: parentId,
            childContentId: childContentId,
            playNum: playNum,
            deleted: deleted,
            visible: visible,
        });
        $.ajax({
            type : "post",
            url : "Content/sendContent",
            contentType : "application/json",
            data : content,
            success: function(data) {
                $(window).attr('location','Content/getHomeContents');
            },
            error: function(data) {
                alert("sendContent:error!");
            }
        });
    }

    function sendComment(parentId1,level1) {
        // 作者id
        let authorId = $(".fakeSession .fs-id").text();
        // 如果没有登录直接报错
        if (authorId == ""){
            myAlert("Error:null userId!");
            return null;
        }
        // 打开发送蒙层
        $(".reply-box .reply-box-cover").show();
        // 内容
        let textContent = $("#div-editable").html();
        // picurl && videUrl
        let url = uploadFile();
        let urlList = url.split('|');
        let picUrl = urlList[0];
        let videoUrl = urlList[1];
        // topicids数组
        let topicIds = "";
        let level = level1;
        let parentId = parentId1;
        let childContentId = 0;
        let playNum = 0;
        let deleted = 0;
        let visible = 1;
        var content = JSON.stringify({
            textContent: textContent,
            pictureURL: picUrl,
            videoURL: videoUrl,
            authorId: authorId,
            topicIds: topicIds,
            level: level,
            parentId: parentId,
            childContentId: childContentId,
            playNum: playNum,
            deleted: deleted,
            visible: visible,
        });
        $.ajax({
            type : "post",
            url : "Content/sendContent",
            contentType : "application/json",
            data : content,
            success: function(data) {
                let contentId = $(".detailContent-id").text();
                $(window).attr('location','Content/detailContent/'+contentId);
            }
        });
    }

    function isNullContent(){
        let spring = '<div class="d-flex flex-column"><span></span></div>';
        if ($("#div-editable").html() == spring && $("#rbb-file").val() == ""
            && $("#rbb-file-second").val() == "" && $("#rbb-video").val() == ""){
            myAlert("The reply you typed is empty.");
            return true;
        } else return false;
    }

    $(".scb-submit-border").click(function() {
        if (isNullContent()){
            //什么也不干
        } else {
            sendContent();
        }
    });

    $(".rp_button").click(function() {
        if (isNullContent()) {
            //什么也不干
        } else {
            let conParentId = $(".detailContent-id").text();
            let level = parseInt($(".detailContent-level").text())+1;
            if (level >= 2){
                level = 2;
            }
            sendComment(conParentId,level);
        }
    });
});