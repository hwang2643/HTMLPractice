<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	int pageNum = 0;
// 	String id = "";
	String id = request.getParameter("id");
	try{
		pageNum = Integer.parseInt(request.getParameter("page"));
		if(pageNum <= 0) {
			pageNum = 1;
		}
	} catch(NumberFormatException e) {
		pageNum = 1;
	}
	int endNum = pageNum * 15;
	int startNum = endNum - 14;
	
	String type = request.getParameter("type");
	String maintxt = request.getParameter("maintxt");
%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "project";
	String dbPw = "p1234";
%>
<%
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
	String sql = "";
	String sql2 = "";
	String sql3 = "";
	if(type.equals("new")) {
		sql = " SELECT g2.*"
			+ " FROM(SELECT rownum rnum, g1.*"
			+ " FROM(SELECT * FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif' ORDER BY goods_id) g1) g2"
			+ " WHERE g2.rnum>=? AND g2.rnum<=?";
		sql2 = " SELECT * FROM (SELECT * FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif' AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
		sql3 = " SELECT count(*) FROM goods WHERE new='https://www.fcseoul.com/resources/shop/_img/icon/icon_new.gif'";
	} else if(type.equals("sale")) {
		sql = " SELECT g2.*"
			+ " FROM(SELECT rownum rnum, g1.*"
			+ " FROM(SELECT * FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif' ORDER BY goods_id) g1) g2"
			+ " WHERE g2.rnum>=? AND g2.rnum<=?";
		sql2 = " SELECT * FROM (SELECT * FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif' AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
		sql3 = " SELECT count(*) FROM goods WHERE sale='https://www.fcseoul.com/resources/shop/_img/icon/icon_sale.gif'";
	} else if(type.equals("전체상품")) {
		sql = " SELECT g2.*"
			+ " FROM(SELECT rownum rnum, g1.*"
			+ " FROM(SELECT * FROM goods ORDER BY goods_id) g1) g2"
			+ " WHERE g2.rnum>=? AND g2.rnum<=?";
		sql2 = " SELECT * FROM (SELECT * FROM goods WHERE best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
		sql3 = " SELECT count(*) FROM goods";
	} else if(type.equals("search")) {
		sql = " SELECT g2.*"
			+ " FROM(SELECT rownum rnum, g1.*"
			+ " FROM(SELECT * FROM goods WHERE goods_name LIKE ? ORDER BY goods_id) g1) g2"
			+ " WHERE g2.rnum>=? AND g2.rnum<=?";
		sql2 = " SELECT * FROM (SELECT * FROM goods WHERE goods_name LIKE ? AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
		sql3 = " SELECT count(*) FROM goods WHERE goods_name LIKE ?";
	} else {
		sql = " SELECT g2.*"
			+ " FROM(SELECT rownum rnum, g1.*"
			+ " FROM(SELECT * FROM goods WHERE type=? ORDER BY goods_id) g1) g2"
			+ " WHERE g2.rnum>=? AND g2.rnum<=?";
		sql2 = " SELECT * FROM (SELECT * FROM goods WHERE type=? AND best='https://www.fcseoul.com/resources/shop/_img/icon/icon_best.gif' ORDER BY goods_id) WHERE rownum<=4";
		sql3 = " SELECT count(*) FROM goods WHERE type=?";
	}
	
	
	PreparedStatement pstmt = conn.prepareStatement(sql);
	PreparedStatement pstmt2 = conn.prepareStatement(sql2);
	PreparedStatement pstmt3 = conn.prepareStatement(sql3);
	
	if(type.equals("new") || type.equals("sale") || type.equals("전체상품")) {
		pstmt.setInt(1, startNum);
		pstmt.setInt(2, endNum);
	} else if(type.equals("search")) {
		pstmt.setString(1, "%"+maintxt+"%");
		pstmt.setInt(2, startNum);
		pstmt.setInt(3, endNum);
		pstmt2.setString(1, "%"+maintxt+"%");
		pstmt3.setString(1, "%"+maintxt+"%");
	} else {
		pstmt.setString(1, type);
		pstmt.setInt(2, startNum);
		pstmt.setInt(3, endNum);
		pstmt2.setString(1, type);
		pstmt3.setString(1, type);
	}
	
	
	ResultSet rs = pstmt.executeQuery();
	ResultSet rs2 = pstmt2.executeQuery();
	ResultSet rs3 = pstmt3.executeQuery();
	
	int count = 0;
	if(rs3.next()) {
		count = rs3.getInt("count(*)");
	}
	rs3.close();
	pstmt3.close();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./EShopCateStyle.css">
	<script>
		function openBtn() {
			let btn1 = document.getElementById("btn1");
			let btn2 = document.getElementById("btn2");
			let dark = document.getElementById("bg_dark");
			if(btn1.style.display == "none") {
				btn1.style.display = "block";
				btn2.className = "category fl view_all on";
				dark.style.display = "block";
			}
		}
		function closeBtn() {
			let btn1 = document.getElementById("btn1");
			let btn2 = document.getElementById("btn2");
			let dark = document.getElementById("bg_dark");
			if(btn1.style.display == "block") {
				btn1.style.display = "none";
				btn2.className = "category fl view_all";
				dark.style.display = "none";
			}
		}
		function openFilter() {
			let btn1 = document.getElementById("filterBtn");
			let dark = document.getElementById("bg_dark");
			if(btn1.style.display == "none") {
				btn1.style.display = "block";
				dark.style.display = "block";
			}
		}
		function closeFilter() {
			let btn1 = document.getElementById("filterBtn");
			let dark = document.getElementById("bg_dark");
			if(btn1.style.display == "block") {
				btn1.style.display = "none";
				dark.style.display = "none";
			}
		}
	</script>
