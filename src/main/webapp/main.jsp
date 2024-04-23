<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %><!-- 자유게시판DB -->
<%@ page import="bbs_notice.Bbs_NoticeDAO" %>
<%@ page import="bbs_notice.Bbs_Notice" %><!-- 공지DB -->
<%@ page import="bbs_QnA.Bbs_QnADAO" %>
<%@ page import="bbs_QnA.Bbs_QnA" %><!-- Q&A DB -->
<%@ page import="bbs_Portfolio.Bbs_PortfolioDAO" %>
<%@ page import="bbs_Portfolio.Bbs_Portfolio" %><!-- 포트폴리오 DB -->
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="css/main.css">
<link rel="stylesheet" href="css/bootstrap.css">
<title>LRAK</title>
</head>
<body>

	<div>
		<h1>LRAK</h1> <!-- 헤더 --> 
		<%@ include file="./nav/navbar.jsp" %>		
		<div>
			<aside>
				<br><br><br><br><br><br>		
				<input type="button" value="회원가입" id="m_button" onclick="location.href='http://localhost:8080/BBS/join.jsp'"><br><br>
				<input type="button" value="로그인" id="m_button" onclick="location.href='http://localhost:8080/BBS/login.jsp'">
			</aside>
		</div> <!-- 로그인/회원가입창 -->
		
		<div>
			<section class='section' id="section-l">
				<h2>공지</h2>
					<%
					Bbs_NoticeDAO bbs_NoticeDAO = new Bbs_NoticeDAO();
					ArrayList<Bbs_Notice> list = bbs_NoticeDAO.getList(pageNumber);
					if (list.size() < 5){
						for (int j=0; j<list.size(); j++) {%>
						<ul>
							<li id="li_m"><a class="link" href="notice/notice_view.jsp?Notice_bbsID=<%= list.get(j).getNotice_bbsID() %>"><%= list.get(j).getNotice_bbsTitle() %></a></li>
						</ul>
						<%}
					}
					else {
						for (int i=0; i<5; i++){
					%>
					<ul>
						<li id="li_m"><a class="link" href="notice/notice_view.jsp?Notice_bbsID=<%= list.get(i).getNotice_bbsID() %>"><%= list.get(i).getNotice_bbsTitle() %></a></li>
					</ul>
					<%
							}
					}
					%>
				
			</section>
			
			<section class='section' id="section-r">
				<h2>자유 게시판</h2>
				<%
					BbsDAO bbsDAO = new BbsDAO(); //test123
					ArrayList<Bbs> listf = bbsDAO.getList(pageNumber); 
					for (int i=0; i<5; i++){
				%>
				<ul>
					<li id="li_m"><a class="link" href="bbs/view.jsp?bbsID=<%= listf.get(i).getBbsID() %>"><%= listf.get(i).getBbsTitle() %></a></li>
				</ul>
				<%
					}
				%>
				
			</section>
		</div>
		<div>
			<section class='section' id="section-l">
				<h2>Q&amp;A 게시판</h2>
					<%
					Bbs_QnADAO bbs_QnADAO = new Bbs_QnADAO();
					ArrayList<Bbs_QnA> listq = bbs_QnADAO.getList(pageNumber); 
					if (listq.size() < 5){
						for (int j=0; j<list.size(); j++) {%>
						<ul>
							<li id="li_m"><a class="link" href="QnA/QnA_view.jsp?QnA_bbsID=<%= listq.get(j).getQna_bbsID() %>"><%= listq.get(j).getQna_bbsTitle() %></a></li>
						</ul>
						<%}
					}
					else {
						for (int i=0; i<5; i++){
					%>
					<ul>
						<li id="li_m"><a class="link" href="QnA/QnA_view.jsp?QnA_bbsID=<%= listq.get(i).getQna_bbsID() %>"><%= listq.get(i).getQna_bbsTitle() %></a></li>
					</ul>
					<%
							}
					}
					%>
			</section>
			<section class='section' id="section-r">
				<h2>포트폴리오</h2>
			</section>
		</div>
		<div>
			<footer>
				푸터 위치 잡기 그지같다 내려가라 푸터 ⓒ 2023
			</footer>
		</div>
		
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="./js/bootstrap.js"></script>
	<script src="./js/bootstrap.min.js"></script>

</body>
</html>