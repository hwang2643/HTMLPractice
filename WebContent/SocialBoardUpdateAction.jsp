<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.SocialBoardUpdateDao"%>
    
<%
	String id = request.getParameter("id");
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	String writeBtn = request.getParameter("writeBtn");
	String rContent = request.getParameter("rContent");
	String comment = request.getParameter("comment");
	int bno = Integer.parseInt(request.getParameter("bno"));
	int answerNum = Integer.parseInt(request.getParameter("rno"));
	
	int pageNum = 0;
	try{
		pageNum = Integer.parseInt(request.getParameter("page"));
		if(pageNum <= 0) {
			pageNum = 1;
		}
	} catch(NumberFormatException e) {
		pageNum = 1;
	}
	int cnt = 0;
	
	
	
	SocialBoardUpdateDao sbUpdateDao = new SocialBoardUpdateDao();
	boolean socialInsert = false;
	boolean commentWrite = false;
	boolean nestedComment = false;
	boolean commentChange = false;
	boolean commentDelete = false;
// 	boolean rNumUpdate = false;
// 	boolean rOrderUpdate = false;
// 	int commentNumCheck = 0;
// 	int stepCheck = 0;
// 	int rNumCheck = 0;
	if(writeBtn.equals("등록")) {
		socialInsert = sbUpdateDao.socialWrite(id, title, content);
	} else if(comment.equals("mainComment")) {
		commentWrite = sbUpdateDao.commentWrite(id, bno, rContent);
	} else if(comment.equals("reComment")) {
		nestedComment = sbUpdateDao.nestedComment(id, bno, rContent, answerNum);
	} else if(comment.equals("updateComment")) {
		commentChange = sbUpdateDao.commentChange(answerNum, rContent);
	} else if(comment.equals("deleteComment")) {
		commentDelete = sbUpdateDao.commentDelete(id, bno, answerNum);
	}
	
	if(socialInsert) {
		cnt = 1;
	} else {
		cnt = 2;
	}
%>
<script>
	if(<%=cnt%> == 1) {
		alert("등록되었습니다.")
		location.href = "SocialBoard.jsp?id=<%=id%>&page=<%=pageNum%>&search=&searchBtn=";
	} else {
		location.href = "SocialBoardDetail.jsp?id=<%=id%>&bno=<%=bno%>&page=<%=pageNum%>";
	}
</script>