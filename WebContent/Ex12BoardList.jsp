<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "testw11";
	String dbPw = "pass1234";
%>
<%
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Ex12BoardList</title>
	<script src="js/jquery-3.7.0.min.js"></script>
	<script>
		$(function(){
			$("table tr").click(function(){
				let bno = $(this).find(".bno").text();
				location.href = "Ex12BoardDetail.jsp?bno=" + bno;
			});
		});
	</script>
	<style>
		table {
			border-collapse: collapse;
		}
		tr {
			cursor: pointer;
		}
		th, td {
			border: 1px solid grey;
			padding: 8px;
		}
		th {
			background-color: #e0e0e0;
		}
	</style>
</head>
<body>
	<table>
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일시</th>
		</tr>
		<% 
			String sql = "SELECT * FROM board ORDER BY bno DESC";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) { 
		%>
		<tr>
			<td class="bno"><%=rs.getInt("bno") %></td>
			<td><%=rs.getString("title") %></td>
			<td><%=rs.getString("writer") %></td>
			<td><%=rs.getString("writedate") %></td>
		</tr>
		<% } %>
	</table>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>