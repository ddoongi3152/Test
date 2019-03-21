/<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴면계정입니다.</title>
</head>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>
<body>
	<h1><%=dto.getUsername() %>님의 계정은 휴면상태입니다.</h1>
	<h2>비밀번호를 변경하세요!</h2>
	
	<a href="logout.do">로그아웃</a>
</body>
</html>