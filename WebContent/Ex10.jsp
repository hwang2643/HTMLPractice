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
<title>회원가입 연습</title>
</head>
<body>
	<h1>회원가입</h1>
	<form action="Ex10RegisterAction.jsp" method="post">
		아이디 : <input type="text"  name="id"/> <br/>
		피스워드 : <input type="password" name="pw"/> <br/>
		이름 : <input type="text" name="name"/> <br/>
		<input type="submit" value="입력완료"/>
		
	</form>
</body>
</html>