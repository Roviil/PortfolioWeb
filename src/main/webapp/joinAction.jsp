<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="user" class="user.User" scope="page" />
 <jsp:setProperty name="user" property="userID" /> <!-- user ID 받아오는거 -->
 <jsp:setProperty name="user" property="userPassword" />
 <jsp:setProperty name="user" property="userName" /> 
 <jsp:setProperty name="user" property="userGender" /> 
 <jsp:setProperty name="user" property="userEmail" /> 
 <jsp:setProperty name="user" property="userNickname" />
<!DOCTYPE html>
<html>

<!-- 로그인 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BBS</title>
</head>

<body>
	<%
		String userID = null;
		String link = request.getParameter("link");
		if(session.getAttribute("userID")!= null){ //유저 ID에 해당 세션 값 넣기
			userID = (String) session.getAttribute("userID");
		}
		String userNickname = null;
		if(session.getAttribute("userNickname")!= null){
			userNickname = (String) session.getAttribute("userNickname");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href='http://localhost:8080/BBS/main.jsp'");
			script.println("</script>");
			response.sendRedirect(link);
		}
			
		if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null || user.getUserNickname() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안된 곳이 있습니다!');");
			script.println("history.back()"); //이전 페이지로 되돌려보냄
			script.println("</script>");
		}
		else{
			UserDAO userDAO = new UserDAO();
			//변수 받아서 login 함수로 보내버리기
				int result = userDAO.join(user);
				int nickname_result = userDAO.name(userNickname);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('해당 ID가 이미 존재합니다.');");
					script.println("history.back()"); //이전 페이지로 되돌려보냄
					script.println("</script>");
				}
				//23.02.16 유말그미 닉네임 예외처리 시도
				if (nickname_result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('해당 닉네임 이미 존재합니다.');");
					script.println("history.back()");
					script.println("</script>");
				}
				else {
					session.setAttribute("userID", user.getUserID());
					PrintWriter script = response.getWriter();
					response.sendRedirect(link);
				}
		}
		

	%>
</body>

</html>