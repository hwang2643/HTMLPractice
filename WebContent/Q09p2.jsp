<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "hr";
	String dbPw = "hr";
%>    
<%
	String name = request.getParameter("name");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style>
		table {
			border-collapse: collapse;
		}
		tr, td {
			border: 1px solid black;
			padding: 10px;
		}
	</style>
</head>
<body>
	<%
	Connection conn = null;
	// 1. Connection 객체 얻기
	try{
		Class.forName(driver);
		conn = DriverManager.getConnection(url, dbId, dbPw);
	} catch(Exception e) {
		e.printStackTrace();
	}
	// 2. PreparedStatment 객체
	String sql = "SELECT * FROM employees WHERE first_name=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, name);
	ResultSet rs = pstmt.executeQuery();
	%>	
		<table>
			<tr>
				<td>
					이름
				</td>
				<td>
					성
				</td>
				<td>
					급여
				</td>
			</tr>
	<%	
		while(rs.next()) {
	%>
			<tr>
				<td>
					<%=rs.getString("first_name") %> 
				</td>
				<td>
					<%=rs.getString("last_name") %> 
				</td>
				<td>
					<%=rs.getInt("salary") %>
				</td>
			</tr>
	<%
		}
	%>
		</table>
	<%
		rs.close();
		pstmt.close();
		conn.close();
	%>
</body>
</html>