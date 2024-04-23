<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs_Portfolio.Bbs_PortfolioDAO" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="bbs_Portfolio" class="bbs_Portfolio.Bbs_Portfolio" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="bbs_Portfolio" property="portfolio_bbsTitle" />
 <jsp:setProperty name="bbs_Portfolio" property="portfolio_bbsContent" />



<!DOCTYPE html>
<html>

<!-- 글쓰기 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LRAK</title>
</head>

<body>
	<%
	
		String userID = null;
		if(session.getAttribute("userID")!= null){ //유저 ID에 해당 세션 값 넣기
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
		}
		
		else{
			//뭔가 입력이 안됐을때
			if(bbs_Portfolio.getPortfolio_bbsTitle() == null || bbs_Portfolio.getPortfolio_bbsContent() == null || bbs_Portfolio.getPortfolio_bbsContent().replaceAll("\\s", "").equals("") || bbs_Portfolio.getPortfolio_bbsTitle().replaceAll("\\s", "").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				Bbs_PortfolioDAO bbs_portfolioDAO = new Bbs_PortfolioDAO();
					int result = bbs_portfolioDAO.write(bbs_Portfolio.getPortfolio_bbsTitle(), userID, bbs_Portfolio.getPortfolio_bbsContent());
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'portfolio_bbs.jsp'"); //게시판으로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>