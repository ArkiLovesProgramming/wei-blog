$(document).ready(function() {
    if(!!window.EventSource){
        var source = new EventSource("send/serverSend");
        s = "";
        source.addEventListener('message', function (e) {
            console.log(e.data);
            let json = JSON.parse(e.data);
            console.log(json.foo);
        });

        source.addEventListener('open', function (e) {
            console.log('链接打开');
        }, false);

        source.addEventListener('error', function (e) {
            if(e.readyState == EventSource.CLOSED){
                console.log('链接关闭');
            }else{
                console.log("连接正常！");
            }
        }, false);
    } else {
        console.log('您的浏览器不支持SSE');
    }
});