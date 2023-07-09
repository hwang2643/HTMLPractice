<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="dto.EShopOrderHistoryDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.EShopOrderHistoryDao"%>
    
<%
	String id = request.getParameter("id");
// 	String id = "hjw2643";
	
	EShopOrderHistoryDao OHDao = new EShopOrderHistoryDao();
	ArrayList<EShopOrderHistoryDto> OHList = OHDao.orderHistory(id);
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./EShopOrderHistory.css">
	<script src="js/jquery-3.7.0.min.js"></script>
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
		function dTabOn() {
			let dTab = document.getElementById("d_tab");
			let cTab = document.getElementById("c_tab");
			let oBox = document.getElementById("order_box");
			let cBox = document.getElementById("cancel_box");
			dTab.className = "on";
			cTab.className = "";
			oBox.style.display = "block";
			cBox.style.display = "none";
		}
		function cTabOn() {
			let dTab = document.getElementById("d_tab");
			let cTab = document.getElementById("c_tab");
			let oBox = document.getElementById("order_box");
			let cBox = document.getElementById("cancel_box");
			dTab.className = "";
			cTab.className = "on";
			oBox.style.display = "none";
			cBox.style.display = "block";
		}
		$(function(){
			$(".cuponAlert").click(function(){
				alert("준비중입니다.")
			});
		});
	</script>
