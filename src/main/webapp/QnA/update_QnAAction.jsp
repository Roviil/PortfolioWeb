<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bbs_QnA.Bbs_QnADAO" %>
  <%@ page import="bbs_QnA.Bbs_QnA" %>
 <%@ page import="java.io.PrintWriter" %> 
 <% request.setCharacterEncoding("UTF-8"); %> 
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
		
		int qna_bbsID = 0;
		if(request.getParameter("QnA_bbsID") != null){ //bbsID가 존재한다면
			qna_bbsID = Integer.parseInt(request.getParameter("QnA_bbsID")); //bbsID에 그걸 담아서 처리할 수 있게 함
		}
		if(qna_bbsID == 0){ //0이니까 bbsID가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs_QnA QnA_bbs = new Bbs_QnADAO().getBbs_QnA(qna_bbsID);
		if (!userID.equals(QnA_bbs.getQna_userID())){ //글 작성자 본인이 아닐 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 작성자만 수정 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //권한이 있는 사람이라면.
			if(request.getParameter("QnA_bbsTitle").replaceAll("\\s", "").equals("") || request.getParameter("QnA_bbsContent").replaceAll("\\s", "").equals("")
					|| request.getParameter("QnA_bbsTitle") == null || request.getParameter("QnA_bbsContent") == null){ 
				//null값이거나 빈칸인게 하나라도 있는 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				Bbs_QnADAO QnA_bbsDAO = new Bbs_QnADAO();
					int result = QnA_bbsDAO.update(qna_bbsID, request.getParameter("QnA_bbsTitle"), request.getParameter("QnA_bbsContent"));
					if (result == -1) { //데이터베이스 오류
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글 수정에 실패했습니다.')");
						script.println("history.back()"); //이전 페이지로 되돌려보냄
						script.println("</script>");
					}
					else {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('글을 수정했습니다.')");
						script.println("location.href='QnA_view.jsp?QnA_bbsID="+qna_bbsID+"'");
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>