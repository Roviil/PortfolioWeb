<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="http://localhost:8080/BBS/css/bootstrap.css">
<link rel="stylesheet" href="http://localhost:8080/BBS/css/join.css">
<title>LRAK</title>
</head>
<body>
	<%
		String userID = null;
		if(session.getAttribute("userID")!=null){
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1; //기본 첫 페이지
		if (request.getParameter("pageNumber") != null){ //파라미터가 넘어오면 페이지 넘버 삽입
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="http://localhost:8080/BBS/main.jsp">JSP 게시판</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="http://localhost:8080/BBS/notice/notice_bbs.jsp">공지사항</a></li>
				<li><a href="http://localhost:8080/BBS/bbs/bbs.jsp">자유게시판</a></li>
				<li><a href="http://localhost:8080/BBS/QnA/QnA_bbs.jsp">Q&amp;A게시판</a></li>
			</ul>
			<%
				if(userID == null){
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="true">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="http://localhost:8080/BBS/login.jsp">로그인</a></li>
						<li><a href="http://localhost:8080/BBS/join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
				else{
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="true">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="http://localhost:8080/BBS/logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<% 
				}
			%>
		</div>
	</nav>

			<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
			<script src="http://localhost:8080/BBS/js/bootstrap.js"></script>

</body>
</html>