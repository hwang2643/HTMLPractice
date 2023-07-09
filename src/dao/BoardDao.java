package dao;

import java.sql.*;

import dto.BoardDto;

public class BoardDao {
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
	public  BoardDto getBoardDto(int bno) throws Exception {
		Connection conn = getConnection();
		
		String sql = "SELECT * FROM board WHERE bno=?";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, bno);
		
		ResultSet rs = pstmt.executeQuery();
		
		BoardDto dto = null;
		if(rs.next()) {
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writer = rs.getString("writer");
			String writedate = rs.getString("writedate");
			dto = new BoardDto(bno, title, content, writer, writedate);
		}
		rs.close();
		pstmt.close();
		conn.close();
		return dto;
	}
}
