<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="user" class="user.User" scope="page" />
 <jsp:setProperty name="user" property="userID" /> <!-- user ID 받아오는거 -->
 <jsp:setProperty name="user" property="userPassword" />

<!DOCTYPE html>
<html>

<!-- 로그인 기능 -->

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
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='http://localhost:8080/BBS/main.jsp'");
			script.println("</script>");
		}
		UserDAO userDAO = new UserDAO();
	//변수 받아서 login 함수로 보내버리기
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		String link = request.getParameter("link");// 1.23 배정훈 수정 전페이지의 링크 가져옴 
		if (result == 1) {
			session.setAttribute("userID", user.getUserID()); //유저 ID를 세션번호?로 지정해줌
			PrintWriter script = response.getWriter();	
			response.sendRedirect(link);// 1.23 배정훈 수정 로그인 성공시 가져온 링크로 이동 
		}
		else if (result == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
		else if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
		else if (result == -2) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다.');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
	%>
</body>

</html>