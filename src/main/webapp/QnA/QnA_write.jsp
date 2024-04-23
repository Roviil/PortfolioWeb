<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>LRAK</title>
</head>
<body>
<%@ include file="../nav/navbar.jsp" %>

	<div class="container">
		<div class="row">
		<form method="post" action="write_QnAAction.jsp">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style ="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식 </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type= "text" class="form-control" placeholder="질문 제목" name="qna_bbsTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="질문 내용" name="qna_bbsContent" maxlength="2048" style="height:350px;"></textarea></td>
					</tr>
				</tbody>
				
			</table>
			<input type="submit" class = "btn btn-primary pull-right" value="제출">
		
		
		</form>
			
		</div>
	</div>
	
	
 
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.6/umd/popper.min.js" integrity="sha384-wHAiFfRlMFy6i5SRaxvfOCifBUQy1xHdJ/yoi7FRNXMRBu5WHdZYu1hA6ZOblgut" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/js/bootstrap.min.js" integrity="sha384-B0UglyR+jN6CkvvICOB2joaf5I4l3gm9GU6Hc1og6Ls7i6U/mkkaduKaBhlAXv9k" crossorigin="anonymous"></script>

</body>
</html>