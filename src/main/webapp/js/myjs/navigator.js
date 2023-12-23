$(document).ready(function() {
   // 由于是动态添加
   $(document).on("click",".logout-button",function (){
      $(window).attr('location','logout.jsp');
   })
});