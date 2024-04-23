<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://localhost:8080/BBS/css/main.css">
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

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
	<nav>
		<div class="nav">
			<div class="logo"><ul>
				<li><a href="http://localhost:8080/BBS/main.jsp"><img src="http://localhost:8080/BBS/img/logo.png"></a></li>
			</ul></div>
			<div class="menu"><ul>
				<li><a href="http://localhost:8080/BBS/notice/notice_bbs.jsp">공지사항</a></li>
				<li><a href="http://localhost:8080/BBS/bbs/bbs.jsp">자유게시판</a></li>
				<li><a href="http://localhost:8080/BBS/QnA/QnA_bbs.jsp">Q&amp;A게시판</a></li>
				<li><a href="http://localhost:8080/BBS/Portfolio/portfolio_bbs.jsp">포트폴리오</a></li>
			</ul></div>
			<div class="loginmenu">
				<%
				if(userID == null){
			%>
			<ul>
				<li><a href="#">접속하기</a>
					<ul class="dropdown-menu">
						<li><a href="http://localhost:8080/BBS/login.jsp">로그인</a></li>
						<li><a href="http://localhost:8080/BBS/join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
				else{
					UserDAO userDAO = new UserDAO();
					int result = userDAO.serach(userID);
					User user = new UserDAO().getUserdata(userID);
			%>
			<ul>
				<li><a href="#">회원관리</a>
					<ul class="dropdown-menu">
						<li><img src="https://t1.daumcdn.net/cfile/tistory/24283C3858F778CA2E" style="width:80px; height:80px; border-radius:50%; overflow: hidden;"></li>
						<li style="font-size:12px;"><%=user.getUserNickname()%></li>
						<li><a href="http://localhost:8080/BBS/Userpage/password_Userpage.jsp">회원정보관리</a></li>
						<li><a href="http://localhost:8080/BBS/logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<% 
				}
			%>
			</div>
		</div>
	</nav>

</body>
</html>