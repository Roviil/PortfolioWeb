<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs_notice.Bbs_NoticeDAO" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="java.io.PrintWriter" %> 

 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="bbs_notice" class="bbs_notice.Bbs_Notice" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="bbs_notice" property="notice_bbsTitle" />
 <jsp:setProperty name="bbs_notice" property="notice_bbsContent" />
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
			if(bbs_notice.getNotice_bbsTitle() == null || bbs_notice.getNotice_bbsContent() == null || bbs_notice.getNotice_bbsContent().replaceAll("\\s", "").equals("") || bbs_notice.getNotice_bbsTitle().replaceAll("\\s", "").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				UserDAO userDAO = new UserDAO();
				String name = userDAO.nameserach(userID);//유저 닉네임 가져오기 
				Bbs_NoticeDAO bbs_noticeDAO = new Bbs_NoticeDAO();
					int result = bbs_noticeDAO.write(bbs_notice.getNotice_bbsTitle(), userID, bbs_notice.getNotice_bbsContent(), name);
					if (result == -1) { //데이터베이스 오류
						System.out.println(name);
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글쓰기에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'notice_bbs.jsp'"); //게시판으로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>