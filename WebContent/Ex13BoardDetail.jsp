<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.BoardDao"%>
<%@ page import="dto.BoardDto"%>
<%@ page import="java.sql.*"%>

<%  // <% % > 까지 : 스크립틀릿.
	int bno = Integer.parseInt(request.getParameter("bno"));
	BoardDao bDao = new BoardDao();
	BoardDto boardDto = bDao.getBoardDto(bno);
%>
<%!  // <%! % > 까지 : 선언부(declaration).
	
%>
<%
	
	
	
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
			<td><%=bno %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td><%=boardDto.getTitle() %></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><%=boardDto.getContent() %></td>
		</tr>
		<tr>
			<th>작성자</th>
			<td><%=boardDto.getWriter() %></td>
		</tr>
		<tr>
			<th>작성일시</th>
			<td><%=boardDto.getWritedate() %></td>
		</tr>
		<tr>
			<td>
				<button type="button" onclick="location.href='Ex13BoardList.jsp'">목록으로</button>
				<button type="button" onclick="location.href='Ex13BoardUpdate.jsp?bno=<%=bno%>'">수정하기</button>
				<button type="button" onclick="location.href='Ex13BoardDeleteAction.jsp?bno=<%=bno%>'">삭제하기</button>
			</td>
		</tr>
	</table>
</body>
</html>