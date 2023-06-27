<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "testw11";
	String dbPw = "pass1234";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="Ex11LoginCheck.jsp" method="post">
		로그인
		<label for="lId">ID : </label>
		<input type="text" name="id" id="lId"/> <br/>
		<label for="lPw">PW : </label>
		<input type="password" name="pw" id="lPw"/> <br/>
		<input type="submit" value="[로그인]"/>
	</form>
</body>
</html>