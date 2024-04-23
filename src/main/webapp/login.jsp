<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">


<title>LRAK</title>
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/loginback.css">
<link href="css/bootstrap.min.css" rel="stylesheet">


</head>
<body>
<%@ include file="./nav/navbar.jsp" %>

<% String link = request.getHeader("referer"); %>
	<div id="con"> 
		<div id="login">
			<div id="login_form">
				<!--로그인 폼-->
				<form method="post" action="loginAction.jsp">
					<h3 class="login" style="letter-spacing: -1px;">로그인</h3>

					<p>
						<input type="submit" value="Sign in with Google" class="btn"
							style="background-color: #217Af0">
					</p>

					<hr>
					<label style="text-align: left; font-size: 12px; color: #666"> <!-- <span>ID</span> -->
						<span>Username</span> <br> <br>
						<input type="text" class=" size" placeholder="아이디" name="userID" maxlength="20">
					</label> <br> <label style="text-align: left; font-size: 12px; color: #666"> <!-- <span>PW</span> -->
						<br> <span>Password</span> <br> <br>
						<input type="password" class=" size" placeholder="비밀번호" name="userPassword" maxlength="20">
					</label>
						<input type="hidden" name="link" value=<%= link %>><!-- 전 페이지의 링크를 담아서 보냄  -->
					<p>
						<input type="submit" value="Sign in" class="btn">
					</p>
				</form>
				<hr>
				<p class="find">
					<span><a href="">아이디 찾기</a></span> 
					<span><a href="">비밀번호 찾기</a></span> 
					<span><a href="join.jsp">회원가입</a></span>
				</p>
			</div>
		</div>
	</div>
			



	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>