<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
	int bno = Integer.parseInt(request.getParameter("bno"));
	
%>
<%!
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "testw11";
		String dbPw = "pass1234";
	
		Class.forName(driver);  // JDBC 드라이버 로딩.
		Connection conn = DriverManager.getConnection(url, dbId, dbPw);
								// DB 접속을 시도 ---> Connection객체를 리턴.
		return conn;
	}
%>
<%
	Connection conn = getConnection();
	String sql = "DELETE FROM board WHERE bno=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, bno);
	pstmt.executeUpdate();
	
	pstmt.close();
	conn.close();
	
%>
<script>
	alert("삭제되었습니다");
	location.href = "Ex13BoardList.jsp";
</script>