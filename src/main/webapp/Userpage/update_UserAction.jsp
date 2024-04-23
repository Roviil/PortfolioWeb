<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="user.UserDAO" %>
  <%@ page import="user.User" %>
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> 
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리끼리 게시판</title>
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
			script.println("location.href = 'http://localhost:8080/BBS/login.jsp'");
			script.println("</script>");
		}
		User user = new UserDAO().getUserdata(userID);
		if (!userID.equals(user.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('본인 외의 정보는 수정 불가능합니다.')");
			script.println("location.href = 'http://localhost:8080/BBS/main.jsp'");
			script.println("</script>");
		}
		else{
			if(request.getParameter("userPassword").replaceAll("\\s", "").equals("") || request.getParameter("userName").replaceAll("\\s", "").equals("") 
					|| request.getParameter("userGender").replaceAll("\\s", "").equals("") || request.getParameter("userEmail").replaceAll("\\s", "").equals("")
					|| request.getParameter("userNickname").replaceAll("\\s", "").equals("")
					|| request.getParameter("userPassword") == null || request.getParameter("userName") == null 
					|| request.getParameter("userGender") == null || request.getParameter("userEmail") == null 
					|| request.getParameter("userNickname") == null){ 
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{
				UserDAO userDAO = new UserDAO();
					int result = userDAO.updateUserdata(userID, request.getParameter("userPassword"), request.getParameter("userName"), 
							request.getParameter("userGender"), request.getParameter("userEmail"), request.getParameter("userNickname"));
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('회원 정보 수정에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else if (result == -2){ //닉네임이 겹치는 경우
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('해당 닉네임이 이미 존재합니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('회원정보를 수정했습니다.')");
						script.println("location.href='main_Userpage.jsp'");
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>