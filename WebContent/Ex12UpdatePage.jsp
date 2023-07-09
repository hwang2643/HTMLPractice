<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	int bno = Integer.parseInt(request.getParameter("bno"));
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<form action="Ex12UpdateAction.jsp" method="post">
		<table>
			<tr>
				<th>글 번호</th>
				<td name="bno"><%=bno %></td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title"/></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="content"></textarea></td>
			</tr>
			<tr>
				<td>
					<input type="submit" value="수정하기"/>
				</td>
			</tr>
		</table>
	</form>
</body>
</html>