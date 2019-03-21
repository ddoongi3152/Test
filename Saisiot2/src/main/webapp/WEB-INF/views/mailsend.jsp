<%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메일 인증 코드 발송</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">

 
	/* function numberchk() {
		
		var number = document.getElementById("numberchk").value;
		var random = ${random};
		
		if(number == random){
			alert("인증코드가 일치합니다.");
			
			$.ajax({
				type:"POST",
				url:"randomgood.do",
				data:"random="+random,
				success:function(data){
					alert("숫자 전송 성공");
					window.opener.document.getElementById("mailcode").value = random;
					window.close();
					
				},
				error:function(){
					alert("실패");
				}
				
				
			})
			
		}else{
			alert("인증코드가 일치하지 않습니다.");
		}
		
	} */
	
	
	function mailchk(){
		
		var email = document.getElementById("yourmail").value;
		var randomcode = Math.floor(Math.random() * (99999 - 10000 + 1)) + 10000;
		
		if(email == null || email == ""){
			alert("이메일 주소를 입력하세요");
			return false;
		}
		
		$.ajax({
			
			type:"POST",
			url:"emailcheck.do",
			data:"email="+email,
			success:function(data){
				//alert(data);
				if(data == "0"){
					alert("중복된 이메일 입니다.");
				}else if(data == "1"){
					
					$.ajax({
						type:"POST",
						url:"mailsend.do",
						data:"email="+email+"&randomcode="+randomcode,
						success:function(data){
							alert("사용가능한 이메일입니다. 인증코드 전송 되었습니다.");
							$('#randomcode').val(randomcode);
						},
						error:function(){
							alert("인증코드 전송실패");
						}					
					})
					
				}
			},
			error:function(){
				alert("이메일 중복확인 실패");
			}
			
		})
	}
	
	function numberchk() {
		
		var randomcode = document.getElementById("randomcode").value;
		var numberchk = document.getElementById("numberchk").value;
		
		if(randomcode == null || randomcode == ""){
			
			alert("인증코드를 입력해주세요")
			return false;
	
		}else if(randomcode == null || randomcode != ""){
			
			if(randomcode == numberchk){
				alert("인증코드가 일치 합니다.");
				window.opener.document.getElementById("insertemail").value = document.getElementById("yourmail").value;
				self.close();
			}else if(randomcode != numberchk){
				alert("인증코드가 일치 하지 않습니다.");
			}
			
		}
	}


</script>
<body>
		<table border="1">
			<tr>
				<td>
					<input type="text" id="yourmail"/>
					<input type="button" value="이메일 중복 체크" onclick="mailchk();"/>
					<input type="hidden" readonly="readonly" id="randomcode"/>
					<br>
					<input type="text" id="numberchk"/>
					<input type="button" value="인증코드 확인" onclick="numberchk();"/>
				</td>
			</tr>			
		</table>


</body>
</html>