$(document).ready(function(){
	
	// 函数节流
	var num = 0;
	var lrlast;
	function lrThrottle(func,param,duration){
		//duration 秒
		let now = Date.now();
		if (lrlast != null && (now - lrlast) < duration*1000){
			
		} else {
			lrlast = now;
			console.log(++num);
			func(param);
		}
	}
	
	$(".lbf-item").click(function(){
		// if ($(this).children("input").is(':visible')) {
		// 	$(this).children("input").focus();
		// } else {
			$(this).children("span").css("color","#499bea");
		    $(this).css("border","#499bea solid 1px");
		    $(this).animate({
		    	padding: '1px 3px'
		    },100);
		    $(this).children("span").animate({
		    	fontSize: '14px',
		    },100);
		    $(this).children("input").show();
		    $(this).children("input").focus();
		// }
		
	});
	
	// 点击email文字变成email
	$(".email").click(function(){
		$(this).children("span").html("Email");
	});
	
	
	$(".lbf-item input").blur(function(){
		var val = $(this).val();
		// alert();
		if(val == ""){
			var item = $(this).parent();
			item.children("input").hide();
			item.children("span").css("color","#6b7781");
			item.css("border","rgb(237, 240, 242) solid 1px");
			item.animate({
				padding: '12px 3px'
			},100);
			item.children("span").animate({
				fontSize: '16px',
			},100);
		} else {
			var item = $(this).parent();
			item.children("span").css("color","#6b7781");
			item.css("border","rgb(237, 240, 242) solid 1px");
		}
		
	});
	
	// 判断邮箱格式是否正确
	var emailFormat=/^\w+@[a-zA-Z0-9]{2,10}(?:\.[a-z]{2,4}){1,3}$/;
	$(".email input").blur(function(){
		var isEmail = emailFormat.test($(this).val());
		if(isEmail){
			
		}  
		else {
			if ($(this).val() == "") {
				$(this).siblings("span").html("Email");
			} else{
				$(this).siblings("span").html("Incorrect email format!");
				$(this).parent().css("border","#e13c3a solid 1px");
				$(this).siblings("span").css("color","#e13c3a");
			}
		} 
	});
	
	// 点击注册,在idea里会加上ajax
	// $(".toRegister").click(function(){
	// 	var isEmail = emailFormat.test($(".register-box .email input").val());
	// 	if(isEmail){
	// 		$(".register-box .lb-alert-area").show();
	// 		$(".register-box .lb-form-input").hide();
	// 		$(".register-box .lb-buttons").hide();
	// 		// 加了函数节流的myAlert,还没有推广
	// 		lrThrottle(myAlert,"Please finish registration through Email!",3);
	// 	} else {
	// 		lrThrottle(myAlert,"Please fill out correct information!",3);
	// 	}
	// });
	
	// ajax进行邮箱发送
	$(".toRegister").click(function(){
		var isEmail = emailFormat.test($(".register-email input").val());
		if(isEmail){
		
		
			// 做ajax异步发送邮件
			let name = $(".register-name input").val();
			let email = $(".register-email input").val();
			let password = $(".register-password input").val();
			$.post("Mail/sendMail",{
				name:name,email:email,password:password
			},function (data,status){
				if (status == "success"){
			        // 加了函数节流的myAlert,还没有推广
			        lrThrottle(myAlert,"Please finish registration through Email!",3);

					$.ajax({
						url: "User/addUser",
						type: "POST",
						contentType: "application/json",
						data: JSON.stringify({
							name: name,
							email: email,
							password: password
						}),
						success: function(data, status) {
							if (status === "success") {
								$(".register-box .lb-alert-area").show();
								$(".register-box .lb-form-input").hide();
								$(".register-box .lb-buttons").hide();
								const timer = setInterval(()=>{
									$(window).attr('location','login.jsp');
									clearTimeout(timer);
								}, 3);
							}
						}
					});
				}
			});
		
		} else {
			lrThrottle(myAlert,"Please fill out correct information!",3);
		}
	});
		
	// 点击登录,在idea里会加上ajax，或者跳转
	// dom填loginbox或者registerbox
	// 改变.lb-alert-area的颜色,来代表不同的警告,红色和蓝色
	function lbaaAlert(dom,text){
		dom.find(".lb-alert-area").show();
		dom.find(".lb-alert-area span").text(text);
		dom.find(".lb-alert-area span").css("color","rgb(225, 60, 58)");
		dom.find(".lb-alert-area img").attr("src","images/icon/error.png");
		dom.find(".lb-alert-area img").css("background-color","rgb(225, 60, 58)");
	}
	function lbaaSuccess(dom,text){
		dom.find(".lb-alert-area").show();
		dom.find(".lb-alert-area span").text(text);
		dom.find(".lb-alert-area span").css("color","#499bea");
		dom.find(".lb-alert-area img").attr("src","images/icon/success.png");
		dom.find(".lb-alert-area img").css("background-color","#499bea");
	}
	// $(".toLogin").click(function(){
	// 	var isEmail = emailFormat.test($(".login-box .email input").val());
	// 	if(isEmail){
	// 		$(".login-box .lb-alert-area").show();
	// 		var dom =$(".login-box");
	// 		var text = "Login successfully!";
	// 		lbaaSuccess(dom,text);
	// 		$(".login-box .lb-form-input").hide();
	// 		$(".login-box .lb-buttons").hide();
	// 		myAlert("Login successfully!");
	// 	} else {
	// 		var dom =$(".login-box");
	// 		var text = "Incorrect email or password!";
	// 		lbaaAlert(dom,text);
	// 		// $(".login-email").click();
	// 		myAlert("Please fill out correct information!");
	// 	}
	// });

	$(".toLogin").click(function(){
		var isEmail = emailFormat.test($(".login-box .email input").val());
		if(isEmail){
			let email = $(".login-email input").val();
			let password = $(".login-password input").val();
			$.post("User/checkUser",{
				email:email,password:password
			},function (data,status){
				if (status == "success" && data.code != "0"){
					$(".login-box .lb-alert-area").show();
					var dom =$(".login-box");
					var text = "Login successfully!";
					lbaaSuccess(dom,text);
					$(".login-box .lb-form-input").hide();
					$(".login-box .lb-buttons").hide();
					myAlert("Login successfully!");
					// 转发到explore页面
					$(window).attr('location','Content/explore');
				} else {
					var dom =$(".login-box");
					var text = "Incorrect email or password!";
					lbaaAlert(dom,text);
					// $(".login-email").click();
					myAlert("Please fill out correct information!");
				}
			});
		} else {
			var dom =$(".login-box");
			var text = "Incorrect email format!";
			lbaaAlert(dom,text);
			// $(".login-email").click();
			myAlert("Please fill out correct information!");
		}
	});
	
	// 清空loginbox里input的value
	function clearLoginBox(){
		$(".login-box").find("input").val("");
		$(".login-box").find("input").blur();
		$(".login-box").find(".lb-alert-area").hide();
	}
	// 清空loginbox里input的value
	function clearRegisterBox(){
		$(".register-box").find("input").val("");
		$(".register-box").find("input").blur();
		$(".register-box").find(".lb-alert-area").hide();
	}
	// 登录注册切换
	$(".rl-switch").click(function(){
		var isLogin = $(this).parent().parent().parent().parent().hasClass("login-box");
		var isRegister = !isLogin;
		if(isLogin){
			$(".login-box").hide();
			clearLoginBox();
			$(".register-box").show();
		} else if(isRegister){
			$(".register-box").hide();
			clearRegisterBox();
			$(".login-box").show();
		}
	});

	// explore页面下面的未登录提醒的一些功能,写这里方便,如果大屏幕下，直接转到login.html
	$(".bla-func .bla-func-item:first-child").click(function(){
		var ww = $(window).width();
		if (ww>=993) {
			if ($(".login-box").is(':visible')) {
				$(".login-email").click();
			} else {
				$(".register-box .rl-switch").click();
				$(".login-email").click();
			}
		} else {
			$(window).attr('location','login.jsp');
		}
	});
	$(".bla-func .bla-func-item:last-child").click(function(){
		var ww = $(window).width();
		if (ww>=993) {
			if ($(".register-box").is(':visible')) {
				$(".register-name").click();
			} else{
				$(".login-box .rl-switch").click();
				$(".register-name").click();
			}
		} else {
			$(window).attr('location','login.jsp');
		}
	});
	
});