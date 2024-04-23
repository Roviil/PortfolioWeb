<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs_Portfolio.Bbs_Portfolio" %> <!-- bbs데이터베이스 사용 가능하도록 해당 클래스 가져오기 -->
<%@ page import="COMMENT_PORTFOLIO.Comment_Portfolio" %>
<%@ page import="bbs_Portfolio.Bbs_PortfolioDAO" %><!-- 데이터베이스 접근 객체도 가져옴 -->
<%@ page import="COMMENT_PORTFOLIO.Comment_PortfolioDAO" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>

<!-- 게시글 보기 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" href="../css/bootstrap.css" type="text/css">
<link rel="stylesheet" href="../css/view.css" type="text/css">
<title>LRAK</title>
</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
	<%
		int Portfolio_bbsID = 0;
		if(request.getParameter("Portfolio_bbsID") != null){ //bbsID가 존재한다면
			Portfolio_bbsID = Integer.parseInt(request.getParameter("Portfolio_bbsID")); //bbsID에 그걸 담아서 처리할 수 있게 함
		}
		if(Portfolio_bbsID == 0){ //0이니까 bbsID가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'portfolio_bbs.jsp'");
			script.println("</script>");
		}
		Bbs_Portfolio bbs_portfolio = new Bbs_PortfolioDAO().getBbs_Portfolio(Portfolio_bbsID); //해당 글 가져옴
		if(bbs_portfolio == null){ //존재하지 않는 글일경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'portfolio_bbs.jsp'");
			script.println("</script>");
		}
		if(bbs_portfolio.getPortfolio_bbsAvailable() == 0){ // 삭제된 글일경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제된 글입니다.')");
			script.println("location.href = 'portfolio_bbs.jsp'");
			script.println("</script>");
		}
	%>
		

	<div class="container">
		<div class="row">
			<div class="main">
    			<h1 class="cho"><span>포트폴리오</span></h1>
   				 <section class="board">
      				  <div class="header">
       				     <h3 class="title"><%= bbs_portfolio.getPortfolio_bbsTitle()%></h3>
       				     <div class="info">
        			        <p>
        			        <span>작성자</span> <%= bbs_portfolio.getPortfolio_userID() %>
           				    </p>
           				     <p><span>작성일</span>
           				       <%= bbs_portfolio.getPortfolio_bbsDate().substring(0,11) + bbs_portfolio.getPortfolio_bbsDate().substring(11, 13) + "시" + bbs_portfolio.getPortfolio_bbsDate().substring(14,16) + "분" %>
           				     </p>
            			 </div>
      			 	 </div>
    				  <div class="body">
    				  	<div class="content">
    				  		<%= bbs_portfolio.getPortfolio_bbsContent().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %>
    				  	</div>
    				  </div>
    				</section>
			</div>
			<%-- <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs_qna.getQna_bbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs_qna.getQna_userID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs_qna.getQna_bbsDate().substring(0,11) + bbs_qna.getQna_bbsDate().substring(11, 13) + "시" + bbs_qna.getQna_bbsDate().substring(14,16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height: 200px; text-align: center;">
						<%= bbs_qna.getQna_bbsContent().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %></td>
					</tr>
				</tbody>	
			</table> --%>
			
			<div class="container">
				<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="3" style="background-color: #eeeeee; text-align: center;">댓글</th>
							</tr>
						</thead>
					<%
						Comment_PortfolioDAO Comment_PortfolioDAO = new Comment_PortfolioDAO();
						ArrayList<Comment_Portfolio> list = Comment_PortfolioDAO.comment_getList(Portfolio_bbsID);
						for(int i = list.size()-1; i>=0; i--){
					%>

					 <tbody>
					 	<tr style="background-color: transparent;">
					 	<td><%= list.get(i).getCOMMENT_userID() %></td>
					 	<td style="text-align: center;"><%= list.get(i).getCOMMENT_comment() %></td>
					 	<td style="text-align: end; font-size: 10px; color: gray;"><%= list.get(i).getCOMMENT_date().substring(0,11) + list.get(i).getCOMMENT_date().substring(11, 13) + "시" + list.get(i).getCOMMENT_date().substring(14,16) + "분" %></td>
					 	</tr>
					</tbody>

					<%
						}
					%>
				</table>
				</div>
			</div>
			
			<!-- 댓글입력 -->
				<%
				if (userID != null) {
				%>
				<div class="container">
					<div class="row">
						<form method="post" action="portfolio_commentAction.jsp?Portfolio_bbsID=<%= Portfolio_bbsID %>">
							<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
								<tbody>
									<tr>						
										<td><textarea class="form-control" placeholder="댓글을 입력하세요." name="COMMENT_comment" maxlength="300" style="height: 100px"></textarea></td>
									</tr>
								</tbody>
							</table>
							<input type="submit" class="btn btn-primary pull-right" id="btns" value="댓글쓰기">
						</form>
						<a onclick="history.back()" class="btn btn-primary" id="btns">뒤로가기</a>
						<a href = "portfolio_bbs.jsp" class="btn btn-primary" id="btns">목록</a> <!-- 글 목록으로 되돌아가기 -->
					<%
						if (userID != null && userID.equals(bbs_portfolio.getPortfolio_userID())){ //만약 글 쓴 유저가 해당 유저라면 글 수정, 삭제 가능하게 하기
					%>	
						<a href="portfolio_update.jsp?Portfolio_bbsID=<%= Portfolio_bbsID %>" class="btn btn-primary" id="btns">글 수정</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="portfolio_deleteAction.jsp?Portfolio_bbsID=<%= Portfolio_bbsID %>" class="btn btn-primary" id="btns">삭제</a>
					<%
						}	
					%>
					</div>
				</div>
					
				<%
				}
				else {
					%>
					<p class="container table table-striped" style="text-align: center; border: 1px solid #dddddd">댓글 작성을 위해서 <a href="http://localhost:8080/BBS/login.jsp">로그인이 필요합니다.</a></p>
				<%
				}
				%>
			
			
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script src="../js/bootstrap.min.js"></script>

</body>
</html>