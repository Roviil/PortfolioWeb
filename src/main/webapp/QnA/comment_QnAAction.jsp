<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="COMMENT_QNA.Comment_QnADAO" %>
 <%@ page import="bbs_QnA.Bbs_QnA" %>
 <%@ page import="bbs_QnA.Bbs_QnADAO" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="COMMENT_QNA" class="COMMENT_QNA.Comment_QnA" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="COMMENT_QNA" property="COMMENT_comment" />
<!DOCTYPE html>
<html>

<!-- 글쓰기 기능 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>LRAK</title>
</head>

<body>
	<%
		Bbs_QnA bbs_qna = new Bbs_QnA();
		Comment_QnADAO Comment_QnADAO = new Comment_QnADAO();
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
			int qna_bbsID = 0;
			if(request.getParameter("QnA_bbsID") != null){ //bbsID가 존재한다면
				qna_bbsID = Integer.parseInt(request.getParameter("QnA_bbsID")); //bbsID에 그걸 담아서 처리할 수 있게 함
			}
			if(qna_bbsID == 0){ //0이니까 bbsID가 없는 경우임. 왜냐? 위에서 번호 담았으니까
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('유효하지 않은 글입니다.')");
				script.println("location.href = 'QnA_bbs.jsp'");
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
				Comment_QnADAO comment_QnADAO = new Comment_QnADAO();
					int result = comment_QnADAO.comment_write(userID, qna_bbsID, COMMENT_QNA.getCOMMENT_comment());
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
						script.println("location.href = 'QnA_view.jsp?QnA_bbsID="+qna_bbsID+"'"); //게시글로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>