<%@page import="dto.EShopCartDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.EShopCartDao"%>
<%
	String id = request.getParameter("id");

	EShopCartDao cartDao = new EShopCartDao();
	ArrayList<EShopCartDto> cartList = cartDao.cart(id);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./EShopCart.css">
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
		$(function(){
			$("#infoBtn1").click(function(){
				$(".info_text1").css("display", "block").animate({"opacity": "1"}, 1000);
				$(".info_text2").css("display", "none");
				$(".info_text2").css("opacity", "0");
				$(".info_btn1").attr("src", "https://www.fcseoul.com/resources/shop/_img/cart/tab_ord01_on.gif");
				$(".info_btn2").attr("src", "https://www.fcseoul.com/resources/shop/_img/cart/tab_ord02_off.gif");
			})
			$("#infoBtn2").click(function(){
				$(".info_text2").css("display", "block").animate({"opacity": "1"}, 1000);
				$(".info_text1").css("display", "none");
				$(".info_text1").css("opacity", "0");
				$(".info_btn1").attr("src", "https://www.fcseoul.com/resources/shop/_img/cart/tab_ord01_off.gif");
				$(".info_btn2").attr("src", "https://www.fcseoul.com/resources/shop/_img/cart/tab_ord02_on.gif");
			});
			$("input:checkbox[name=checkAll]").click(function(){
				if($(this).is(":checked")==true){
					$("input:checkbox[name=checked]").prop("checked", true);
				} else {
					$("input:checkbox[name=checked]").prop("checked", false);
				}
			});
			$(".cuponAlert").click(function(){
				alert("준비중입니다.")
			});
			$(".dup_btn").click(function(){
				let idx = $(this).index();
				let qty = $(".qty_input").eq(idx).val();
				if(qty <= 0) {
					alert("0개 이하로 수량을 변경할 수 없습니다.");
					return false;
				} else {
					alert("수량이 변경되었습니다.");
				}
			});
			$(".buy_sel").click(function(){
				if($(".check_box").is(":checked") == false) {
					alert("상품을 선택해주세요.");
					return false;
				}
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
						<a href="EShopFAQ.jsp?id=<%=id%>">
							FAQ
						</a>
					</div>
					<div>
						<a href="EShopQ&A.jsp?id=<%=id%>">
							Q&A
						</a>
					</div>
					<div>
						<a href="EShopNotice.jsp?id=<%=id%>">
							공지사항
						</a>
					</div>
					<div>
						<a href="EShopTerm.jsp?id=<%=id%>">
							이용약관
						</a>
					</div>
					<div>
						<a href="EShopPrivacy.jsp?id=<%=id%>">
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
				<a href="EShopMyPage.jsp?id=<%=id%>">
					<span>마이페이지</span>
				</a>
			</div>
			<div class="m2">
				<a href="EShopCart.jsp?id=<%=id%>">
					<span>장바구니</span>
				</a>
			</div>
			<div class="m3">
				<a href="EShopWishList.jsp?id=<%=id%>">
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
								<img src="https://www.fcseoul.com/resources/shop/_img/mypage/lnb_m1_on.gif"/>
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
				<div class="cart_content">
					<table width="100%">
						<tbody>
							<tr>
								<td class="sub_t1">
									Home > 마이페이지 >  
									<span class="sub_t2">장바구니</span>
								</td>
							</tr>
							<tr>
								<td class="cartpage_title">
									<img src="https://www.fcseoul.com/resources/shop/_img/mypage/title_cart.gif"/>
									<img src="https://www.fcseoul.com/resources/shop/_img/product/title_fcseoul.gif"/>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="br15"></div>	
					<table width="100%">
						<tbody>
							<tr>
								<td>
									<table width="100%" class="cart_tab">
										<colgroup>
											<col width="33%"/>
											<col width="33%"/>
											<col width="*"/>
										</colgroup>
										<tbody>
											<tr>
												<td><img src="https://www.fcseoul.com/resources/shop/_img/cart/tab_order01_on.gif"/></td>
												<td><img src="https://www.fcseoul.com/resources/shop/_img/cart/tab_order02_off.gif"/></td>
												<td><img src="https://www.fcseoul.com/resources/shop/_img/cart/tab_order03_off.gif"/></td>
											</tr>
										</tbody>
									</table>
									<div class="br20"></div>
									<div class="cart_text">
										ㆍ고객님께서 
										<font class="f_red">주문하신 상품내역을 변경하시거나 삭제</font>하실 수가 없습니다.
										<br/>
										ㆍ장바구니에 담긴 상품은 로그아웃시 삭제됩니다. <br/>
										ㆍ판매가 종료된 상품은 장바구니에서 삭제될 수도 있으며, 구매하실 수 없습니다. <br/>
										ㆍ계속주문을 원하시면 '쇼핑하기'를 클릭하세요. <br/>
										ㆍ바로구매를 원하시면 '주문하기'를 클릭하세요. <br/>
									</div>
									<div class="br10"></div>
									<form action="EShopUpdateAction.jsp">
									<input type="hidden" name="id" value="<%=id %>"/>
<!-- 									<input type="hidden" name="amount" value="0"/> -->
									<input type="hidden" name="wlBtn" value=""/>
<!-- 									<input type="hidden" name="buyPrdId" value="0"/> -->
									<table width="100%" class="content_title_box2">
										<colgroup>
											<col width="5%"/>
											<col width="15%"/>
											<col width="*"/>
											<col width="10%"/>
											<col width="10%"/>
											<col width="10%"/>
											<col width="10%"/>
											<col width="13%"/>
										</colgroup>
										<tbody>
											<tr>
												<th><input type="checkbox" class="check_box" name="checkAll"/></th>
												<th colspan="2">상품명</th>
												<th>옵션</th>
												<th>수량</th>
												<th>가격</th>
												<th>GS&POINT</th>
												<th>비고</th>
											</tr>
											<%
											int n = 0;
											for(EShopCartDto cDto : cartList) {
											%>	
												<tr class="mOver">
													<td><input type="checkbox" class="check_box" name="checked" value="<%=n%>"/></td>
													<td>
														<input type="hidden" name="btnType" value=""/>
														<input type="hidden" name="goodsSize" value="<%=cDto.getGoodsSize() %>"/>
														<input type="hidden" name="goodsId" value="<%=cDto.getGoodsId() %>"/>
														<a href="EShopDetail.jsp?id=<%=id%>&goodsId=<%=cDto.getGoodsId()%>">
															<img src="<%=cDto.getGoodsImg()%>"/>
														</a>
													</td>
													<td class="prd_name"><a href="EShopDetail.jsp?id=<%=id%>&goodsId=<%=cDto.getGoodsId()%>"><%=cDto.getGoodsName() %></a></td>
													<td><%=cDto.getGoodsSize() %> / <%=cDto.getInventory() %>개</td>
													<td class="btnImg">
														<input class="qty_input" type="text" name="amount" maxlength="3" value="<%=cDto.getQty()%>"/>
														<button type="submit" class="dup_btn" name="cBtn" value="cDup<%=n%>">
															<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_change2.gif"/>
														</button>
													</td>
													<td><b class="f_red"><%=cDto.getPrice() %>원</b></td>
													<td><b class="f_gold"></b></td>
													<td class="btnImg">
														<button type="submit" class="del_btn" name="cBtn" value="cDel<%=n%>">
															<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_del.gif"/>
														</button>
													</td>
												</tr>
											<%	
											n++;
											}
											%>
											<tr style="display: none;">
												<td colspan="8">조회된 상품이 없습니다.</td>
											</tr>
										</tbody>
									</table>
									<div class="continue_btn_wrap">
										<button onclick="action='EShopBuy.jsp'" type="submit" name="cBtn" value="buyAll">
											<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_totalorder.gif"/>
										</button>
										<button class="buy_sel" onclick="action='EShopBuy.jsp'" type="submit" name="cBtn" value="buySel">
											<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_selorder.gif"/>
										</button>
										<a href="EShopMain.jsp?id=<%=id%>">
											<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_goshopping.gif"/>
										</a>
									</div>
									</form>
									<div class="br30"></div>	
									<div class="info_title_wrap">
										<a id="infoBtn1">
											<img src="https://www.fcseoul.com/resources/shop/_img/cart/tab_ord01_on.gif" class="info_btn1"/>
										</a>
										<a id="infoBtn2">
											<img src="https://www.fcseoul.com/resources/shop/_img/cart/tab_ord02_off.gif" class="info_btn2"/>
										</a>
									</div>
									<div class="info_text1" style="display: block; opacity: 1;">
										<p class="f_line">구입제품의 반품 / 교환</p>
										<p>ㆍ구입후 7일 이내에 동일제품으로 교환 가능하며 운송비는 판매자 부담입니다.(주문제작상품 제외)</p>
										<p>ㆍ고객 변심에 의한 반품/교환은 제품 수령 후 7일 이후에는 불가하오니 신중한 구매 부탁드립니다.</p>
										<p>ㆍ상품에 손상이 있거나 상품에 손상이 없어도 택, 라벨이 분리/분실/훼손 제품은 교환 및 환불이 불가능합니다.</p>
										<p class="f_red">ㆍ주문제작 유니폼이나, 공동구매 제작상품, 마킹된 유니폼의 경우 소량 제작된 상품의 특성상 제품에 이상이 있을시를 제외하고 교환 및 환불이<br/> 불가하오니 신중한 구매결정 부탁드립니다.</p>
										<p>ㆍ다른 제품으로 교환, 또는 이상이 없는 제품과 함께 교환을 원하실 경우 구매자께서 운송비를 부담합니다.</p>
										<p class="f_red">ㆍ반품교환시 착불 배송비 초과금액(3,500원)발생시 초과된 금액을 부담하게 되므로, 선불로 상품을 보내주시거나, 한진택배사를 통해 착불로 보내주시기 바랍니다.</p>
										<p>ㆍ반품/교환 주소 : 서울시 마포구 성산동 515 월드컵경기장내 플레이위드어스 TEL 070-4101-771</p>
										<p class="f_line">구입후  7일이내 교환 가능하며 구매자께서 운송비를 부담합니다.</p>
										<p>ㆍ구입후 7일 이내 교환 가능하며 구매자께서 운송비를 부담합니다.</p>
										<p class="f_line">주의사항!!</p>
										<p>ㆍ비닐포장 및 Tag의 폐기 또는 훼손등으로 상품 가치가 멸실된 경우에는 제한 반품시에 해당 사은품이 있을 경우 같이 보내주셔야 합니다.</p>
									</div>
									<div class="info_text2" style="display: none; opacity: 0;">
										<p class="f_line">결제후 2~5일 이내에 상품을 받아 보실 수 있습니다.</p>
										<p>ㆍ국내 최대의 물류사 한진택배를 통하여 신속하고 안전하게 배송됩니다.</p>
										<p class="f_line">10만원 이상 구입시 무료배송 입니다. <img src="https://www.fcseoul.com/resources/shop/_img/icon/icon_presend.gif"></p>
										<p>ㆍ제주도를 포함한 도서, 산간지역은 배송비(한공료 또는 도선료) 3500원이 추가되므로 착불로 발송됩니다.</p>
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