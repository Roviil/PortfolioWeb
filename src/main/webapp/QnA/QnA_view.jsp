<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs_QnA.Bbs_QnA" %>
<%@ page import="COMMENT_QNA.Comment_QnA" %>
<%@ page import="bbs_QnA.Bbs_QnADAO" %>
<%@ page import="COMMENT_QNA.Comment_QnADAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/view.css">

<title>LRAK</title>
</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
	<%
		int QnA_bbsID = 0;
		if(request.getParameter("QnA_bbsID") != null){ //bbsID가 존재한다면
			QnA_bbsID = Integer.parseInt(request.getParameter("QnA_bbsID")); //bbsID에 그걸 담아서 처리할 수 있게 함
		}
		if(QnA_bbsID == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'QnA_bbs.jsp'");
			script.println("</script>");
		}
		Bbs_QnA bbs_qna = new Bbs_QnADAO().getBbs_QnA(QnA_bbsID); //해당 글 가져옴
		if(bbs_qna == null){ //존재하지 않는 글일경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'QnA_bbs.jsp'");
			script.println("</script>");
		}
		if(bbs_qna.getQna_bbsAvailable() == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('삭제된 글입니다.')");
			script.println("location.href = 'QnA_bbs.jsp'");
			script.println("</script>");
		}
	%>
		

	<div class="container">
		<div class="row">
			<div class="main">
    			<h1 class="cho"><span>자유게시판</span></h1>
   				 <section class="board">
      				  <div class="header">
       				     <h3 class="title"><%= bbs_qna.getQna_bbsTitle()%></h3>
       				     <div class="info">
        			        <p>
        			        <span>작성자</span> <%= bbs_qna.getQna_userID() %>
           				    </p>
           				     <p><span>작성일</span>
           				       <%= bbs_qna.getQna_bbsDate().substring(0,11) + bbs_qna.getQna_bbsDate().substring(11, 13) + "시" + bbs_qna.getQna_bbsDate().substring(14,16) + "분" %>
           				     </p>
            			 </div>
      			 	 </div>
    				  <div class="body">
    				  	<div class="content">
    				  		<%= bbs_qna.getQna_bbsContent().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %>
    				  	</div>
    				  </div>
    				</section>
			</div>
			<%-- <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">글 보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글 제목</td>
						<td colspan="2"><%= bbs_qna.getQna_bbsTitle() %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs_qna.getQna_userID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs_qna.getQna_bbsDate().substring(0,11) + bbs_qna.getQna_bbsDate().substring(11, 13) + "시" + bbs_qna.getQna_bbsDate().substring(14,16) + "분" %></td>
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="height: 200px; text-align: center;">
						<%= bbs_qna.getQna_bbsContent().replaceAll("\" ", "&quot;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("&", "&amp;").replaceAll("\n", "<br>").replaceAll("\"", "&quot;") %></td>
					</tr>
				</tbody>	
			</table> --%>
			
			<div class="container">
				<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<thead>
							<tr>
								<th colspan="3" style="background-color: #eeeeee; text-align: center;">댓글</th>
							</tr>
						</thead>
					<%
						Comment_QnADAO Comment_QnADAO = new Comment_QnADAO();
						ArrayList<Comment_QnA> list = Comment_QnADAO.comment_getList(QnA_bbsID);
						for(int i = list.size()-1; i>=0; i--){
					%>

					 <tbody>
					 	<tr style="background-color: transparent;">
					 	<td><%= list.get(i).getCOMMENT_userID() %></td>
					 	<td style="text-align: center;"><%= list.get(i).getCOMMENT_comment() %></td>
					 	<td style="text-align: end; font-size: 10px; color: gray;"><%= list.get(i).getCOMMENT_date().substring(0,11) + list.get(i).getCOMMENT_date().substring(11, 13) + "시" + list.get(i).getCOMMENT_date().substring(14,16) + "분" %></td>
					 	</tr>
					</tbody>

					<%
						}
					%>
				</table>
				</div>
			</div>
			
			<!-- 댓글입력 -->
				<%
				if (userID != null) {
				%>
				<div class="container">
					<div class="row">
						<form method="post" action="comment_QnAAction.jsp?QnA_bbsID=<%= QnA_bbsID %>">
							<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
								<tbody>
									<tr>						
										<td><textarea class="form-control" placeholder="댓글을 입력하세요." name="COMMENT_comment" maxlength="300" style="height: 100px"></textarea></td>
									</tr>
								</tbody>
							</table>
							<input type="submit" class="btn btn-primary pull-right" id="btns" value="댓글쓰기">
						</form>
						<a onclick="history.back()" class="btn btn-primary" id="btns">뒤로가기</a>
						<a href = "QnA_bbs.jsp" class="btn btn-primary" id="btns">목록</a> <!-- 글 목록으로 되돌아가기 -->
					<%
						if (userID != null && userID.equals(bbs_qna.getQna_userID())){ //만약 글 쓴 유저가 해당 유저라면 글 수정, 삭제 가능하게 하기
					%>	
						<a href="QnA_update.jsp?QnA_bbsID=<%= QnA_bbsID %>" class="btn btn-primary" id="btns">글 수정</a>
						<a onclick="return confirm('삭제하시겠습니까?')" href="delete_QnAAction.jsp?QnA_bbsID=<%= QnA_bbsID %>" class="btn btn-primary" id="btns">삭제</a>
					<%
						}	
					%>
					</div>
				</div>
					
				<%
				}
				else {
					%>
					<p class="container table table-striped" style="text-align: center; border: 1px solid #dddddd">댓글 작성을 위해서 <a href="http://localhost:8080/BBS/login.jsp">로그인이 필요합니다.</a></p>
				<%
				}
				%>
			
			
		</div>
	</div>	
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>