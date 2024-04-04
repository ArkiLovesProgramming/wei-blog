var $image;

//ajax请求上传
function pfEditionUploadFile(file,type) {
    let param = {
        file: file
    };
    console.log(param);
    $.ajax({
        type : 'POST',
        url : 'File/Cropper/uploadFile',
        dataType : "json",
        data : param,
        async : true,
        success : function(data) {
            let url = data.url;
            console.log(url);
            if (type == "bg") $("#realBgPicUrl").text(url);
            if (type == "pf") $("#realPfPicUrl").text(url);

            // 销毁
            $(".picture-edition-area .pea-save-btn").off("click");
            $(".picture-edition-area-back").hide();
            $image.cropper('destroy');// 销毁旧的裁剪区域// 重新初始化裁剪区域
        },
        error : function(data) {
            alert("error");
        }
    });
}

function createCanvas(type){
    let ratio = 0;
    if (type == "bg") ratio = 4;
    if (type == "pf") ratio = 1;
    $image = $("#photo");
    $image.cropper({
        aspectRatio: ratio,
        dragMode: 'move',
        viewMode: 3,
        cropBoxResizable: false,
        preview: '.img-preview',
        cropBoxMovable: false,
        autoCropArea: '1',
        ready: function(){
            $(".picture-edition-area .pea-save-btn").on("click", function(){
                let w = 1000; let h = 1000;
                if (type == "bg") {
                    w = 1160; h = 240;
                }else if (type == "pf") {
                    w = 1000; h = 1000;
                }
                $image.cropper('getCroppedCanvas',{
                    width:w,   // 裁剪后的长宽
                    height:h
                }).toBlob(function(blob){
                    if (type == "bg") {
                        $(".backgroung-pic-edtion>img").attr('src', URL.createObjectURL(blob));    // 将裁剪后的图片放到指定标签展示
                    } else if (type == "pf") {
                        $(".profile-pic-edtion>img").attr('src', URL.createObjectURL(blob));
                    }
                });
                let cas = $image.cropper('getCroppedCanvas');
                let base64 = cas.toDataURL('image/jpeg',1); // 转换为base64
                // pfEditionUploadFile(encodeURIComponent(base64));//编码后上传服务器
                pfEditionUploadFile(base64,type);//编码后上传服务器
            });

            // 滑动range input调节图片大小
            let indexSizeRange;
            $("#sizeRange").mousedown(function(){
                indexSizeRange = setInterval(function() {
                    $image.cropper("zoomTo",$("#sizeRange").val());
                }, 1);
            });
            $("#sizeRange").mouseup(function(){
                clearInterval(indexSizeRange);
            });
        }
    });
}

$(function(){

    $(".picture-edition-area .pea-back-btn").click(function() {
        if ($(".picture-edition-area-back").is(":visible")){
            $(".picture-edition-area-back").hide();
            $(".picture-edition-area-back #imgBox img").attr("src","");
            $image.cropper('destroy');      // 销毁旧的裁剪区域// 重新初始化裁剪区域
        } else {
            $(".picture-edition-area-back").css("display","flex");
        }
    });

});