<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="COMMENT.CommentDAO" %>
 <%@ page import="bbs.Bbs" %>
  <%@ page import="bbs.BbsDAO" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
 <%@ page import="java.io.PrintWriter" %> 
 <%@ page import="user.User" %>
 <%@ page import="user.UserDAO" %>
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="COMMENT" class="COMMENT.Comment" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="COMMENT" property="COMMENT_comment" />
<!DOCTYPE html>
<html>

<!-- 글쓰기 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>우리끼리 게시판</title>
</head>

<body>
	<%
		Bbs bbs = new Bbs();
		CommentDAO CommentDAO = new CommentDAO();
		String userID = null;
		if(session.getAttribute("userID")!= null){ //유저 ID에 해당 세션 값 넣기
			userID = (String) session.getAttribute("userID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
		}
		else{
			int bbsID = 0;
			if(request.getParameter("bbsID") != null){ //bbsID가 존재한다면
				bbsID = Integer.parseInt(request.getParameter("bbsID")); //bbsID에 그걸 담아서 처리할 수 있게 함
			}
			if(bbsID == 0){ //0이니까 bbsID가 없는 경우임. 왜냐? 위에서 번호 담았으니까
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
			//뭔가 입력이 안됐을때
			if(request.getParameter("COMMENT_comment").replaceAll("\\s", "").equals("") || request.getParameter("COMMENT_comment") == null){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 

			else{ //입력이 됐다면 데이터베이스로 보내버리기
				UserDAO userDAO = new UserDAO();
				String name = userDAO.nameserach(userID);//닉네임가져와서 데이터베이스로 저장 
				CommentDAO commentDAO = new CommentDAO();
					int result = commentDAO.comment_write(userID, bbsID, COMMENT.getCOMMENT_comment(), name);
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('댓글쓰기에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("location.href = 'view.jsp?bbsID="+bbsID+"'"); //게시글로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>