<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="bbs.Bbs" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="java.io.PrintWriter" %> 

 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="bbs" property="bbsTitle" />
 <jsp:setProperty name="bbs" property="bbsContent" />
  <%@ page import="user.User" %>
 <%@ page import="user.UserDAO" %>



<!DOCTYPE html>
<html>

<!-- 글쓰기 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판</title>
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
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null || bbs.getBbsContent().replaceAll("\\s", "").equals("") || bbs.getBbsTitle().replaceAll("\\s", "").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				UserDAO userDAO = new UserDAO();
				String name = userDAO.nameserach(userID);//닉네임가져와서 데이터베이스로 저장 
				BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent(), name);
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
						script.println("location.href = 'bbs.jsp'"); //게시판으로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>