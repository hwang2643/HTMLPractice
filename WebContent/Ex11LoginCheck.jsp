<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "testw11";
	String dbPw = "pass1234";
%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
	String sql = "SELECT * FROM member";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	String idCheck = "";
	String pwCheck = "";
	boolean b = false;
	ResultSet rs = pstmt.executeQuery();
	while(rs.next()) {
		idCheck = rs.getString("id");
		pwCheck = rs.getString("pw");
		if(idCheck.equals(id) && pwCheck.equals(pw)) {
			b = true;
		}
	}
	rs.close();
	pstmt.close();
	conn.close();
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="js/jquery-3.7.0.min.js"></script>
	<script>
		$(function(){
			$(".loginFail").ready(function(){
				alert("로그인에 실패하였습니다.");
				$(location).attr("href", "Ex11.jsp");
			});
		});
	</script>
</head>
<body>
	<%
		if(b){
	%>
		<h1>로그인 되었습니다!</h1>
	<%
		} else {
	%>
		<div class="loginFail"></div>
	<%
		}
	%>
</body>
</html>