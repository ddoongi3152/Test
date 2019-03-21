<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.3.1.js"></script>
<script type="text/javascript">
	
		
		function find() {
			
			var mail = document.getElementById("mail").value;
			
			if(mail == null || mail == ""){
				alert("생년월일을 입력해주세요");
			}else{
			
			alert(mail);
			
			$.ajax({
			
				type:"POST",
				data:"mail="+mail,
				url:"emailpwFindgo.do",
				success:function(data){
					if(data == "1"){
						document.getElementById("yourinformation").innerHTML =  "입력하신 정보가 일치하지 않습니다.";
					}else if(data == "0"){
						alert("메일전송 실패");
					
					}else{
						//alert(typeof data);
						alert("메일로 비밀번호가 발송되었습니다.");
						//alert("성공");
						window.close();
					}
					
					
				},
				error:function(){
					alert("실패");
				}
				
			})
			
			
			}
		}
	
</script>
	
<body>

		<table>
			<tr>
				<th>MAIL을 입력해주세요</th>
				<td><input type="text" id="mail"/> </td>
			</tr>
			<tr>
				<td>
					<input type="button" value="입력" onclick="find();"/>	
				</td>
			</tr>
			<tr>
				<td>
					<span id="yourinformation"></span>
				</td>
			</tr>
		</table>
		
		
</body>
</html>