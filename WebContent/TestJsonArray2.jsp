<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "project";
	String dbPw = "p1234";
%>
<%
	HashMap<String, String> hashMap = new HashMap<>();
	JSONArray jsonArray = new JSONArray();
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
	String sql = "SELECT * FROM seat";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()) {
// 		hashMap = new HashMap<>();
		hashMap.put("section", rs.getString("section"));
		hashMap.put("x_start", rs.getString("x_start"));
		hashMap.put("x_end", rs.getString("x_end"));
		hashMap.put("y_start", rs.getString("y_start"));
		hashMap.put("y_end", rs.getString("y_end"));
		JSONObject seat = new JSONObject(hashMap);
		jsonArray.add(seat);
	}
	
	rs.close();
	pstmt.close();
	conn.close();
	
// 	out.println(jsonArray.toJSONString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		let jArr = <%=jsonArray%>
	</script>
</body>
</html>