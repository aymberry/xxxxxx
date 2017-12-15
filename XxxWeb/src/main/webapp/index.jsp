<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Document</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){
		$("#Btn1").click(function(){
			$(location).attr("href", "./Login/LoginForm.time")
		});
		$("#Btn3").click(function(){
			$(location).attr("href", "./Join/JoinForm.time")
		});
	});
</script>
<body>
	<div style="background-color:#B4B0C1">
		<h2>iidea.xyz</h2><br><br>
		<P>  The time on the server is ${serverTime}. </P><br><br>
		<button type="button" id="Btn1" value="로그인">로그인</button>
		<button type="button" id="Btn3" value="회원가입">회원가입</button><br><br>
		<button type="button" id="Btn2" value="게시판">게시판</button><br><br>
		
	</div>
</body>
</html>


