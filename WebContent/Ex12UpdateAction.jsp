<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "testw11";
	String dbPw = "pass1234";
%>
<%
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
	String sql = "UPDATE board SET title=?, content=? WHERE bno=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, title);
	pstmt.setString(2, content);
	pstmt.setInt(3, bno);
	
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
%>
   
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<table>
			<tr>
				<th>글 번호</th>
				<td><%=bno %></td>
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
					<button id="btn_update_comp"></button>
				</td>
			</tr>
		</table>
</body>
</html>
