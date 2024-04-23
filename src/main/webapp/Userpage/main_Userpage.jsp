<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.User" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/loginback.css">
<title>LRAK</title>
</head>


<!-- 23.01.21 유말그미 추가 -->
<body style ="background-color:#f5f1ee;">
<%@ include file="../nav/navbar.jsp" %>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	
	<% 
		User user = new UserDAO().getUserdata(userID);
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
		script.println("location.href = '../login.jsp'");
		script.println("</script>");
	}
	%>
	<!--왜 깃에 안올라가지   -->
	
	<div id="con">
		<div id="login">
			<div id="login_form" style="margin-top:100px;">
				<form method="post" action="update_UserAction.jsp?userID=<%= userID %>">
					<h3 style="text-align: center;">회원 정보 수정</h3> 
					<hr>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span >아이디</span><br>
						<input type="text" class="size" disabled="disabled" value =<%= user.getUserID() %> style="width: 258px; border:none;">
					</label>
						<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span >비밀번호</span><br>
						<input type="password" class="size" name="userPassword" maxlength="50" style="width: 258px; border:none;" value="<%=user.getUserPassword()%>">	
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>이름</span><br>
						<input type="text" class="size" placeholder="이름" name="userName" maxlength="50" style="width: 258px; border:none;" value="<%= user.getUserName() %>">		
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>이메일</span><br>
						<input type="email" class="size" placeholder="이메일" name="userEmail" maxlength="50" style="width: 258px; border:none;" value="<%= user.getUserEmail() %>">		
					</label>
					<br><br>
					<label style="text-align: left; font-size: 14px; color: #666">
						<span>닉네임</span><br>
						<input type="text" class="size" placeholder="닉네임" name="userNickname" maxlength="20" style="width: 258px; border:none;" value="<%= user.getUserNickname() %>">		
					</label>
					<br><br>
					<%
							if(user.getUserGender().equals("남자")){
					%>
					<input type="hidden" name="userGender" autocomplete="off" value="남자" checked>
					<%} 
							else{
					%>
					<input type="hidden" name="userGender" autocomplete="off" value="여자" checked>
					
					<%
							}
					%>
					<input onclick="return confirm('수정하시겠습니까?')" type="submit" class="btn btn-primary pull-right" value="수정하기">
				</form>
			</div>
		</div>
	</div>

</body>
</html>