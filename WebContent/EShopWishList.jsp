<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.EShopWishListDao"%>
<%@ page import="dto.EShopWishListDto"%>
<%@ page import="java.util.ArrayList"%>
    
<%
	int pageNum = 0;
	try{
		pageNum = Integer.parseInt(request.getParameter("page"));
		if(pageNum <= 0) {
			pageNum = 1;
		}
	} catch(NumberFormatException e) {
		pageNum = 1;
	}
	int endNum = pageNum * 10;
	int startNum = endNum - 9;
	
	String id = request.getParameter("id");
	
	EShopWishListDao wishListDao = new EShopWishListDao();
	ArrayList<EShopWishListDto> wishListList = wishListDao.wishList(id, startNum, endNum);
	EShopWishListDto wishListCount = wishListDao.wishListCount(id);
	int count = wishListCount.getCount();
	
%>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" href="./EShopWishList.css">
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
			$("input:checkbox[name=checkAll]").click(function(){
				if($(this).is(":checked")==true){
					$("input:checkbox[name=goodsId]").prop("checked", true);
				} else {
					$("input:checkbox[name=goodsId]").prop("checked", false);
				}
			});
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
								<img src="https://www.fcseoul.com/resources/shop/_img/mypage/lnb_m2_on.gif"/>
							</a>
						</div>
						<div class="tab cuponAlert">
							<a href="">
								<span>- 쿠폰함</span>
							</a>
						</div>
					</div>
				</div>
				<div class="wish_content">
					<table width="100%">
						<tbody>
							<tr>
								<td class="sub_t1">
									Home > 마이페이지 >  
									<span class="sub_t2">Wishlist</span>
								</td>
							</tr>
							<tr>
								<td class="wishpage_title">
									<img src="https://www.fcseoul.com/resources/shop/_img/mypage/title_wishlist.gif"/>
									<img src="https://www.fcseoul.com/resources/shop/_img/product/title_fcseoul.gif"/>
								</td>
							</tr>
						</tbody>
					</table>
					<div class="br15"></div>
					<form action="EShopUpdateAction.jsp">	
					<input type="hidden" name="id" value="<%=id %>"/>
					<input type="hidden" name="btnType" value=""/>
					<input type="hidden" name="cBtn" value=""/>
					<input type="hidden" name="goodsSize" value=""/>
					<input type="hidden" name="buyPrdId" value="0"/>
					<table width="100%" class="content_title_box2">
						<colgroup>
							<col width="5%"/>
							<col width="15%"/>
							<col width="*"/>
							<col width="13%"/>
							<col width="13%"/>
						</colgroup>
						<tbody>
							<tr>
								<th><input type="checkbox" class="check_box" name="checkAll"/></th>
								<th colspan="2">상품명</th>
								<th>가격</th>
								<th>등록일</th>
							</tr>
							<%
							for(EShopWishListDto wlDto : wishListList) {
							%>	
								<tr class="mOver">
									<td>
										<input type="hidden" name="goodIdArr" value="<%=wlDto.getGoodsId() %>"/>
										<input type="checkbox" class="check_box" name="goodsId" value="<%=wlDto.getGoodsId()%>"/>
									</td>
									<td>
										<a href="EShopDetail.jsp?goodsId=<%=wlDto.getGoodsId()%>">
											<img src="<%=wlDto.getGoodsImg()%>"/>
										</a>
									</td>
									<td class="prd_name"><a href="EShopDetail.jsp?goodsId=<%=wlDto.getGoodsId()%>"><%=wlDto.getGoodsName() %></a></td>
									<td class="f_red"><b><%=wlDto.getPrice() %> 원</b></td>
									<td class="date"><%=wlDto.getwDate() %></td>
								</tr>
							<%	
							}
							%>
							<tr style="display: none;">
								<td colspan="5">조회된 상품이 없습니다.</td>
							</tr>
						</tbody>
					</table>
					<div class="page_box_wrap">
						<div class="page_box">
							<div class="page_btn">
								<a href="EShopWishList.jsp?id=<%=id %>&page=1">
									<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_prev2.gif"/>
								</a>
								<a href="EShopWishList.jsp?id=<%=id %>&page=<%=pageNum-1%>">
									<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_prev.gif"/>
								</a>
								&nbsp;&nbsp;
								<%
								for(int i=1; i<=(count/10)+1; i++) {
									if(pageNum == i) {
										%>
										<a href="EShopWishList.jsp?id=<%=id %>&page=<%=i %>" class="pg">
											<b style="color:#d2232a"><%=i %></b>
										</a>
										<%
									} else {
										%>
										<a href="EShopWishList.jsp?id=<%=id %>&page=<%=i %>" class="pg">
											<b><%=i %></b>
										</a>
										<%
									}
								}
								%>
								&nbsp;&nbsp;
								<%
								if(pageNum == (count/10)+1) {
									%>
									<a href="EShopWishList.jsp?id=<%=id %>&page=<%=count/10+1%>">
										<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next.gif"/>
									</a>
									<%
								} else {
									%>
									<a href="EShopWishList.jsp?id=<%=id %>&page=<%=pageNum+1%>">
										<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next.gif"/>
									</a>
									<%	
								}
								%>
								<a href="EShopWishList.jsp?id=<%=id %>&page=<%=count/10+1%>">
									<img src="https://www.fcseoul.com/resources/shop/_img/board/pg_next2.gif"/>
								</a>
							</div>
						</div>
					</div>
					<div class="del_btn_wrap">
						<button class="fr del_sel" type="submit" name="wlBtn" value="wlDelSel">
							<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_totalsel.gif"/>
						</button>
					</form>
					<form action="EShopUpdateAction.jsp" class="fl del_all">
						<button type="submit" name="wlBtn" value="wlDelAll">
							<img src="https://www.fcseoul.com/resources/shop/_img/btn/btn_totaldel.gif"/>
						</button>
					<input type="hidden" name="id" value="<%=id %>"/>
					<input type="hidden" name="btnType" value=""/>
					<input type="hidden" name="cBtn" value=""/>
					<input type="hidden" name="goodsSize" value=""/>
					<input type="hidden" name="goodsId" value=""/>
					<input type="hidden" name="goodsId" value=""/>
					<input type="hidden" name="buyPrdId" value="0"/>
					</form>
					<div style="clear:both;"></div>
					</div>
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