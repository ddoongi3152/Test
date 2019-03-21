<%@page import="com.saisiot.userinfo.dto.UserinfoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript"></script>
<link rel="stylesheet" href="resources/css/homepage.css">
<title>Insert title here</title>
</head>
<body>
<%
	UserinfoDto dto = (UserinfoDto)session.getAttribute("login");
%>

	<div id="left_wrapper1">
	<div id="left_wrapper2">
	<div id="left_wrapper3">
	<div id="left_wrapper4">
		<div id="left_wrapper5_1">today | total</div>
		<div id="left_wrapper5_2">
		<div id="left_wrapper6">
			<div id="mob_top">사이좋은 사람들 사이시옷&nbsp; <%=dto.getUsername() %>님 환영합니다.</div>
			<div id="tmpdiv">탭목록</div>
			<div id="profile_pic"><img alt="profile_img" src="checkbox.PNG"></div>
			<hr id="profile_hr1">
			<div id="profile_content">
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			인생.....★ 사이좋은 사람들 사이시옷
			</div>
			<div id="profile_edit"><a>▶Edit</a> <a>▶History</a></div>
			<hr id="profile_hr2">
			<div id="owner_name">마루홍시(♪) &nbsp; <%=dto.getUsername()%>님 환영합니다. <input type="button" value="로그아웃" onclick="location.href='logout.do'"></div>
			<div id="friend_select">
				<select>
					<option>낭만고양이</option>
				</select>
			</div>
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
		<div id="right_wrapper4_1">사이좋은 사람들 사이시옷</div>

		<!-- right_wrapper4_2: right contentbox start -->
		<div id="right_wrapper4_2">
			<div id="right_wrapper4_2_1">
				<div id="right_wrapper4_2_1l">
					<div class="title">Updated News</div>
					<hr>
					<div id="listbox">
						<ul>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
							<li>sample text</li>
						</ul>
					</div>
				</div>
				<div id="right_wrapper4_2_1r">
					<div class="title">Content</div>
					<hr>
					<table>
						<tr>
							<td>다이어리 1/2</td><td>쥬크박스 0/1</td>
						</tr>
						<tr>
							<td>친구 1</td><td>채팅방 1</td>
						</tr>
					</table>
				</div>
			</div>
			<div id="right_wrapper4_2_2">
				<div class="title">Photo</div>
				<hr>
				<div id="photo_zone">
					<div class="photos"><img alt="profile_img" src="resource/home/img/checkbox.PNG"/><p>!!!</p></div>
					<div class="photos"><img alt="profile_img" src=""/><p>!!!</p></div>
					<div class="photos"><img alt="profile_img" src="resource/home/img/checkbox.PNG"/></div>
					<div class="photos"><img alt="profile_img" src="resource/home/img/checkbox.PNG"/></div>
				</div>
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

	<div id="right_sidebar">
		<div id="to_home">메인홈으로</div>
		<div id="graph">그래프표시영역</div>
		<div id="audio">
			<audio controls controlsList="nodownload" loop>
			  <source src="test.mp3" type="audio/mpeg">
			  Your browser does not support the audio tag.
			</audio>
		</div>
		<div id="audio_list">
			<table>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
				<tr><td>오디오리스트</td></tr>
			</table>
		</div>
	</div>

</body>
</html>
    