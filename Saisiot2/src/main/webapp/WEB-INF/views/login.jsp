<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit" async defer></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src='https://www.google.com/recaptcha/api.js'></script>
<link rel="stylesheet" href="resources/css/login_web.css">
<link rel="stylesheet" href="resources/css/login_mob.css">
<script type="text/javascript">


	function emailpwFind() {
		window.open("emailpwFind.do", "ID/PW찾기", "width=500,height=300");
	}
	
	

	Kakao.init('2dd32590814325a32811f6f978ff4224');
	function loginWithKakao() {
	  // 로그인 창을 띄웁니다.
	 Kakao.Auth.loginForm({
	    success: function(authObj) {
	      alert(JSON.stringify(authObj));
	      
	      Kakao.API.request({
	
	     url: '/v2/user/me',
	     success: function(res) {
	    	 
	    	// alert(res.id);
	    	// alert(res.kakao_account.email);
	    	// alert(res.properties.nickname);
	    	 
	    	 $.ajax({	
					type:"POST",
					url:"kakaologinajax.do",
					data:"email="+res.kakao_account.email+"&password="+res.id+"&name="+res.properties.nickname,
					//data:kakaoemail,
					success:function(data){
						//alert("로그인 성공");
						location.href='homepage.do';
							
					},
					error:function(){
						alert("로그인실패");
					}
	
				})
	          
	         }
	       })
	
	    },
	    fail: function(err) {
	      alert(JSON.stringify(err));
	    }
	  });
	};


	$(document).ready(function() {
	    $("#recaptcha_btn").click(function() {
	        $.ajax({
	            url: 'VerifyRecaptcha.do',
	            type: 'post',
	            data: {
	                recaptcha: $("#g-recaptcha-response").val()
	            },
	            success: function(data) {
	                switch (data) {
	                    case 0:
	                       	//alert("자동 가입 방지 봇 통과");
	                        $('#recaptcha_chk').val('1');
	                        break;
	
	                    case 1:
	                        //alert("자동 가입 방지 봇을 확인 한뒤 진행 해 주세요.");
	                        break;
	
	                    default:
	                        alert("자동 가입 방지 봇을 실행 하던 중 오류가 발생 했습니다. [Error bot Code : " + Number(data) + "]");
	                        break;
	                }
	            }
	        });
	    });
	});

	
	

	$(window).resize(function(){
		if ($(window).width() > 460) {
			  $("#folder_list_div").show()
		}else {
			$("#folder_list_div").hide()
		}
	})
	$(document).ready(function(){
	  $("#folder_list_drop").click(function(){
	    $("#folder_list_div").toggle()
	  });
	});

	function mailcon() {
		
		window.open("mailgo.do", "이메일 인증", "width=500,height=300");
		
	}
	
	function goPopup(){
		// 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrLinkUrl.do)를 호출하게 됩니다.
	    var pop = window.open("jusoPopup.do","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 
	    
		// 모바일 웹인 경우, 호출된 페이지(jusopopup.jsp)에서 실제 주소검색URL(http://www.juso.go.kr/addrlink/addrMobileLinkUrl.do)를 호출하게 됩니다.
	    //var pop = window.open("/popup/jusoPopup.jsp","pop","scrollbars=yes, resizable=yes"); 
	}
	
		
	function pwchk(){
			
			if(document.getElementById('insertpassword').value.length >= 6 && document.getElementById('insertpasswordchk').value.length <= 12){
				document.getElementById('same01').innerHTML='사용가능한 비밀번호 입니다.';
				document.getElementById("same01").style.color="blue";
	    		
	    	} 
			else {
	    		document.getElementById('same01').innerHTML='비밀번호는 6글자 이상 12글자 이하로 설정해주세요';
	    		document.getElementById("same01").style.color="red";
	    	}
	    	
	    	if(document.getElementById('insertpassword')!='' && document.getElementById('insertpasswordchk').value!=''){
	    		if(document.getElementById('insertpassword').value==document.getElementById('insertpasswordchk').value){
	    			document.getElementById('same02').innerHTML='비밀번호가 일치 합니다.';
	    			document.getElementById('same02').style.color='blue';
	    		}
	    		else{
	    			document.getElementById('same02').innerHTML='비밀번호가 일치하지않습니다.';
	    			document.getElementById('same02').style.color='red';
	    		}
	    	}
	    }
	
	
	function notnull(){
		
		if(document.getElementById("insertemail").value == null){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertemail").value == ""){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertpassword").value == null){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if(document.getElementById("insertpassword").value == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		if(document.getElementById("birthday").value == null){
			alert("생년월일을 입력해주세요");
			return false;
		}
		if(document.getElementById("birthday").value == ""){
			alert("생년월일을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertname").value == null){
			alert("이름을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertname").value == ""){
			alert("이름을 입력해주세요");
			return false;
		}
		if(document.getElementById("insertaddress").value == null){
			alert("주소를 입력해주세요");
			return false;
		}
		if(document.getElementById("insertaddress").value == ""){
			alert("주소를 입력해주세요");
			return false;
		}
		
		if(document.getElementById("recaptcha_chk").value == null){
			alert("자동입력방지를 확인해주세요");
			return false;
		}
		
		if(document.getElementById("recaptcha_chk").value == ""){
			alert("자동입력방지를 확인해주세요");
			return false;
		}
		
		return true;
	}
	
	function loginchk() {
		
		if(document.getElementById("email").value == ""){
			alert("이메일을 입력해주세요");
			return false;
		}
		if(document.getElementById("email").value ==null){
			alert("이메일을 입력해주세요");
			return false;
		}
		
		if(document.getElementById("pw").value == ""){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
		if(document.getElementById("pw").value == null){
			alert("비밀번호를 입력해주세요");
			return false;
		}
		
	
		return true;
	}
	
	
	
	

</script>
</head>
<body>

	<div id="left_wrapper1">
	<div id="left_wrapper2">
	<div id="left_wrapper3">
	<div id="left_wrapper4">
		<div id="left_wrapper5_1">
			로그인
			<div id="left_wrapper6_1" align="center">
				<form action="logingo.do" method="post" onsubmit="return loginchk();">
					<label>EMAIL</label>
						<input type="text" id="email" name="email" placeholder="이메일을 입력해주세요">
					<label>PASSWORD</label>
						<input type="text" id="pw" name="pw" placeholder="비밀번호를 입력해주세요">
					<!-- <div id="login_apis"> -->
					
				
						<div align="center"><a id="custom-login-btn" href="javascript:loginWithKakao()"><img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/></a></div>
						
				
						<div id="naver_id_login" align="center"></div>
						<script type="text/javascript">
						var naver_id_login = new naver_id_login("FyagxD4aXpcrDC2Hvgos", "http://localhost:8787/mvc03/callback.do");
					  	var state = naver_id_login.getUniqState();
					  	naver_id_login.setButton("green", 60,50);
					  	naver_id_login.setDomain("http://localhost:8787/mvc03/");
					  	naver_id_login.setState(state);
					  	naver_id_login.setPopup();
					  	naver_id_login.init_naver_id_login();	
						</script>
					
						<div align="center"><input type="submit" value="로그인"/>&nbsp;<input type="button" value="EMAIL/PW찾기" onclick="emailpwFind();"/> </div>
				
				</form>
			</div>
		</div>
		<div id="left_wrapper5_2">
			회원가입
			<div id="left_wrapper6_2" align="center">
				<form action="userinsert.do" method="post" name="myForm" onsubmit="return notnull();">
					<label>EMAIL</label>
						<input type="text" id="insertemail" name="email" placeholder="이메일을 입력해주세요" readonly="readonly" onclick="mailcon();"/>					
					<label>PASSWORD</label>			
						<input type="text" id="insertpassword" name="password" placeholder="비밀번호를 입력해주세요" onchange="pwchk();">
						<span id="same01"></span>
					<label>PASSCHECK</label>
						<input type="text" id="insertpasswordchk" placeholder="비밀번호를 다시 입력해주세요" onchange="pwchk();">
						<span id="same02"></span>
					<label>GENDER</label>		
						<div id="regist_gender" >
							<input type="checkbox" class="checkbox" name="gender" value="M"><label>남</label><input type="checkbox" class="checkbox" name="gender" value="W"><label>여</label>
						</div>
					<label>BIRTHDAY</label>	
						<input type="date" id="birthday" name="birthday" placeholder="생년월일을 입력해주세요" />
					<label>NAME</label>
						<input type="text" id="insertname" name="name" placeholder="이름을 입력해주세요">
					<label>ADDRESS</label>	
						<input type="text" id="insertaddress" name="address" placeholder="주소를 입력해주세요" readonly="readonly" onclick="goPopup();">
						<input type="hidden" id="recaptcha_chk">
				
						<div><input type="submit" id="recaptcha_btn" value="가입"></div>							
				</form>
					<div class="g-recaptcha" data-sitekey="6LfiDJcUAAAAADcFYZpJvash2bUuQrFwky-zgQwx" >
			</div>
		</div>
		<!-- left_wrapper5 end -->
	</div>
	<!-- left_wrapper4 end(white box) -->
	</div>
	<!-- left_wrapper3 end(gray box) -->
	</div>
	<!-- left_wrapper2 end(dashed box) -->
	</div>
	<!-- left_wrapper1 end(blue box) -->


	<div id="right_wrapper1">
	<div id="right_wrapper2">
	<div id="right_wrapper3">
	<div id="right_wrapper4">
		<!-- right_wrapper4_2: right contentbox start -->
			<div id="right_wrapper4_2">

			</div>
		</div>
		<!-- right_wrapper4_2 end -->
	</div>
	<!-- right_wrapper4 end(white box) -->
	</div>
	<!-- right_wrapper3 end(gray box) -->
	</div>
	<!-- right_wrapper2 end(dashed box) -->
	</div>
	<!-- right_wrapper1 end(blue box) -->

</body>
</html>