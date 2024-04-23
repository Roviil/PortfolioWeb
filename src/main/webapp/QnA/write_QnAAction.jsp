<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs_QnA.Bbs_QnADAO" %> <!-- bbs데이터 객체를 이용해서 받아오는 것 -->
<%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> <!-- 데이터를 UTF형식으로 받기 -->
 <jsp:useBean id="bbs_QnA" class="bbs_QnA.Bbs_QnA" scope="page" />
 <!-- 데이터 받아오는거 -->
 <jsp:setProperty name="bbs_QnA" property="qna_bbsTitle" />
 <jsp:setProperty name="bbs_QnA" property="qna_bbsContent" />



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
			if(bbs_QnA.getQna_bbsTitle() == null || bbs_QnA.getQna_bbsContent() == null || bbs_QnA.getQna_bbsContent().replaceAll("\\s", "").equals("") || bbs_QnA.getQna_bbsTitle().replaceAll("\\s", "").equals("")){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				Bbs_QnADAO bbs_qnaDAO = new Bbs_QnADAO();
					int result = bbs_qnaDAO.write(bbs_QnA.getQna_bbsTitle(), userID, bbs_QnA.getQna_bbsContent());
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
						script.println("location.href = 'QnA_bbs.jsp'"); //게시판으로 보냄
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>