</head>
<body>
	<div id="uppermain">
		<div class="mainlogo fl" onclick="location.href='EShopMain.jsp'">
			<img src="https://www.fcseoul.com/resources/shop/_img/renew/logo.png"/>
		</div>
		<div class="searchbox fl">
			<input type="text" name="maintxt" id="maintxt" onfocus="clearTxt();" onkeydown="enterSearch();"/>
			<button type="button" onclick="searchLeft();"></button>
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
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=NEW&list_type=M">
							NEW
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=UNI&list_type=M">
							유니폼
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=TRA&list_type=M">
							트레이닝 웨어
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=TSH&list_type=M">
							패션
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=SCA&list_type=M">
							응원용품
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=FAN&list_type=M">
							기념품
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=ACC&list_type=M">
							어린이
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=SALE&list_type=M">
							SALE
						</a>
					</div>
					<div>
						<a href="https://www.fcseoul.com/fcshop/productList?menu_b=ALL&list_type=M">
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
	<div class="mypage_container">
		<div class="mypage_content_wrap">
			<div class="mypage_content_box">
				<div class="left_banner">
					<div class="left_banner_title">
						<a href="">
							<img src="https://www.fcseoul.com/resources/shop/_img/mypage/lnb_title.gif"/>
						</a>
					</div>
					<div class="left_banner_list">
						<div class="tab">
							<a href="EShopOrderHistory.jsp?id=<%=id%>">
								<img src="https://www.fcseoul.com/resources/shop/_img/mypage/lnb_m0.gif"/>
							</a>
						</div>
						<div class="tab">
							<a href="EShopCart.jsp?id=<%=id%>">
								<img src="https://www.fcseoul.com/resources/shop/_img/mypage/lnb_m1.gif"/>
							</a>
						</div>
						<div class="tab">
							<a href="EShopWishList.jsp?id=<%=id%>">
								<img src="https://www.fcseoul.com/resources/shop/_img/mypage/lnb_m2.gif"/>
							</a>
						</div>
						<div class="tab cuponAlert">
							<a href="">
								<span>- 쿠폰함</span>
							</a>
						</div>
					</div>
				</div>
				<div class="oh_content">
					<table width="100%">
						<tbody>
							<tr>
								<td class="sub_t1">
									Home > 마이페이지 > 나의 주문 이력 > 
									<span class="sub_t2">주문/배송조회</span>
								</td>
							</tr>
							<tr>
								<td class="ohpage_title">
									<span class="ohpage_t1">나의 주문 이력</span>
									<img src="https://www.fcseoul.com/resources/shop/_img/product/title_fcseoul.gif"/>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="br15"></div>	
					<div class="dc_tab_wrap clear_ud">
						<div id="d_tab" class="on" onclick="dTabOn();">
							<a>주문/배송조회</a>
						</div>
						<div id="c_tab" class="" onclick="cTabOn();">
							<a>취소/교환/반품 조회</a>
						</div>
					</div>
					<div class="under"></div>
					<table width="100%">
						<tbody>
							<tr>
								<td>
									<table width="100%" class="date_search_wrap">
										<tbody>
											<tr>
												<td>
													<div class="date_search">
														<div>조회기간</div>
														<div class="f_date fl">
															<a href="">
																<img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_cal.gif"/>
															</a>
															<input type="text" name="date_form"/> 
														</div>
														<div class="between fl">-</div>
														<div class="l_date fl">
															<a href="">
																<img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_cal.gif"/>
															</a>
															<input type="text" name="date_form"/> 
														</div>
														<div class="search_btn">
															<a href="">
																<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_search2.gif"/>
															</a>
														</div>
													</div>
													<div style="clear:both;"></div>
												</td>
											</tr>
										</tbody>
									</table>
									<div class="br20"></div>
									<div id="order_box">
										<div class="oh_content_title">
											<div class="oh_content_t1 fl">
												<img src="https://www.fcseoul.com/resources/shop/_img/mypage/mypage_txt01.gif"/>
											</div>
											<div style="clear:both;"></div>
										</div>
										<table width="100%" class="content_title_box2">
											<colgroup>
												<col width="20%"/>
												<col width="12%"/>
												<col width="12%"/>
												<col width="*"/>
												<col width="12%"/>
											</colgroup>
											<tbody>
												<tr>
													<th>주문번호</th>
													<th>결제방법</th>
													<th>주문일</th>
													<th>상태(송장번호)</th>
													<th>취소신청</th>
												</tr>
												<%
												for(EShopOrderHistoryDto ohDto : OHList) {
												%>	
													<tr>
														<td><a href="EShopOrderTracking.jsp?id=<%=id %>&oNum=<%=ohDto.getoNum() %>"><b><%=ohDto.getoNum() %></b></a></td>
														<td><%=ohDto.getPayWay() %></td>
														<td class="date"><%=ohDto.getPayDate() %></td>
														<td class="pay_step"><b><%=ohDto.getoState() %></b></td>
														<td>
															<img src="<%=ohDto.getCancel()%>" onerror="this.style.display='none'"/>
														</td>
													</tr>
												<%	
												}
												%>
												<tr style="display: none;">
													<td colspan="5">조회된 데이터가 없습니다.</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div id="cancel_box" style="display: none;">
										<div class="oh_content_title">
											<div class="oh_content_t1 fl">
												<img src="https://www.fcseoul.com/resources/shop/_img/mypage/mypage_txt04.gif"/>
											</div>
											<div style="clear:both;"></div>
										</div>
										<table width="100%" class="content_title_box2">
											<colgroup>
												<col width="20%"/>
												<col width="12%"/>
												<col width="12%"/>
												<col width="*"/>
												<col width="12%"/>
											</colgroup>
											<tbody>
												<tr>
													<th>주문번호</th>
													<th>결제방법</th>
													<th>주문일</th>
													<th>처리상태</th>
													<th>GS포인트</th>
												</tr>
												<tr>
													<td colspan="5">조회된 데이터가 없습니다.</td>
												</tr>
											</tbody>
										</table>
									</div>
									<div class="br20"></div>
									<div class="page_box_wrap">
										<div class="page_box">
											<a href="">
												<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_prev2.gif"/>
											</a>
											<a href="">
												<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_prev.gif"/>
											</a>
											&nbsp;&nbsp;
											<a href="" class="pg">
												<b style="color:#d2232a">1</b>
											</a>
											&nbsp;&nbsp;
											<a href="">
												<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next.gif"/>
											</a>
											<a href="">
												<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next2.gif"/>
											</a>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
			<div style="clear:both;"></div>
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