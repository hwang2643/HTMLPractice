<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.BoardDao"%>
<%@ page import="dto.BoardDto"%>
<%@ page import="java.util.ArrayList"%>
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
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="js/jquery-3.7.0.min.js"></script>
	<script>
		let g1;
		let page_request = <%=pageNum%>;
		function request_one_page() {
			page_request += 1;
			// ajax --> 한페이지 요청.
			$.ajax({
				type: 'get',
				url: 'BoardServlet2',
				data: { 'pageNum': page_request },
				datatype: 'json',
				success: function(data) {
					for(var i=0; i<=data.length-1; i++) {
						let str = "<tr>"
								+ "<td>" + data[i].bno + "</td>"
								+ "<td>" + data[i].title + "</td>"
								+ "<td>" + data[i].writer + "</td>"
								+ "<td>" + data[i].writedate + "</td>"
								+ "<tr>";
						$("#table1").append(str);
					}
				},
				error: function(r, s ,e) {
					alert("에러!");
				}
			});
		}
		$(function(){
			$(window).scroll(function(){
			  var scrT = $(window).scrollTop();
			  console.log(scrT); //스크롤 값 확인용
			  if(scrT == $(document).height() - $(window).height()){
			  	//스크롤이 끝에 도달했을때 실행될 이벤트
			  	request_one_page();
			  }
			});
			
			
// 			$("#btn_write").click(function(){
// 				location.href = "Ex13BoardWrite.jsp";
// 			});
// 			$("tr").click(function(){
// 				let bno = $(this).find(".bno").text();
// 				location.href = "Ex13BoardDetail.jsp?bno=" + bno;
// 			});
			
		});
	</script>
	<style>
		table {
			border-collapse: collapse;
		}
		th, td {
			border: 1px solid grey;
			padding: 8px;
			height: 50px;
		}
	</style>
</head>
<body>
	<table id="table1">
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일시</th>
		</tr>
		<%
			BoardDao boardDao = new BoardDao();
			ArrayList<BoardDto> boardList = boardDao.getBoardListByPageNum(pageNum);
			for(BoardDto bDto : boardList) { 
		%>
			<tr>
				<td class="bno"><%=bDto.getBno() %></td>
				<td><%=bDto.getTitle() %></td>
				<td><%=bDto.getWriter() %></td>
				<td><%=bDto.getWritedate() %></td>
			</tr>
		<%				
 			}
 		%>
	</table>
	<!-- Pagination(페이지네이션) -->
<!-- 	<div style="padding-left: 100px;"> -->
<%-- 		<% --%>
<!-- // 			for(int i=1; i<=8; i++) {  -->
<!-- // 				if(pageNum == i){ -->
<%-- 		%> --%>
<%-- 					<span><%=i %></span> --%>
<%-- 		<% --%>
<!-- // 				}else { -->
<%-- 		%> --%>
<%-- 					<a href="Ex13BoardList.jsp?page=<%=i%>"><%=i %></a> --%>
<%-- 		<% --%>
<!-- // 				} -->
<!-- // 			} -->
<%-- 		%> --%>
<!-- 	</div> -->
<!-- 	<div> -->
<!-- 		<button id="btn_write">글쓰기</button> -->
<!-- 	</div> -->
</body>
</html>
