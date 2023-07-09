package dao;

import java.sql.*;
import java.sql.DriverManager;
import java.util.ArrayList;

import dto.EShopCatePageDto;

public class EShopCatePageDao {
	public Connection getConnection() throws Exception {
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "project";
		String dbPw = "p1234";
	
		Class.forName(driver);  // JDBC 드라이버 로딩.
		Connection conn = DriverManager.getConnection(url, dbId, dbPw);
								// DB 접속을 시도 ---> Connection객체를 리턴.
		return conn;
	}
	public ArrayList<EShopCatePageDto> EShopCateMainPrd(String type, int startNum, int endNum) {
		ArrayList<EShopCatePageDto> EShopCateMainList = new ArrayList<EShopCatePageDto>();
		try {
			Connection conn = getConnection();
			
			String sql = "";
			if(type.equals("new")) {
				sql = " SELECT g2.*"
					+ " FROM(SELECT rownum rnum, g1.*"
					+ " FROM(SELECT * FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif' ORDER BY goods_id) g1) g2"
					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
			} else if(type.equals("sale")) {
				sql = " SELECT g2.*"
					+ " FROM(SELECT rownum rnum, g1.*"
					+ " FROM(SELECT * FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif' ORDER BY goods_id) g1) g2"
					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
			} else if(type.equals("전체상품")) {
				sql = " SELECT g2.*"
					+ " FROM(SELECT rownum rnum, g1.*"
					+ " FROM(SELECT * FROM goods ORDER BY goods_id) g1) g2"
					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
			} else {
				sql = " SELECT g2.*"
					+ " FROM(SELECT rownum rnum, g1.*"
					+ " FROM(SELECT * FROM goods WHERE type=? ORDER BY goods_id) g1) g2"
					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
			}
			
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			if(type.equals("new") || type.equals("sale") || type.equals("전체상품")) {
				pstmt.setInt(1, startNum);
				pstmt.setInt(2, endNum);
			} else {
				pstmt.setString(1, type);
				pstmt.setInt(2, startNum);
				pstmt.setInt(3, endNum);
			}
			
			
			ResultSet rs = pstmt.executeQuery();
			int goodsId = 0;
			String goodsImg = "";
			String goodsName = "";
			String bestP = "";
			String newP = "";
			int price = 0;
			int count = 0;
			
			
			while(rs.next()) { 
				EShopCatePageDto escpDto = new EShopCatePageDto(goodsId, goodsImg, goodsName, bestP, newP, price, count);
				escpDto.setGoodsImg(rs.getString("goods_img"));
				escpDto.setGoodsName(rs.getString("goods_name"));
				escpDto.setPrice(rs.getInt("price"));
	 			escpDto.setBestP(rs.getString("best"));
	 			escpDto.setNewP(rs.getString("new"));
	 			escpDto.setGoodsId(rs.getInt("goods_id"));
	 			escpDto.setCount(count);
	 			EShopCateMainList.add(escpDto);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return EShopCateMainList;
	}
	
	public ArrayList<EShopCatePageDto> EShopCateBestPrd(String type, int startNum, int endNum) {
		ArrayList<EShopCatePageDto> EShopCateBestList = new ArrayList<EShopCatePageDto>();
		try {
			Connection conn = getConnection();
			
			String sql = "";
			if(type.equals("new")) {
				sql = " SELECT * FROM (SELECT * FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif' AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
			} else if(type.equals("sale")) {
				sql = " SELECT * FROM (SELECT * FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif' AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
			} else if(type.equals("전체상품")) {
				sql = " SELECT * FROM (SELECT * FROM goods WHERE best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
			} else {
				sql = " SELECT * FROM (SELECT * FROM goods WHERE type=? AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
			}
			
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			if(!(type.equals("new") || type.equals("sale") || type.equals("전체상품"))) {
				pstmt.setString(1, type);
			}
			
			
			ResultSet rs = pstmt.executeQuery();
			int goodsId = 0;
			String goodsImg = "";
			String goodsName = "";
			String bestP = "";
			String newP = "";
			int price = 0;
			int count = 0;
			
			
			while(rs.next()) { 
				EShopCatePageDto escpDto = new EShopCatePageDto(goodsId, goodsImg, goodsName, bestP, newP, price, count);
				escpDto.setGoodsImg(rs.getString("goods_img"));
				escpDto.setGoodsName(rs.getString("goods_name"));
				escpDto.setPrice(rs.getInt("price"));
				escpDto.setBestP(rs.getString("best"));
				escpDto.setNewP(rs.getString("new"));
				escpDto.setGoodsId(rs.getInt("goods_id"));
				escpDto.setCount(count);
				EShopCateBestList.add(escpDto);
			}
			
			rs.close();
			pstmt.close();
			conn.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return EShopCateBestList;
	}
//	public ArrayList<EShopCatePageDto> EShopCatePageSelect(String type, int startNum, int endNum) throws Exception {
//		ArrayList<EShopCatePageDto> EShopCateList = new ArrayList<EShopCatePageDto>();
//		try {
//			Connection conn = getConnection();
//			String sql = "";
//			String sql2 = "";
//			String sql3 = "";
//			if(type.equals("new")) {
//				sql = " SELECT g2.*"
//					+ " FROM(SELECT rownum rnum, g1.*"
//					+ " FROM(SELECT * FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif' ORDER BY goods_id) g1) g2"
//					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
//				sql2 = " SELECT * FROM (SELECT * FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif' AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
//				sql3 = " SELECT count(*) FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif'";
//			} else if(type.equals("sale")) {
//				sql = " SELECT g2.*"
//					+ " FROM(SELECT rownum rnum, g1.*"
//					+ " FROM(SELECT * FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif' ORDER BY goods_id) g1) g2"
//					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
//				sql2 = " SELECT * FROM (SELECT * FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif' AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
//				sql3 = " SELECT count(*) FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif'";
//			} else if(type.equals("전체상품")) {
//				sql = " SELECT g2.*"
//					+ " FROM(SELECT rownum rnum, g1.*"
//					+ " FROM(SELECT * FROM goods ORDER BY goods_id) g1) g2"
//					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
//				sql2 = " SELECT * FROM (SELECT * FROM goods WHERE best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
//				sql3 = " SELECT count(*) FROM goods";
//			} else {
//				sql = " SELECT g2.*"
//					+ " FROM(SELECT rownum rnum, g1.*"
//					+ " FROM(SELECT * FROM goods WHERE type=? ORDER BY goods_id) g1) g2"
//					+ " WHERE g2.rnum>=? AND g2.rnum<=?";
//				sql2 = " SELECT * FROM (SELECT * FROM goods WHERE type=? AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
//				sql3 = " SELECT count(*) FROM goods WHERE type=?";
//			}
//			
//			
//			PreparedStatement pstmt = conn.prepareStatement(sql);
//			PreparedStatement pstmt2 = conn.prepareStatement(sql2);
//			PreparedStatement pstmt3 = conn.prepareStatement(sql3);
//			
//			if(type.equals("new") || type.equals("sale") || type.equals("전체상품")) {
//				pstmt.setInt(1, startNum);
//				pstmt.setInt(2, endNum);
//			} else {
//				pstmt.setString(1, type);
//				pstmt.setInt(2, startNum);
//				pstmt.setInt(3, endNum);
//				pstmt2.setString(1, type);
//				pstmt3.setString(1, type);
//			}
//			
//			
//			ResultSet rs = pstmt.executeQuery();
//			ResultSet rs2 = pstmt2.executeQuery();
//			ResultSet rs3 = pstmt3.executeQuery();
//			int goodsId = 0;
//			String goodsImg = "";
//			String goodsName = "";
//			String bestP = "";
//			String newP = "";
//			int price = 0;
//			int goodsId2 = 0;
//			String goodsImg2 = "";
//			String goodsName2 = "";
//			String bestP2 = "";
//			String newP2 = "";
//			int price2 = 0;
//			int count = 0;
//			if(rs3.next()) {
//				EShopCatePageDto countDto = new EShopCatePageDto(goodsId, goodsImg, goodsName, bestP, newP, price, goodsId2, goodsImg2, goodsName2, bestP2, newP2, price2, count);
//				countDto.setCount(rs3.getInt("count(*)"));
//				EShopCateList.add(countDto);
//			}
//			rs3.close();
//			pstmt3.close();
//			
//			while(rs2.next()){
//				EShopCatePageDto escpDto = new EShopCatePageDto(goodsId, goodsImg, goodsName, bestP, newP, price, goodsId2, goodsImg2, goodsName2, bestP2, newP2, price2, count);
//				escpDto.setGoodsImg(rs2.getString("goods_img"));
//				escpDto.setGoodsName(rs2.getString("goods_name"));
//				escpDto.setPrice(rs2.getInt("price"));
//	 			escpDto.setBestP(rs2.getString("best"));
//	 			escpDto.setNewP(rs2.getString("new"));
//	 			escpDto.setGoodsId(rs2.getInt("goods_id"));
//	 			EShopCateList.add(escpDto);
//			}
//			rs2.close();
//			pstmt.close();
//			
//			while(rs.next()) { 
//				EShopCatePageDto escpDto = new EShopCatePageDto(goodsId, goodsImg, goodsName, bestP, newP, price, goodsId2, goodsImg2, goodsName2, bestP2, newP2, price2, count);
//				escpDto.setGoodsImg2(rs.getString("goods_img"));
//				escpDto.setGoodsName2(rs.getString("goods_name"));
//				escpDto.setPrice2(rs.getInt("price"));
//	 			escpDto.setBestP2(rs.getString("best"));
//	 			escpDto.setNewP2(rs.getString("new"));
//	 			escpDto.setGoodsId2(rs.getInt("goods_id"));
//	 			EShopCateList.add(escpDto);
//			}
//			rs.close();
//			pstmt.close();
//			conn.close();
//			
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//		return EShopCateList;
//	}
}
