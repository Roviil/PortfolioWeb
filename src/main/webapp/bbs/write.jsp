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
		<form method="post" action="writeAction.jsp">
			<table class="table table-striped" style="text-align: center; border:1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="2" style ="background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식 </th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type= "text" class="form-control" placeholder="제목" name="bbsTitle" maxlength="50"></td>
					</tr>
					<tr>
						<td><textarea class="form-control" placeholder="내용" name="bbsContent" maxlength="2048" style="height:350px;"></textarea></td>
					</tr>
				</tbody>
				
			</table>
			<input type="submit" class = "btn btn-primary pull-right" value="제출">
		
		
		</form>
			
		</div>
	</div>
	
	
 
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
	<script src="../js/bootstrap.min.js"></script>

</body>
</html>