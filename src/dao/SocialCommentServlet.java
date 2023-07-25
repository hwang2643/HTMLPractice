package dao;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/SocialCommentServlet")
public class SocialCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
		
		response.setContentType("application/json");  // '응답을 json형식으로 만들겠다'는 선언
		PrintWriter out = response.getWriter();  // '응답'을 작성할 수 있는 writer를 얻음.
		JSONObject obj = new JSONObject(); 
		obj.put("rContent", rContent);
		out.println(obj);
		System.out.println(rContent);
	}

}
