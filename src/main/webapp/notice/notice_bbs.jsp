<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs_notice.Bbs_NoticeDAO" %>
<%@ page import="bbs_notice.Bbs_Notice" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="user.UserDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" href="../css/bootstrap.css?after">
<link rel="stylesheet" href="../css/bbs.css?after">
<title>LRAK</title>
    
</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						Bbs_NoticeDAO bbs_NoticeDAO = new Bbs_NoticeDAO();
						ArrayList<Bbs_Notice> list = bbs_NoticeDAO.getList(pageNumber); //글 목록 가져오기
						for(int i = 0; i<list.size(); i++){
					%>
					<tr>
						<td><%= list.get(i).getNotice_bbsID() %></td>
						<!-- 글 제목 누르면 해당 페이지로 이동 -->
						<td><a href="notice_view.jsp?Notice_bbsID=<%= list.get(i).getNotice_bbsID() %>"><%= list.get(i).getNotice_bbsTitle() %></a></td>
						<td><%= list.get(i).getNotice_userNickname() %></td> <!-- 아이디가 아닌 닉네임으로 노출 되게 바꿈 2.3 배정훈 추가  -->
						<!-- 글 쓴 날짜, 시간 가져오는거 -->
						<td><%= list.get(i).getNotice_bbsDate().substring(0,11) + list.get(i).getNotice_bbsDate().substring(11, 13) + "시" + list.get(i).getNotice_bbsDate().substring(14,16) + "분" %></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
<%
			
			int cnt = bbs_NoticeDAO.Paging(); //게시판에 존재하는 전체 글 수
			int pageBlock = 10; //한 페이지에 보여줄 글 수
				if(cnt>pageBlock){ //전체 글 수가 한 페이지에 보여지는 글 수보다 많다면
					
					int pageCount = cnt / pageBlock + (cnt%pageBlock==0?0:1); //전체 페이지수 계산
					int startPage = ((pageNumber-1)/pageBlock)*pageBlock+1; //시작 페이지 계산
					int endPage = startPage + pageBlock - 1; //끝 페이지 계산
					if(endPage > pageCount){
						endPage = pageCount;
					}
			%>
			
			<!-- 다음, 이전 페이지 버튼 만들기 -->
			<% if(pageNumber!=1){ %> <!-- 첫번째 페이지가 아니라면 -->
				<a href="notice_bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-success btn-arrow-left" id="pbtn_next">이전</a>
			<%} %>
			<% for(int i=startPage; i<=endPage; i++){ %>
				<a href="notice_bbs.jsp?pageNumber=<%= i%>" class="btn btn-success btn-arrow-left" id="pbtn"><%= i%></a>
			<%} %>
			<% if(bbs_NoticeDAO.nextPage(pageNumber+1)){ %> <!-- 다음 페이지가 있다면 -->
				<a href="notice_bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-success btn-arrow-left" id="pbtn">다음</a>
			<%} %>
			
			<%} %>
					
		
			<%
			UserDAO userDAO = new UserDAO();
			int result = userDAO.serach(userID);
			if(result == 1){ %>
			
				<a href="notice_write.jsp" class="btn btn-primary pull-right" id="btnst">글쓰기</a>
			<%} %>
			
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>
	

</body>
</html>