</head>
<body>
	<div id="uppermain">
		<div class="mainlogo fl" onclick="location.href='EShopMain.jsp'">
			<img src="https://www.fcseoul.com/resources/shop/_img/renew/logo.png"/>
		</div>
		<div class="searchbox fl">
			<form action="EShopCatePage.jsp" method="post">
				<input type="hidden" name="type" value="search"/>
				<input type="text" name="maintxt" id="maintxt"/>
				<button type="submit"></button>
			</form>
		</div>
		<div class="topmenu fl">
			<span>로그인</span>
			<span onclick="location.href='EShopMyPage.jsp?id=<%=id %>'">마이페이지</span>
			<span onclick="location.href='EShopCart.jsp?id=<%=id %>'">장바구니</span>
		</div>
		<div style="clear:both;"></div>
	</div>
	<div id="categorybackground">
		<div class="maincategory">
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=new'">
				<span>NEW</span>
			</div>
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=유니폼'">
				<span>유니폼</span>
			</div>
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=트레이닝웨어'">
				<span>트레이닝웨어</span>
			</div>
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=패션'">
				<span>패션</span>
			</div>
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=응원용품'">
				<span>응원용품</span>
			</div>
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=기념품'">
				<span>기념품</span>
			</div>
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=어린이'">
				<span>어린이</span>
			</div>
			<div class="category fl" onclick="location.href='EShopCatePage.jsp?id=<%=id%>&type=sale'">
				<span>SALE</span>
			</div>
			<div id="btn2" class="category fl view_all">
				<button type="button" onclick="openBtn()">전체메뉴</button>
			</div>
		</div>
		<div style="clear:both;"></div>
	</div>
	<div class="all_menu">
		<div id="btn1" class="all_menu_box" style="display: none;">
			<div class="all_content_box">
				<div class="all_category_box fl">
					<div class="cate_box_title">
						<span>카테고리</span>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=new">
							NEW
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=유니폼">
							유니폼
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=트레이닝웨어">
							트레이닝 웨어
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=패션">
							패션
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=응원용품">
							응원용품
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=기념품">
							기념품
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=어린이">
							어린이
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=sale">
							SALE
						</a>
					</div>
					<div>
						<a href="EShopCatePage.jsp?id=<%=id %>&type=전체상품">
							전체상품보기
						</a>
					</div>
				</div>
				<div class="all_mypage_box fl">
					<div class="mypage_box_title">
						<span>마이페이지</span>
					</div>
					<div>
						<a href="EShopOrderHistory.jsp?id=<%=id%>">
							나의주문이력
						</a>
					</div>
					<div>
						<a href="EShopCart.jsp?id=<%=id%>">
							장바구니
						</a>
					</div>
					<div>
						<a href="EShopWishList.jsp?id=<%=id%>">
							찜한상품
						</a>
					</div>
				</div>
				<div class="all_service_box fl">
					<div class="service_box_title">
						<span>고객센터</span>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/faqList">
							FAQ
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/qnaList">
							Q&A
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/notice">
							공지사항
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/terms">
							이용약관
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/privacy">
							개인정보
						</a>
					</div>
					<div style="clear:both;"></div>
				</div>
				<div class="close_button">
					<input type="button" onclick="closeBtn()"/>
					
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
	</div>
	<div class="menubar">
		<div class="qmenu">
			<span>QUICK MENU</span>
			<div class="m1">
				<a href="https://www.fcseoul.com/fcshop/mypage">
					<span>마이페이지</span>
				</a>
			</div>
			<div class="m2">
				<a href="https://www.fcseoul.com/fcshop/mypage">
					<span>장바구니</span>
				</a>
			</div>
			<div class="m3">
				<a href="https://www.fcseoul.com/fcshop/mypage">
					<span>찜한상품</span>
				</a>
			</div>
		</div>
		<div class="recentmenu">
			<span>최근 본 상품</span>
		</div>
	</div>
	<div id="filterBtn" class="filter_popup_wrap" style="display:none;">
		<div class="filter_popup">
			<h1>
				검색하기
				<button type="button" onclick="closeFilter();">닫기</button>
			</h1>
			<div class="fieldset">
				<div class="target_wrap">
					<div class="title">
						대상선택
					</div>
					<div class="check">
						<div class="fl">
							<input type="checkbox" id="a_target" value="A"/>
							<label for="a_target">전체</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="m_target" value="M"/>
							<label for="m_target">남자</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="f_target" value="F"/>
							<label for="f_target">여자</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="c_target" value="C"/>
							<label for="c_target">어린이</label>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
			<div class="fieldset">
				<div class="category_wrap">
					<div class="title">
						카테고리 선택
					</div>
					<div class="select_all">
						<input type="checkbox" id="a_category" name="category_all" value="ALL"/>
						<label for="a_category">전체선택</label>
					</div>
					<div class="check">
						<div class="fl">
							<input type="checkbox" id="n_category" value="NEW"/>
							<label for="n_category">NEW</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="uni_category" value="UNIFORM"/>
							<label for="uni_category">유니폼</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="tra_category" value="TRAINNING"/>
							<label for="tra_category">트레이닝웨어</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="p_category" value="PASSION"/>
							<label for="p_category">패션</label>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div class="check">
						<div class="fl">
							<input type="checkbox" id="t_category" value="TOOL"/>
							<label for="t_category">응원용품</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="sou_category" value="SOUVENIR"/>
							<label for="sou_category">기념품</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="c_category" value="CHILD"/>
							<label for="c_category">어린이</label>
						</div>
						<div class="fl">
							<input type="checkbox" id="s_category" value="SALE"/>
							<label for="s_category">SALE</label>
						</div>
						<div style="clear:both;"></div>
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
			<div class="fieldset">
				<div class="price_wrap">
					<div class="title">
						가격대 선택
					</div>
					<div class="check">
						<div class="price_sel fl">
							<input type="text" id="min_price"/>
							원~
							<input type="text" id="max_price"/>
							원
						</div>
						<div style="clear:both;"></div>
					</div>
					<div style="clear:both;"></div>
				</div>
			</div>
			<div class="sel_button_wrap">
				<a href="" onclick="" class="search_btn">검색하기</a>
				<a href="" onclick="" class="reset_btn">초기화</a>
			</div>
		</div>
	</div>
	<div class="main_container">
		<div class="content_wrap">
			<div class="main_content">
				<div class="content_title">
					<div class="mini_title">
						HOME > <span><%=type %></span>
					</div>
					<div class="title">
						<span><%=type %></span>
						<img src="https://www.fcseoul.com/resources/shop/_img/product/title_fcseoul.gif"/>
					</div>
				</div>
				<div class="best_wrap">
					<div class="best_box fl">
						<div class="best_img">
							<img src="https://www.fcseoul.com/resources/shop/_img/product/txt_bestproduct.gif"/>
						</div>
					</div>
					<%
					while(rs2.next()){
						String goodsImg2 = rs2.getString("goods_img");
						String goodsName2 = rs2.getString("goods_name");
						int price2 = rs2.getInt("price");
			 			String best2 = rs2.getString("best");
			 			String new2 = rs2.getString("new");
			 			int goodsId = rs2.getInt("goods_id");
					%>
					<div class="best_box fl">
						<div class="best_content">
							<a href="EShopDetail.jsp?id=<%=id %>&goodsId=<%=goodsId%>">
								<img src="<%=goodsImg2%>"/>
							</a>
							<div class="goods_name">
								<a href="EShopDetail.jsp?id=<%=id %>&goodsId=<%=goodsId%>"><%=goodsName2 %></a>
							</div>
							<div class="goods_price">
								<%=price2 %>원
							</div>
							<div class="goods_type">
								<img src="<%=best2%>" onerror="this.style.display='none'"/>
								<img src="<%=new2%>" onerror="this.style.display='none'"/>
							</div>
						</div>
					</div>
					<%
					}
					rs2.close();
					pstmt2.close();
					%>
				</div>
				<div class="type_content">
					<div class="filter_wrap">
						<div class="filter_box">
							<div class="filter_box_text fl">
								카테고리에 총 
								<span><%=count%>개</span>
								의 상품이 등록되어 있습니다.
							</div>
							<div class="filter_box_button">
								<button type="button" id="filterBtn" onclick="openFilter();">필터</button>
								<select name="order">
									<option value="ALL" selected="selected">기본</option>
									<option value="NEW">신상순</option>
									<option value="TOP">인기순</option>
									<option value="LOW">낮은가격순</option>
									<option value="HIGH">높은가격순</option>
								</select>
							</div>
							<div style="clear:both;"></div>
						</div>
					</div>
					<div class="type_content_box">
					<%
					while(rs.next()) { 
						String goodsImg = rs.getString("goods_img");
			 			String goodsName = rs.getString("goods_name");
			 			int price = rs.getInt("price");
			 			String cNew = rs.getString("new");
			 			String best = rs.getString("best");
			 			int goodsId = rs.getInt("goods_id");
					%>
						<div class="prd_list">
							<div class="prd_list_wrap">
								<div class="prd_img">
									<a href="EShopDetail.jsp?id=<%=id %>&goodsId=<%=goodsId%>">
										<img src="<%=goodsImg %>"/>
									</a>
								</div>
								<div class="goods_name">
									<a href="EShopDetail.jsp?id=<%=id %>&goodsId=<%=goodsId%>">
										<%=goodsName %>
									</a>
								</div>
								<div class="goods_price">
									<%=price %> 원 
								</div>
								<div class="goods_type">
									<img src="<%=cNew%>" onerror="this.style.display='none'"/>
									<img src="<%=best%>" onerror="this.style.display='none'"/>
								</div>
								<div style="clear:both;"></div>
							</div>
						</div>
					<%
					} 
					rs.close();
					pstmt.close();
					conn.close();
					%>
						<div style="clear:both;"></div>
						<div class="bottom_line">
						</div>
						<div class="mt20">
						</div>
						<div style="clear:both;"></div>
						<div class="page_box">
							<div class="page_btn">
								<a href="EShopCatePage.jsp?type=<%=type%>&page=1">
									<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_prev2.gif"/>
								</a>
								<a href="EShopCatePage.jsp?type=<%=type%>&page=<%=pageNum-1%>">
									<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_prev.gif"/>
								</a>
								&nbsp;&nbsp;
								<%
								for(int i=1; i<=(count/15)+1; i++) {
									if(pageNum == i) {
										%>
										<a href="EShopCatePage.jsp?type=<%=type %>&page=<%=i %>" class="pg">
											<b style="color:#d2232a"><%=i %></b>
										</a>
										<%
									} else {
										%>
										<a href="EShopCatePage.jsp?type=<%=type %>&page=<%=i %>" class="pg">
											<b><%=i %></b>
										</a>
										<%
									}
								}
								%>
								&nbsp;&nbsp;
								<%
								if(pageNum == (count/15)+1) {
									%>
									<a href="EShopCatePage.jsp?type=<%=type%>&page=<%=count/15+1%>">
										<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next.gif"/>
									</a>
									<%
								} else {
									%>
									<a href="EShopCatePage.jsp?type=<%=type%>&page=<%=pageNum+1%>">
										<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next.gif"/>
									</a>
									<%	
								}
								%>
								<a href="EShopCatePage.jsp?type=<%=type%>&page=<%=count/15+1%>">
									<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next2.gif"/>
								</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> 
	<div class="footer_wrap">
		<div class="mainfooter">
		<div class="botmenu">
			<div class="bmcontentbox">
				<div class="fl">
					<a href="https://www.fcseoul.com/" target="_blank">FC서울 홈페이지</a>
				</div>
				<div class="fl">
					<a href="https://www.fcseoul.com/fcshop/privacy" target="_blank">개인정보처리방침</a>
				</div>
				<div class="fl">
					<a href="https://www.fcseoul.com/fcshop/terms" target="_blank">이용약관</a>
				</div>
				<div class="fl">
					<a href="https://www.fcseoul.com/fcshop/faqList" target="_blank">고객센터</a>
				</div>
				
			</div>
		</div>
		<div class="footer">
			<div class="fcontentbox">
				<div>
			 		법인명(상호): 케이프온 주식회사
				</div>
				<div>
					대표자 : 민세중
				</div>
				<div>
					사업자등록번호: 644-81-00100
				</div>
			</div>
			<div class="fcontentbox">
				<div>
			 		FAX: 031-722-2056
				</div>
				<div>
					통신판매신고번호 : 제2020-성남중원-1061호
				</div>
			</div>
			<div class="fcontentbox">
				<div>
			 		<address>
							경기도 성남시 중원구 양현로 405번길 4-11
						</address>
				</div>
			</div>
			<div class="fcontentbox">
				<div>
			 		개인정보보호책임자 : 이재근
				</div>
				<div>
					이메일 : fcseoul@gssports.co.kr
				</div>
			</div>
			<p>
				Copyright ⓒ 2020 GS Sports Football Club Seoul
			</p>
		</div>
	</div>
	</div>
	<div id="bg_dark" class="bg_dark" style="display: none;"></div>
</body>
</html>