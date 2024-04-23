<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs_QnA.Bbs_QnA" %>
<%@ page import="bbs_QnA.Bbs_QnADAO" %>
<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale= 1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>LRAK</title>
</head>

<body>
<%@ include file="../nav/navbar.jsp" %>
	<%

		if(userID == null){ //ID값이 null이면 아직 로그인 안한거
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다')");
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
	%>
	
	<div class="container">
	<div class="row">
		<form method="post" action="update_QnAAction.jsp?QnA_bbsID=<%= qna_bbsID %>">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
			<thead>
				<tr>
					<th colspan="2" style="background-color: #eeeeee; text-align: center;">게시판 글 수정 양식</th>						
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" placeholder="글 제목" name="QnA_bbsTitle" maxlength="50" value="<%= QnA_bbs.getQna_bbsTitle() %>"></td>
				</tr>
				<tr>
					<td><textarea class="form-control" placeholder="글 내용" name="QnA_bbsContent" maxlength="2048" style="height: 350px"><%= QnA_bbs.getQna_bbsContent() %></textarea></td>						
				</tr>
			</tbody>
		</table>
		<input onclick="return confirm('수정하시겠습니까?')" type="submit" class="btn btn-primary pull-right" value="수정하기">
		</form>						
	</div>
</div>
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>