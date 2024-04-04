$(document).ready(function(){

    // 初始化页面在顶端
    $(document).scrollTop(0);

    $(".total-suspend").on("click",".cb-parentCategory .cpc-item",function(){
        // alert("");
        let id = $(this).children(".cat-item-id").text();
        let posi;
        for(let pi of pList){
            if(id == pi.id){
                posi = pList.indexOf(pi);
            }
        }
        let selectedIdList = new Array();
        $(".selected-cat .cbc-item").each(function(){
            if($(this).is(":visible")){
                let tid = $(this).children(".cat-item-id").text();
                if(selectedIdList.indexOf(tid) == -1){
                    selectedIdList.push(tid);
                }
            }
        });
        // console.log(selectedIdList);
        $(".cb-childCategory").html("");
        for(let i = 0;i < cList[posi].length;i++){
            let thisitemid = cList[posi][i].id;
            if (selectedIdList.indexOf(thisitemid) != -1) {
                let item = $('<div class="cbc-item selected-cat-item"><span>'+cList[posi][i].name+'</span><span class="di">+</span><img src="images/icon/right.png" ><span class="cat-item-id d-none">'+cList[posi][i].id+'</span></div>');
                $(".cb-childCategory").append(item);
            } else {
                let item = $('<div class="cbc-item"><span>'+cList[posi][i].name+'</span><span class="di">+</span><img src="images/icon/add.png" ><span class="cat-item-id d-none">'+cList[posi][i].id+'</span></div>');
                $(".cb-childCategory").append(item);
            }
        }
        // $(".cb-childCategory")
    });
});