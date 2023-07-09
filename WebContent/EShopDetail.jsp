<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	String id = "";
	int goodsId = 0;
	try{
		goodsId = Integer.parseInt(request.getParameter("goodsId"));
		id = request.getParameter("id");
	} catch(Exception e) {
		id = "";
	}
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
	
	String sql = " SELECT g1.*, g2.*, g3.*" +
				 " FROM goods g1, goods_img g2, goods_size g3" +
				 " WHERE g1.goods_id = g2.goods_id AND g1.goods_id=g3.goods_id AND g1.goods_id=?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, goodsId);
	
	String goodsImg = "";
	String goodsName = "";
	int goodsPrice = 0;
	String img = "";
	String newC = "";
	String best = "";
	String sale = "";
	String goodsSize1 = "";
	int inventory1 = 0;
	ResultSet rs = pstmt.executeQuery();
	if(rs.next()) {
		goodsImg = rs.getString("goods_img");
		goodsName = rs.getString("goods_name");
		goodsPrice = rs.getInt("price");
		img = rs.getString("img");
		newC = rs.getString("new");
		best = rs.getString("best");
		sale = rs.getString("sale");
		goodsSize1 = rs.getString("goods_size");
		inventory1 = rs.getInt("inventory");
		
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./EShopDetail.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
	<script src="js/jquery-3.7.0.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
		$(document).ready(function(){
	        let slider = $(".slider").bxSlider();
	        
	        $(".close_btn").click(function(){
				$(".detail_popup_wrap").css("display", "none");
				$("#bg_dark").css("display", "none");
			});
			$(".detail_btn").click(function(){
				$(".detail_popup_wrap").css("display", "block");
				$("#bg_dark").css("display", "block");
				slider.reloadSlider();
			});
			$(".cart_btn").click(function(){
				let size = $("#size_sel option:selected").val();
				if(size == "") {
					alert("사이즈를 선택해주세요.");
					return false;
				}
			})
			
	  	});
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
		$(function(){
			$(".rqa").click(function(){
				let val = $(this).attr("id");
				if($('#view_'+val).hasClass("off")){
					$(".rqa_content_box").addClass("off")
					$('#view_'+val).removeClass("off");	
				} else {
					$('#view_'+val).addClass("off");
				}
			});
			
			$(".plus_btn").click(function(){
				let amt = Number($("#amount").val());
				$("#amount").val(amt+1);
				calc();
			});
			$(".minus_btn").click(function(){
				let amt = Number($("#amount").val());
				if(amt > 1){
					$("#amount").val(amt-1);
					calc();
				}
			});
			$("html, body").click(function(){
				calc();
			});
			calc();
			$("#t1").click(function(){
				let lo = $(this).parent().find(".tab_on").offset();
				$("html, body").animate({scrollTop : lo.top}, 500);
			});
			
		});
		
		function calc() {
			let price = $("#unit_price").text().replace(",", "")
			price = price.replace("원", "");
			let amt = Number($("#amount").val());
			let finPrice = price * amt;
			let stprice = ""+finPrice;
			let result1 = "," + stprice.slice(-3);
			let result2 = stprice.slice(0,-3)+result1;
			$("#price").html(result2 + "원");
		}
		
		
		
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
	<div class="main_container">
		<div class="content_wrap">
			<div class="main_content">
				<div class="content_title">
					<div class="mini_title">
						Home > <span>유니폼</span>
					</div>
					<div class="title">
						<span>유니폼</span>
						<img src="https://www.fcseoul.com/resources/shop/_img/product/title_fcseoul.gif"/>
					</div>
				</div>
				<div>
					<div class="prd_img_wrap fl">
						<div class="prd_img">
							<img src="<%=goodsImg%>"/>
						</div>
						<div>
								<img class="detail_btn" src="https://www.fcseoul.com/resources/shop/_img/btn/zoom.gif"/>
						</div>
						<div style="clear:both;"></div>
					</div>
					<form action="EShopBuy.jsp"/>
						<table width="100%" class="prd_info_box">
							<tbody>
								<tr>
									<td colspan="2" class="prd_info_tit">
										<%=goodsName %>
										<img src="<%=newC%>" onerror="this.style.display='none'"/>
										<img src="<%=best%>" onerror="this.style.display='none'"/>
									</td>
								</tr>
								<tr class="prd_info_r1">
									<td class="prd_info_c1">판매가격</td>
									<td id="unit_price" class="prd_info_c2 price"><%=goodsPrice %> 원</td>
								</tr>
								<tr class="prd_info_r1">
									<td class="prd_info_c1">적립 포인트</td>
									<td class="prd_info_c2 point">2,970 / 일반GS&POINT는 구매가격의 1% 입니다.</td>
								</tr>
								<tr class="prd_info_r2">
									<td class="prd_info_c1">제조사/원산지</td>
									<td class="prd_info_c2">프로스펙스</td>
								</tr>
								<tr class="prd_info_r2">
									<td class="prd_info_c1">브랜드명</td>
									<td class="prd_info_c2">FC서울</td>
								</tr>
								<tr class="prd_info_r2">
									<td class="prd_info_c1">색상선택</td>
									<td class="prd_info_c2">
										<p class="color_sel">
											<a class="prd_red">
												색
											</a>
										</p>
									</td>
								</tr>
								<tr class="prd_info_r2">
									<td class="prd_info_c1">사이즈</td>
									<td class="prd_info_c2">
										<input type="hidden" name="id" value="<%=id%>"/>
										<input type="hidden" name="goodsId" value="<%=goodsId%>"/>
										<input type="hidden" name="qty" value="0"/>
										<input type="hidden" name="cBtn" value=""/>
										<input type="hidden" name="wlBtn" value=""/>
<!-- 										<input type="hidden" name="goodsIdArr" value=""/> -->
										<select id="size_sel" name="goodsSize" class="size_sel">
											<option value="">선택해주세요</option>
											<option value="<%=goodsSize1 %>"><%=goodsSize1 %> (재고수량 <%=inventory1 %>개)</option>
											<%
// 												int n = 1;
												while(rs.next()) {
													String goodsSize = rs.getString("goods_size");
													int inventory = rs.getInt("inventory");
// 													n++;
											%>
											<option value="<%=goodsSize %>"><%=goodsSize %> (재고수량 <%=inventory %>개)</option>
											<%
												}
												rs.close();
												pstmt.close();
												conn.close();
											%>
										</select>
									</td>
								</tr>
								<tr class="prd_info_r2">
									<td class="prd_info_c1">수량</td>
									<td class="prd_info_c2">
										<input type="text" name="amount" id="amount" size="3" style="text-align: right;" value="1"/>
										개
										<button type="button" class="plus_btn">▲</button>
										<button type="button" class="minus_btn">▼</button>
									</td>
								</tr>
								<tr class="prd_info_r2">
									<td class="prd_info_c1">금액</td>
									<td id="price" class="prd_info_c2"><%=goodsPrice %> 원</td>
								</tr>
							</tbody>
						</table>
						<div class="prd_btn_box">
							<button onclick="action='EShopUpdateAction.jsp'" type="submit" name="btnType" value="cart" class="cart_btn">
								<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_cart.gif" class="prd_btn"/>
							</button>
<%-- 							<input type="hidden" name="buyPrdId" value="<%=goodsId %>"/> --%>
							<button type="submit" name="btnType" value="buy">
								<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_buy.gif" class="prd_btn"/>
							</button>
							<button onclick="action='EShopUpdateAction.jsp'" type="submit" name="btnType" value="wishList">
								<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_wishlist.gif" class="prd_btn"/>
							</button>
						</div>
					</form>
					<div class="prd_detail_info">
						<div class="tab_box">
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab1_on.gif" class="tab_on" id="t1"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab2.gif" class="" id="t2"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab3.gif" class="" id="t3"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab4.gif" class="" id="t4"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab5.gif" class="" id="t5"/></a>
						</div>
						<div class="prd_info_img">
							<img src="<%=img%>"/>
						</div>
						<div class="prd_tag">
							<p># 유니폼 # 40주년 # 홈 # 어웨이 # 필드</p>
						</div>
						<div class="tab_box">
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab1.gif" class="" id="t1"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab2_on.gif" class="tab_on" id="t2"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab3.gif" class="" id="t3"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab4.gif" class="" id="t4"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab5.gif" class="" id="t5"/></a>
						</div>
						<div class="prd_text">
							<p>
							<b><u>* 해당 제품은 전면에 자이 스폰서만 부착된 유니폼입니다.</u></b>
							<br/>
							유니폼만 단독으로 배송되며, 마킹 부착을 희망하실 경우
							<br/>
							유니폼과 마킹지를 한번에 결제해주셔야만 부착하여 배송됩니다.
							<br/>
							이 점 양해 부탁드립니다.
							<br/>
							<br/>
							<b><u>* 교환 및 환불은 14일이내로 가능하며, 재고 부족으로 인해 교환이 어려울 수 있습니다.</u></b>
							<br/>
							<br/>
							<b><u><span>세탁 관련 주의사항</span></u></b>
							<br/>
							마킹이 부착된 유니폼은 세탁에 취약하므로 주의가 필요합니다.
							<br/>
							<br/>
							손세탁을 권장 드리며 불가피하게 세탁기를 돌려야 할 경우,
							<br/>
							세탁망에 넣어 울 세탁(찬물) 부탁드립니다.
							<br/>
							<br/>
							<u>건조기는 마킹지가 떨어질 수 있으니 사용 불가합니다.</u>
							<br/>
							<br/>
							섬유유연제를 사용할 경우, 유니폼이 이염 될 수 있으니 사용 불가합니다.
							<br/>
							<br/>
							세탁 후 개인 부주의로 인한 교환 및 환불은 불가합니다.
							<br/>
							<br/>
							<b><u>마킹 관련 안내사항</u></b>
							<br/>
							<br/>
							마킹이 부착된 유니폼은 교환 및 환불이 불가합니다.
							<br/>
							<br/>
							부착 시, 희망하시는 이름 부착 위치를 꼭 배송시 요청사항에 기입 부탁드립니다.
							<br/>
							<br/>
							별도의 요청사항을 기재하지 않으실 경우 상세이미지에 있는 번호 하단으로 이름마킹이 들어갑니다.
							<br/>
							이로인한 교환 및 환불은 불가하오니 양해부탁드립니다.
							<br/>
							<br/>
							23시즌 마킹은 홈&어웨이 모두 골드마킹입니다.
							<br/>
							(GK는 화이트)
							<br/>
							<br/>
							골드마킹은 열에 취약하며 원단 특성상 비침 현상이 있을 수 밖에 없습니다.
							<br/>
							따라서 여러 번 프레스기를 누를수록 비침현상이 심해지니 추천드리지 않습니다.
							<br/>
							<br/>
							<b><u>현장 수령 장소</u></b>
							<br/>
							홈경기일 : 북측광장 FC서울 마킹센터
							<br/>
							비홈경기일 : FC서울 팬파크(월드컵경기장역 2번출구 앞)
							<br/>
							<br/>
							<b><u>FC서울 팬파크 운영시간</u></b>
							<br/>
							평일) 10:00 ~ 20:00
							<br/>
							주말, 공휴일) 10:00 ~ 20:00
							<br/>
							<br/>
							</p>
						</div>
						<div class="tab_box">
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab1.gif" class="" id="t1"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab2.gif" class="" id="t2"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab3_on.gif" class="tab_on" id="t3"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab4.gif" class="" id="t4"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab5.gif" class="" id="t5"/></a>
						</div>
						<div>
							<ul class="prd_view1">
								<li class="prd_view_t1">구입제품의 반품 / 교환</li>
								<li class="prd_view_t2">구입 후 7일 이내에 동일제품으로 교환 가능하며 운송비는 구매자께서 부담합니다.</li>
								<li class="prd_view_t3">주문제작 유니폼이나, 공동구매 제작상품, 마킹된 유니폼의 경우 소량 제작된 상품의 특성상 제품에 이상이 있을시를 제외하고 교환 및 환불이 불가 하오니 신중한 구매결정 부탁드립니다.</li>
								<li class="prd_view_t2">다른 제품으로 교환, 또는 이상이 없는 제품과 함께 교환을 원하실 경우 구매자께서 운송비를 부담합니다.</li>
								<li class="prd_view_t3">반품교환시 착불 배송비 초과금액(3,500원) 발생시 구매자께서 초과된 금액을 부담하게 되므로, 선불로 상품을 보내주시거나, 3500원을 동봉하여 CJ대한통운 택배를 통해 착불로 보내 주시기 바랍니다.</li>
								<li class="prd_view_t2">반품/교환 주소 : 서울시 마포구 월드컵로 240 월드컵경기장역 2번 출구 앞 FC서울 팬파크 TEL 070-4101-7710</li>
							</ul>
							<ul class="prd_view2">
								<li class="prd_view_t1">구입제품의 이상이 있을 경우 (색상, 사이즈, 다른상품교환)</li>
								<li class="prd_view_t2">구입후 7일이내 교환 가능하며 구매자께서 운송비를 부담합니다.</li>
							</ul>
							<ul class="prd_view2">
								<li class="prd_view_t1">주의사항!!</li>
								<li class="prd_view_t2">비닐포장 및 Tag의 폐기 또는 훼손 등으로 상품 가치가 멸실된 경우에는 제한 반품시에 해당 사은품이 있을 경우 같이 보내주셔야 합니다.</li>
							</ul>
						</div>
						<div class="tab_box">
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab1.gif" class="" id="t1"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab2.gif" class="" id="t2"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab3.gif" class="" id="t3"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab4_on.gif" class="tab_on" id="t4"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab5.gif" class="" id="t5"/></a>
						</div>
						<div>
							<ul class="prd_view1">
								<li class="prd_view_t1">결제후 2~5일 이내에 상품을 받아 보실 수 있습니다.</li>
								<li class="prd_view_t2">국내 최대의 물류사 CJ대한통운 택배를 통하여 신속하고 안전하게 배송됩니다.</li>
							</ul>
							<ul class="prd_view2">
								<li class="prd_view_t1">10만원 이상 구입시 무료배송입니다. <img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_freedelivery.gif" alt="무료배송" class="t7"></li>
								<li class="prd_view_t2">제주도를 포함한 도서,산간지역은 배송비(항공료 또는 도선료) 3500원이 추가 되므로 착불로 발송됩니다.</li>
							</ul>
						</div>
						<div class="tab_box">
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab1.gif" class="" id="t1"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab2.gif" class="" id="t2"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab3.gif" class="" id="t3"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab4.gif" class="" id="t4"/></a>
							<a><img src="https://www.fcseoul.com/resources/shop/_img/product/prd_tab5_on.gif" class="tab_on" id="t5"/></a>
						</div>
						<div class="prd_rqa_box">
							<div class="rqa_upper">
								총 <span>125개</span>의 글이 등록되어 있습니다.
							</div>
							<table width="100%">
								<colgroup>
									<col width="8%"/>
									<col width="*"/>
									<col width="8%"/>
									<col width="12%"/>
									<col width="11%"/>
								</colgroup>
								<tr class="rqa_head">
									<th>번호</th>
									<th>제목</th>
									<th>&nbsp;</th>
									<th>작성자</th>
									<th>작성일</th>
								</tr>
								<tr class="rqa" id="125">
									<td class="no">125</td>
									<td class="rqa_tit">
										<img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_qna.gif"/>
										 홈,어웨이 수량 재입고
									</td>
									<td>
										<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_complete.gif" class="t1" alt="답변완료">
									</td>
									<td>최정</td>
									<td class="rqa_date">2023-06-19</td>
								</tr>
								<tr class="rqa_content_wrap">
									<td colspan="5" id="view_125" class="rqa_content_box off">
										<table>
											<tr>
												<td class="rqa_content">혹시 홈,어웨이 사이즈별로 온라인에 언제 재입고 되나요?</td>
											</tr>
										</table>
										<table class="answer_box">
											<tr>
												<td class="answerL">
													쇼핑몰운영자6	
												</td>
												<td class="answerR">
													<p>안녕하세요 FC서울 팬파크 입니다.</p>
													<br/>
													<p>홈 유니폼은 7월 초 쯤으로 예정되어 있고,</p>
													<p>어웨이 유니폼은 재입고 해드렸습니다.</p>
													<br/>
													<p>감사합니다.</p>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr class="rqa" id="124">
									<td class="no">124</td>
									<td class="rqa_tit">
										<img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_review.gif"/>
										 오프라인
									</td>
									<td>
									</td>
									<td>오수민</td>
									<td class="rqa_date">2023-06-19</td>
								</tr>
								<tr class="rqa_content_wrap">
									<td colspan="5" id="view_124" class="rqa_content_box off">
										<table>
											<tr>
												<td class="rqa_content">오프라인에 90 95 100 105 사이즈 잇나용…“?</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr class="rqa" id="123">
									<td class="no">123</td>
									<td class="rqa_tit">
										<img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_qna.gif"/>
										 오프라인 재고
									</td>
									<td>
										<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_complete.gif" class="t1" alt="답변완료">
									</td>
									<td>조은주</td>
									<td class="rqa_date">2023-06-18</td>
								</tr>
								<tr class="rqa_content_wrap">
									<td colspan="5" id="view_123" class="rqa_content_box off">
										<table>
											<tr>
												<td class="rqa_content">혹시 팬파크에는 100사이즈 재고 있나요?</td>
											</tr>
										</table>
										<table class="answer_box">
											<tr>
												<td class="answerL">
													쇼핑몰운영자6	
												</td>
												<td class="answerR">
													<p>안녕하세요 FC서울 팬파크 입니다.</p>
													<br/>
													<p>현재 홈 유니폼 100사이즈는 품절 상태 입니다,,,</p>
													<br/>
													<p>감사합니다.</p>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr class="rqa" id="122">
									<td class="no">122</td>
									<td class="rqa_tit">
										<img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_review.gif"/>
										오프라인 재고
									</td>
									<td>
									</td>
									<td>조은주</td>
									<td class="rqa_date">2023-06-17</td>
								</tr>
								<tr class="rqa_content_wrap">
									<td colspan="5" id="view_122" class="rqa_content_box off">
										<table>
											<tr>
												<td class="rqa_content">혹시 팬파크에 100재고 있나요?</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</div>
						<div class="page_box">
							<div class="page_btn">
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
								<a href="" class="pg">
									2
								</a>
								<a href="" class="pg">
									3
								</a>
								<a href="" class="pg">
									4
								</a>
								<a href="" class="pg">
									5
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
						<div class="rqa_write_btn fr">
							<a>
								<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_write.gif"/>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div> 
	<div class="detail_popup_wrap" style="display: none;">
		<div class="detail_popup_box">
			<h1><button class="close_btn"></button></h1>
			<div class="img_slider_wrap">
				<div class="img_slider_box">
					<div class="slider">
						<div>
							<img src="<%=goodsImg%>"/>
						</div>
						<div>
							<img src="<%=goodsImg%>"/>
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