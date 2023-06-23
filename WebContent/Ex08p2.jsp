<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int a = Integer.parseInt(request.getParameter("a"));
	int b = Integer.parseInt(request.getParameter("b"));
	int sum = Integer.parseInt(request.getParameter("sum"));
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		if((a+b) == sum) {
			out.println("정답!");
		}else {
			out.println("틀렸음!");
		}
	%>
</body>
</html>