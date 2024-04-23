<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs_Portfolio.Bbs_Portfolio" %>
<%@ page import="bbs_Portfolio.Bbs_PortfolioDAO" %>
<!DOCTYPE html>
<html>

<!-- 게시글 수정 페이지 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>LRAK</title>
</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
	<%
		if(userID == null){ //ID값이 null이면 아직 로그인 안한거
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다')");
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
		}
		int portfolio_bbsID = 0;
		if(request.getParameter("Portfolio_bbsID") != null){ //bbsID가 존재한다면
			portfolio_bbsID = Integer.parseInt(request.getParameter("Portfolio_bbsID")); //bbsID에 그걸 담아서 처리할 수 있게 함
		}
		if(portfolio_bbsID == 0){ //0이니까 bbsID가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs_Portfolio Portfolio_bbs = new Bbs_PortfolioDAO().getBbs_Portfolio(portfolio_bbsID);
		if (!userID.equals(Portfolio_bbs.getPortfolio_userID())){ //글 작성자 본인이 아닐 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 작성자만 수정 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>
	
	<div class="container">
		<div class="row">
		 <!-- updateAction페이지로 내용 숨겨서 전송 -->
		<form method="post" action="portfolio_updateAction.jsp?PortfoliobbsID=<%= portfolio_bbsID %>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style="background-color: #eeeeee; text-align: center;">질문 수정</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<!-- value 부분은 자기가 전에 작성했던 글 보여주는거임! -->
						<td><input type="text" class="form-control" placeholder="글 제목" name="Portfolio_bbsTitle" maxlength="50" value="<%= Portfolio_bbs.getPortfolio_bbsTitle() %>"></td>
					</tr>
					<tr>						
						<td><textarea class="form-control" placeholder="글 내용" name="Portfolio_bbsContent" maxlength="2048" style="height: 350px"><%= Portfolio_bbs.getPortfolio_bbsContent() %></textarea></td>
					</tr>

				</tbody>
			</table>
			<input onclick="return confirm('수정하시겠습니까?')" type="submit" class="btn btn-primary pull-right" value="수정하기">
		</form>
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>

</body>
</html>