package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

@WebServlet("/BoardServlet")
public class BoardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		System.out.println("get 요청 들어옴.");
		
		int bno = Integer.parseInt(request.getParameter("board_num"));
//		System.out.println("get 요청 들어옴 : bno = " + bno);
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "testw11";
		String dbPw = "pass1234";
		Connection conn = null;
		try {
			Class.forName(driver);  // JDBC 드라이버 로딩.
			conn = DriverManager.getConnection(url, dbId, dbPw);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String sql = "UPDATE board SET title = title || '!' WHERE bno=?";
		String sql2 = "SELECT * FROM board WHERE bno=?";
		String title = "";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
			
			pstmt.setInt(1,  bno);
			pstmt2.setInt(1, bno);
			pstmt.executeUpdate();
			ResultSet rs = pstmt2.executeQuery();
			if(rs.next()) {
				title = rs.getString("title");
			}
			rs.close();
			pstmt2.close();
			pstmt.close();
			conn.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		response.setContentType("application/json");  // '응답을 json형식으로 만들겠다'는 선언
		PrintWriter out = response.getWriter();  // '응답'을 작성할 수 있는 writer를 얻음.
		JSONObject obj = new JSONObject();  // (json-simple 라이브러리)
		obj.put("result", "OK");
		obj.put("title", title);
		out.println(obj);
		
	}
}
