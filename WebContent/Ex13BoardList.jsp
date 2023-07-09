<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	int pageNum = 0;
	try{
		pageNum = Integer.parseInt(request.getParameter("page"));
	} catch(NumberFormatException e) {
		// pageNum을 1로 만들어
		pageNum = 1;
	}
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
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="js/jquery-3.7.0.min.js"></script>
	<script>
		$(function(){
			$("#btn_write").click(function(){
				location.href = "Ex13BoardWrite.jsp";
			});
			$("tr").click(function(){
				let bno = $(this).find(".bno").text();
				location.href = "Ex13BoardDetail.jsp?bno=" + bno;
			});
		});
	</script>
	<style>
		table {
			border-collapse: collapse;
		}
		th, td {
			border: 1px solid grey;
			padding: 8px;
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
			Connection conn = getConnection();
			
			String sql = " SELECT b2.*"
						+ " FROM(SELECT rownum rnum, b1.*"
						+ " FROM(SELECT * FROM board ORDER BY bno DESC) b1) b2"
						+ " WHERE b2.rnum>=? AND b2.rnum<=?";
			int endNum = pageNum * 10;
			int startNum = endNum - 9;
			PreparedStatement pstmt = conn.prepareStatement(sql);
								// PreparedStatement : sql문을 저장하고 실행하는 객체
								// conn.prepareStatement(...) : pstmt 객체를 만듦 & sql문을 장착함.
			pstmt.setInt(1, startNum);
								// pstmt.setInt(물음표번호, 정수값); --> 물음표를 그 값으로 치환
								// (참고) pstmt.setString(물음표번호, 문자열);
			pstmt.setInt(2, endNum);
			
			// [암기]
			// SELECT 문의 실행 ----> "ResultSet rs = pstmt.executeQuery();"
			// INSERT, UPDATE, DELETE 문의 실행 ----> "ResultSet rs = pstmt.executeUpdate();"
			ResultSet rs = pstmt.executeQuery();
							// rs손가락이 1번행 바로 위를 가리키고 있음! (중요)
			while(rs.next()){
						// rs,next() : rs손가락을 한줄 내리고
						// 			  가리키는 데이터가 존재하면 true를 리턴.
						// 			  가리키는 데이터가 존재하지 않으면 false를 리턴.
		%>
		<tr>
			<td class="bno"><%=rs.getInt("bno") %></td>
			<td><%=rs.getString("title") %></td>
			<td><%=rs.getString("writer") %></td>
			<td><%=rs.getString("writedate") %></td>
		</tr>
		<%
			}
		%>
	</table>
	<!-- Pagination(페이지네이션) -->
	<div style="padding-left: 100px;">
		<%
			for(int i=1; i<=8; i++) { 
				if(pageNum == i){
		%>
					<span><%=i %></span>
		<%
				}else {
		%>
					<a href="Ex13BoardList.jsp?page=<%=i%>"><%=i %></a>
		<%
				}
			}
		%>
<!-- 		<a href="Ex13BoardList.jsp?page=1">1</a> -->
<!-- 		<a href="Ex13BoardList.jsp?page=2">2</a> -->
<!-- 		<a href="Ex13BoardList.jsp?page=3">3</a> -->
<!-- 		<a href="Ex13BoardList.jsp?page=4">4</a> -->
<!-- 		<a href="Ex13BoardList.jsp?page=5">5</a> -->
<!-- 		<a href="Ex13BoardList.jsp?page=6">6</a> -->
<!-- 		<a href="Ex13BoardList.jsp?page=7">7</a> -->
	</div>
	<div>
		<button id="btn_write">글쓰기</button>
	</div>
</body>
</html>
<%
	rs.close();
	pstmt.close();
	conn.close();
%>