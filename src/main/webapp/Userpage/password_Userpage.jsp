<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">


<title>LRAK</title>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/loginback.css">
<link href="../css/bootstrap.min.css" rel="stylesheet">


</head>
<body style ="background-color:#f5f1ee;">
<%@ include file="../nav/navbar.jsp" %>

	<div id="con"> 
		<div id="login">
			<div id="login_form">
				<form method="post" action="passwordAction.jsp">
					<h3 style="text-align: center;">비밀번호 확인</h3> <!--1.23 뒷 배경 제거  -->
					<hr>
					<label style="text-align: left; font-size: 12px; color: #666">
						<br> <span>정보 수정을 위해 비밀번호를 입력해주세요.</span> <br> <br>
						<input type="password" class="size" placeholder="비밀번호" name="userPassword" maxlength="20">
					</label>

					<p>
						<input type="submit" value="Sign in" class="btn">
					</p>
				</form>
				<hr>
			</div>
		</div>
	</div>
			



	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>