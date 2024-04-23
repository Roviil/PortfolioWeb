<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="bbs_notice.Bbs_NoticeDAO" %>
  <%@ page import="bbs_notice.Bbs_Notice" %>
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
			script.println("location.href = '../login.jsp'");
			script.println("</script>");
		}
		
		int notice_bbsID = 0;
		if(request.getParameter("Notice_bbsID") != null){ //bbsID가 존재한다면
			notice_bbsID = Integer.parseInt(request.getParameter("Notice_bbsID")); //bbsID에 그걸 담아서 처리할 수 있게 함
		}
		if(notice_bbsID == 0){ //0이니까 bbsID가 없는 경우임. 왜냐? 위에서 번호 담았으니까
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs_Notice Notice_bbs = new Bbs_NoticeDAO().getBbs_Notice(notice_bbsID);
		if (!userID.equals(Notice_bbs.getNotice_userID())){ //글 작성자 본인이 아닐 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 작성자만 수정 가능합니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else{ //권한이 있는 사람이라면.
			if(request.getParameter("Notice_bbsTitle").replaceAll("\\s", "").equals("") || request.getParameter("Notice_bbsContent").replaceAll("\\s", "").equals("")
					|| request.getParameter("Notice_bbsTitle") == null || request.getParameter("Notice_bbsContent") == null){ 
				//null값이거나 빈칸인게 하나라도 있는 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			else{ //입력이 됐다면 데이터베이스로 보내버리기
				Bbs_NoticeDAO notice_bbsDAO = new Bbs_NoticeDAO();
					int result = notice_bbsDAO.update(notice_bbsID, request.getParameter("Notice_bbsTitle"), request.getParameter("Notice_bbsContent"));
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
						script.println("location.href='notice_view.jsp?Notice_bbsID="+notice_bbsID+"'");
						script.println("</script>");
					}
				}
		}
	%>
</body>

</html>