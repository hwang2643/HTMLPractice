<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.EShopMainDao"%>
<%@ page import="dto.EShopMainDto"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%>
    
<%
	String id = "hjw2643";	

	EShopMainDao newPrdDao = new EShopMainDao();
	EShopMainDao recommendPrdDao = new EShopMainDao();
	EShopMainDao bestUniPrdDao = new EShopMainDao();
	ArrayList<EShopMainDto> newPrdDto = newPrdDao.EShopMainPrd("new");
	ArrayList<EShopMainDto> recommendPrdDto = recommendPrdDao.EShopMainPrd("recommend");
	ArrayList<EShopMainDto> bestUniPrdDto = recommendPrdDao.EShopMainBestPrd("유니폼");
	ArrayList<EShopMainDto> bestTraPrdDto = recommendPrdDao.EShopMainBestPrd("트레이닝웨어");
	ArrayList<EShopMainDto> bestFasPrdDto = recommendPrdDao.EShopMainBestPrd("패션");
	ArrayList<EShopMainDto> bestChePrdDto = recommendPrdDao.EShopMainBestPrd("응원용품");
	ArrayList<EShopMainDto> bestSouPrdDto = recommendPrdDao.EShopMainBestPrd("기념품");
	ArrayList<EShopMainDto> bestChiPrdDto = recommendPrdDao.EShopMainBestPrd("어린이");
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FC서울 공식 쇼핑몰 project</title>
	<link rel="stylesheet" href = "./EShopMainStyle.css">
	<script src="js/jquery-3.7.0.min.js"></script>
	<script>
		function openBtn() {
			let btn1 = document.getElementById("btn1");
			let btn2 = document.getElementById("btn2");
			let dark = document.getElementById("bg_dark");
			if(btn1.style.display == "none") {
				btn1.style.display = "block";
				btn2.className = "category fl view_all on"
				dark.style.display = "block";
			}
		}
		function closeBtn() {
			let btn1 = document.getElementById("btn1");
			let btn2 = document.getElementById("btn2");
			let dark = document.getElementById("bg_dark");
			if(btn1.style.display == "block") {
				btn1.style.display = "none";
				btn2.className = "category fl view_all"
				dark.style.display = "none";
			}
		}
		$(function(){
			$(".tab").click(function(){
				$(".tab").removeClass("active");
				$(this).addClass("active");
				$(".tabcontainer").css("display", "none");
				let idx = $(this).index();
				$("#tab"+(idx+1)).css("display", "block");
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
			<form action="EShopCatePage.jsp" method="post">
				<input type="hidden" name="type" value="search"/>
				<input type="hidden" name="page" value=1/>
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
	<div id="maincontent">
		<div class="mainslider">
		</div>
		<div class="bestgoods">
			<div class="goods_title">
				<h3 class="title">지금 제일 <span>잘 나가는 상품</span></h3>
				<div class="tabs fl">
					<div class="active tab">
						<button type="button" >유니폼</button>
					</div>
					<div class="tab">
						<button type="button">트레이닝</button>
					</div>
					<div class="tab">
						<button type="button">패션</button>
					</div>
					<div class="tab">
						<button type="button">응원용품</button>
					</div>
					<div class="tab">
						<button type="button">기념품</button>
					</div>
					<div class="tab">
						<button type="button">어린이</button>
					</div>
				</div>
				<div id="tab1" class="tabcontainer" style="display: block;">
					<%
					for(EShopMainDto dto : bestUniPrdDto) {
					%>
						<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
							<img src="<%=dto.getGoodsImg()%>"/>
							<span class="goodsname"><%=dto.getGoodsName() %></span>
							<span class="goodsprice"><%=dto.getPrice() %>원</span>
						</div>
					<%
					}
					%>	
					<div style="clear:both;"></div>
				</div>
				<div id="tab2" class="tabcontainer" style="display: none;">
					<%
					for(EShopMainDto dto : bestTraPrdDto) {
					%>
						<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
							<img src="<%=dto.getGoodsImg()%>"/>
							<span class="goodsname"><%=dto.getGoodsName() %></span>
							<span class="goodsprice"><%=dto.getPrice() %>원</span>
						</div>
					<%
					}
					%>
					<div style="clear:both;"></div>
				</div>
				<div id="tab3" class="tabcontainer" style="display: none;">
					<%
					for(EShopMainDto dto : bestFasPrdDto) {
					%>
						<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
							<img src="<%=dto.getGoodsImg()%>"/>
							<span class="goodsname"><%=dto.getGoodsName() %></span>
							<span class="goodsprice"><%=dto.getPrice() %>원</span>
						</div>
					<%
					}
					%>
				</div>
				<div id="tab4" class="tabcontainer" style="display: none;">
					<%
					for(EShopMainDto dto : bestChePrdDto) {
					%>
						<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
							<img src="<%=dto.getGoodsImg()%>"/>
							<span class="goodsname"><%=dto.getGoodsName() %></span>
							<span class="goodsprice"><%=dto.getPrice() %>원</span>
						</div>
					<%
					}
					%>
					<div style="clear:both;"></div>
				</div>
				<div id="tab5" class="tabcontainer" style="display: none;">
					<%
					for(EShopMainDto dto : bestSouPrdDto) {
					%>
						<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
							<img src="<%=dto.getGoodsImg()%>"/>
							<span class="goodsname"><%=dto.getGoodsName() %></span>
							<span class="goodsprice"><%=dto.getPrice() %>원</span>
						</div>
					<%
					}
					%>
					<div style="clear:both;"></div>
				</div>
				<div id="tab6" class="tabcontainer" style="display: none;">
					<%
					for(EShopMainDto dto : bestChiPrdDto) {
					%>
						<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
							<img src="<%=dto.getGoodsImg()%>"/>
							<span class="goodsname"><%=dto.getGoodsName() %></span>
							<span class="goodsprice"><%=dto.getPrice() %>원</span>
						</div>
					<%
					}
					%>
				</div>
				<div style="clear:both;"></div>
			</div>
		</div>
		<div class="newgoods">
			<div class="newgoodscontainer">
				<h3 class="title">
					따끈따끈한 
					<span>신상품</span>
					<div class="more fr" onclick="location.href='EShopCatePage.jsp?type=new'"></div>
				</h3>
				<%
				for(EShopMainDto dto : newPrdDto) {
				%>	
					<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
						<img src="<%=dto.getGoodsImg()%>"/>
						<span class="goodsname"><%=dto.getGoodsName() %></span>
						<span class="goodsprice"><%=dto.getPrice() %>원</span>
					</div>
				<%	
				}
				
				%>
			</div>
			<div style="clear:both;"></div>
		</div>
		<div class="recommendgoods">
			<div class="recommendgoodscontainer">
				<h3 class="title">
					FC서울이 엄선한 
					<span>추천 상품</span>
				</h3>
				<%
				for(EShopMainDto dto : recommendPrdDto) {
				%>	
					<div class="goods fl" onclick="location.href='EShopDetail.jsp?id=<%=id%>&goodsId=<%=dto.getGoodsId()%>'">
						<img src="<%=dto.getGoodsImg()%>"/>
						<span class="goodsname"><%=dto.getGoodsName() %></span>
						<span class="goodsprice"><%=dto.getPrice() %>원</span>
					</div>
				<%	
				}
				%>
			</div>
			<div style="clear:both;"></div>
		</div>
	</div>
	<div class="botbanner">
		<div class="botbannercontent">
			<div>
				<h4>고객센터</h4>
				<span class="telnum">070-4101-7710</span>
				<span>월요일~금요일 : 11:00~18:00</span>
				<p>
					FC서울 홈 경기일과 공휴일 및 주말은 <br/>
					고객센터를 운영하지 않습니다. <br/>
					양해 부탁드립니다.
				</p>
			</div>
			<div>
				<h4>배송문의</h4>
				<span class="telnum">1588-1255</span>
				<span>CJ 대한통운</span>
				<a href="https://www.cjlogistics.com/ko/tool/parcel/tracking#none" target="_blank">온라인 조회하기</a>
			</div>
			<div>
				<h4>FC서울 팬파크</h4>
				<span>FC서울 상설 용품샵 오픈!</span>
				<span>월드컵경기장역 2번출구</span>
				<a href="#this" onclick="alert('준비중 입니다.');" return false;>자세히 보기</a>
			</div>
		</div>
	</div>
	<div class="sns">
		<p>FC SEOUL의 더 많은 소식을 SNS를 통해 만나보세요.</p>
		<a href="https://www.facebook.com/fcseoul" target="_blank"></a>
		<a href="https://www.instagram.com/fcseoul/" target="_blank"></a>
		<a href="https://www.youtube.com/user/FCSEOUL" target="_blank"></a>
	</div>
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
	<div style="clear:both;"></div>
<div id="bg_dark" class="bg_dark" style="display: none;"></div>
</body>
</html>