<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리끼리 게시판</title>
</head>

<body>
	<%
		session.invalidate(); //로그아웃하는 회원들 세션 뺏기
	%>
	<script>
		<%String link = request.getHeader("referer");
		response.sendRedirect(link);%>//로그아웃시 전 페이지로 돌아가
		
	</script>
</body>

</html>