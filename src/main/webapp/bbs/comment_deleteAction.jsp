<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="COMMENT.CommentDAO" %>
<%@ page import="COMMENT.Comment" %>
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
		String bbsID = null;
		if(session.getAttribute("bbsID")!= null){ //유저 ID에 해당 세션 값 넣기
			userID = (String) session.getAttribute("bbsID");
		}
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
		}
		
		int comment_num = 0;
		if(request.getParameter("comment_num") != null){
			comment_num = Integer.parseInt(request.getParameter("comment_num"));
		}
		if(comment_num == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Comment comment = new CommentDAO().getComment(comment_num);
		if (!userID.equals(comment.getCOMMENT_userID())){ //글 작성자 본인이 아닐 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('댓글 작성자만 삭제 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //권한이 있는 사람이라면.
					CommentDAO commentDAO = new CommentDAO();
					int result = commentDAO.delete(comment_num); //삭제기능 수행
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('댓글 삭제에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('댓글을 삭제했습니다.')");
						script.println("</script>");
						String link = request.getHeader("referer");
						response.sendRedirect(link);
					}
		}
	%>
</body>

</html>