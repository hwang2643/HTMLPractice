<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dto.SocialBoardDto"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dao.SocialBoardDao"%>
    
<%
// 	String id = request.getParameter("id");
	String id = "hjw2643";
	String search = "";
	String searchBtn = "";
	String searchTxt = "";
	int pageNum = 0;
	try{
		search = request.getParameter("search");
		searchBtn = request.getParameter("searchBtn");
		searchTxt = request.getParameter("searchTxt");
		pageNum = Integer.parseInt(request.getParameter("page"));
		if(pageNum <= 0) {
			pageNum = 1;
		}
	} catch(NumberFormatException e) {
		pageNum = 1;
		search = "";
		searchBtn = "";
		searchTxt = "";
		pageNum = 1;
	}
	int endNum = pageNum * 10;
	int startNum = endNum - 9;
	
	SocialBoardDao sbMainDao = new SocialBoardDao();
	ArrayList<SocialBoardDto> sbMainList = new ArrayList<SocialBoardDto>();
	
	if(searchBtn.equals("검색") && search.equals("all")) {
		sbMainList = sbMainDao.socialSearchAll(searchTxt, startNum, endNum);
	} else if(searchBtn.equals("검색") && search.equals("title")) {
		sbMainList = sbMainDao.socialSearchTitle(searchTxt, startNum, endNum);
	} else if(searchBtn.equals("검색") && search.equals("content")) {
		sbMainList = sbMainDao.socialSearchContent(searchTxt, startNum, endNum);
	} else if(searchBtn.equals("검색") && search.equals("name")) {
		sbMainList = sbMainDao.socialSearchName(searchTxt, startNum, endNum);
	} else {
		sbMainList = sbMainDao.socialBoardSelect(startNum, endNum);
	}
	int count = sbMainDao.socialCount();

	
	
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>FC SEOUL</title>
	<link rel="stylesheet" href="SocialBoard.css">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<!-- bxslider -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
	<script>
	$('html').click(function(e) {
		if($(e.target).hasClass("button")) {
			if ($(e.target).parent().find(".button123").css("display") == "none") {
				$(".button123").css("display","none");
				$(".button123").removeClass("on");
				$(e.target).addClass("on");
				$(e.target).parent().find(".button123").css("display","block");
			} else if($(e.target).parent().find(".button123").css("display") == "block"){
				$(e.target).parent().find(".button123").css("display","none");
				$(e.target).removeClass("on");
			}
		}
		if(!($(e.target).hasClass("button"))) {
			$(".button123").parent().find(".button").removeClass("on");
			$(".button123").css("display","none");
		}
	});
	$("document").ready(function() {  
		let menu = $(".contentButton");
		let menuLocation = menu.offset();
	    $(window).scroll(function() {  
	    	if($(window).scrollTop()>=menuLocation.top){
	    		$(".contentButton").css("position","fixed");
	    		$(".contentButton").css("top","0");
	    	}
	    	else {
	    		$(".contentButton").css("position","absolute");
	    		$(".contentButton").css("top","");
	    	}
	    });  
	});
	$(function () {
       $(document).ready(function(){
	        $(".slider").bxSlider({
	        	
	        });
       
           $(".mslide").bxSlider({
           		
           });
          
           $(".slide3").bxSlider({
           	
           }); 
         });   
	});
    </script>
    <script>
		let v1 = false;
		let v2 = false;
		$(function(){
			let smSlider = $(".inner1").bxSlider({
              	
	        });
			$("#amenu").click(function(){
				if($(".allList").css('display') == 'none'){
					$(".allList").css('display','block');
					$(".allmenu").addClass('on');
					$(".bannerlayer").css('display','block');					
				}else{
					$(".allList").css('display','none');
					$(".allmenu").removeClass('on');
					$(".bannerlayer").css('display','none');
				}
			});
			
			$(document).ready(function(){
  				var currentPosition = parseInt($(".sidebar").css("top"));
  			 	$(window).scroll(function() {
  			    	var position = $(window).scrollTop(); 
  			    	$(".sidebar").stop().animate({"top":position+currentPosition+"px"},700);
  			  	});
  			});
			$(document).ready(function() {
				$(document).on("click",".sbtn",function(){
					$(".sbtn").removeClass("snsbutton");
					$(this).parent().find(".sbtn").addClass("snsbutton");
				});
			});	
			
			$(".menulist li").each(function(index){
				$(this).mouseenter(function(){
					let idx = $(this).index();
					let mName = $(this).attr("id");
					$(".menulist li").removeClass("over");
					$(".detailmenu li.dm").hide();
					$(this).addClass("over");
					$("."+mName).show();
					$(".bannerlayer2").show();
					smSlider.reloadSlider();
					$("."+mName).mouseenter(function(){
						$(this).show();
						$(".menulist li").eq(idx).addClass("over");
						smSlider.reloadSlider();
					});
				});
				$("html, body").mouseleave(function(){
					hideFunc();
				});
				$(".bannerlayer2").mouseover(function(){
					hideFunc();
				});
			});
			
		});
    	function hideFunc() {
    		$(".menulist li").removeClass("over");
    		$(".detailmenu li.dm").hide();
    		$(".bannerlayer2").hide();
    	} 	
    	function ready() {
			alert("준비중입니다.");
		}
    </script>
  
</head>
<body>
	<!-- 사이드바 -->
	<div class="sidebar">
		<ul>
			<li>
				<a href=""></a>
			</li>
			<li>
				<a href="https://www.facebook.com/fcseoul" target="_blank"></a>
			</li>
			<li>
				<a href="https://instagram.com/fcseoul/" target="_blank"></a>
			</li>
			<li>
				<a href="http://www.youtube.com/user/FCSEOUL" target="_blank"></a>
			</li>
			<li>
				<a href="/vr/stadium" target="_blank"></a>
			</li>
		</ul>
	</div>
	<!-- 사이드바 -->
	
	<!-- 티켓예매 -->
	<div class="ticketbox">
		<span> <img alt="k리그 로고" src="https://files.fcseoul.com/multi01/Match/League/1673574666175.png"> </span>
		<strong>2023.06.11(일) 18:00</strong>
		<span>서울월드컵경기장</span>
		<div class="matchinfo">
			<div class="mi1">
				<div class="home">
					<img alt="fc서울로고" src="https://fcseoulpub.s3.ap-northeast-2.amazonaws.com/multi01/Club/Club/1675316444376.png">
					<p>FC 서울</p>
				</div>
				<div class="vs"> 
					<p>VS</p>
				</div>
				<div class="away">
					<img alt="포항로고" src="https://fcseoulpub.s3.ap-northeast-2.amazonaws.com/multi01/Club/Club/em_K03.png">
					<p>포항</p>
				</div>
				</div>
		</div>
		<div class="ticketbtn">
			<a href="">티켓예매</a>
		</div>
	</div>
	<!-- 티켓예매 -->


	<!-- 배너 -->
	<div class="wrap">
        <header class="header">
        <!-- 배너 -->
            <div class="subheader">
                <div class="header1">
                    <div class="left">
                        <ul>
                            <li><a href="" target="_blank"><img src="https://www.fcseoul.com/resources/front/images/common/btn_sns1.png" alt=""></a></li>
                            <li><a href="" target="_blank"><img src="https://www.fcseoul.com/resources/front/images/common/btn_sns2.png" alt=""></a></li>
                            <li><a href="" target="_blank"><img src="https://www.fcseoul.com/resources/front/images/common/btn_sns3.png" alt=""></a></li>
                            <li><a href="" target="_blank"><img src="https://www.fcseoul.com/resources/front/images/common/btn_vr.png" alt=""></a></li>
                        </ul>
                    </div>
                    <div class="center">
                        <a href="#"><img src="https://www.fcseoul.com/resources/front/images/common/img_logo_gold.png" alt=""></a>
                    </div>
                    <div class="right">
                        <ul>
                            <li><a href="">FAQ</a></li>
                            <li><a href="">회원가입</a></li>
                            <li><a href="">로그인</a></li>
                            <li><a href="" class="eng">ENG</a></li>
                        </ul>
                    </div>
                </div>  
                <div class="header2">
      <!-- 클릭 -->	<div class="allmenu" id="amenu" >
                        <span class="all1"></span>
                        <span class="all2"></span>
                        <span class="all3"></span>
                    </div>
                    <ul class="menulist">
                        <li id="media"><a href="">MEDIA</a></li>
                        <li id="matches"><a href="">Matches</a></li>
                        <li id="tickets"><a href="">Tickets</a></li>
                        <li id="membership"><a href="">Membership</a></li>
                        <li id="club"><a href="">Club</a></li>
                        <li id="fanzone"><a href="">Fanzone</a></li>
                        <li id="shopb"><a href="" class="shop">shop</a></li>
                    </ul>
                </div>
            </div>
        <!-- 배너 -->
        <!-- 메뉴드롭 -->
        	<div class="bannerList">
        		<div class="subBanner">
      <!-- 나옴 -->  	<div class="allList" id="alist" style="display: none;">
        				<div class="list1">
        					<div class ="list1box" style="width: 135px">	
        						<ul>
        							<li><a href="">NEWS</a></li>
        							<li><a href="">NOTICE</a></li>
        							<li><a href="">PHOTO</a></li>
        						</ul>
        					</div>		<!-- 미디어 -->
        					<div class ="list1box" style="width: 158px">
        						<ul>
        							<li> <a>일정 / 결과</a></li>
        							<li> <a>기록 / 순위</a></li>
        						</ul>
        					</div>	<!-- 매치 -->
        					<div class ="list1box" style="width: 150px">
        						<ul>
        							<li><a href= "">티켓 예매</a></li>
        							<li><a href= "">시즌티켓</a></li>
        							<li><a href= "">단체 입장권</a></li>
        							<li><a href= "">1865 스카이박스</a></li>
        						</ul>
        					</div>	<!-- 티켓 -->
        					<div class ="list1box" style="width: 220px">
        						<ul>
        							<li><a href= "">멤버십(GS&POINT) 카드</a></li>
        							<li><a href= "">멤버십(GS&POINT) 카드 안내</a></li>
        						</ul>
        					</div>	<!-- 맴버쉽 -->
        					<div class ="list1box" style="width: 125px">
        						<ul>
        							<li><a href= "">선수단 소개</a></li>
        							<li><a href="" >유스팀 소개</a></li>
        							<li><a href= "">구단 소개</a></li>
        							<li><a href= "">스폰서</a></li>
        							<li><a href= "">전자공고</a></li>
        						</ul>
        					</div>	<!-- 클럽 -->
        					<div class ="list1box"style="width: 160px">
        						<ul>
        							<li><a href= "">공식SNS</a></li>
        							<li><a href= "">소셜계시판</a></li>
        							<li><a href= "">FAQ</a></li>
        							<li><a href= "">Q&A</a></li>
        							<li><a href= "">이벤트ZONE</a></li>
        							<li><a href= "">FC서울승리버스</a></li>
        						</ul>
        					</div>	<!-- 팬좀 -->
        					<div class ="list1box" style="width: 164px">
        						<ul>
        							<li><a href= "">온라인쇼핑몰</a></li>
        						</ul>
        					</div>	<!-- 샵 -->
        				</div>
        				<div class="vrbanner">
        					<a href="#" target="_blank">
        						<img alt="vr배너" src="https://fcseoulpub.s3.ap-northeast-2.amazonaws.com/multi01/Imgs/menu_banner/1593407759624.jpg">
        					</a>
        				</div>
        			</div>
        			<div class="detailmenu">
        				<ul>
        					<li class="media dm" style="display: none;">
        						<div class="detailleft">
        							<h2>MEDIA</h2>
        							<ul>
        								<li><a href="">NEWS</a></li>
        								<li><a href="">NOTICE</a></li>
        								<li><a href="">PHOTO</a></li>
        							</ul>
        						</div>
        						<div class="detailright">
        							<div class="mediabox">
        								<h4>NEWS</h4>
        								<div>
        									<a href="#">
        										<img class="mediaimg" alt="news이미지" src="https://files.fcseoul.com/multi01/News/FcNews/1683618273221.png">
        										<p class="text">FC서울, 2023시즌 다문화 축구교실 후원금 전달식 성료</p>
        									</a>
        								</div>
        								<div>
        									<a href="#">
        										<img class="mediaimg" alt="news이미지" src="https://files.fcseoul.com/multi01/News/FcNews/1677553176924.png">
        										<p class="text">FC서울, 2023시즌 다문화 축구교실 참가자 모집</p>
        									</a>
        								</div>
        							</div>
        							<div class="mediabox">
        								<h4>NOTICE</h4>
        								<div class="noticebox">
        									<a href="">
        										<div class="nbox1">
        											<p class="ntext">2023시즌 FC서울 홈경기 장내외 장식물 제작 및 설치철거 파트너사 선정 재공고</p>
        											<div class="ntext2"><p>[나라장터 공고 바로가기]</p></div>
        											<div class="ndate">2022-12-29</div>
        										</div>
        									</a>
        								</div>
        								<div class="noticebox">
        									<a href="">
        										<div class="nbox1">
        											<p class="ntext">2023시즌 FC서울 홈경기 장내외 마케팅 파트너사 선정 재공고</p>
        											<div class="ntext2"><p>[나라장터 공고 바로가기]</p></div>
        											<div class="ndate">2022-12-29</div>
        										</div>
        									</a>
        								</div>
        							</div>
        							<div class="mediabox">
        								<h4>PHOTO</h4>
        								<div>
        									<a href="">
        										<img class="mediaimg" alt="" src="https://files.fcseoul.com/data03/img_lrg/1685399478872_b.JPG">
        										<p class="text">[K리그1 15R 강원(H)] 팬과 선수들 하나가 되어 승리의 랄랄라 송을 부르고 있다.</p>
        									</a>
        								</div>
        								<div>
        									<a href="">
        										<img class="mediaimg" alt="" src="https://files.fcseoul.com/data03/img_lrg/1685399399842_b.JPG">
        										<p class="text">[K리그1 15R 강원(H)] 팬들앞에서 펼치는 승리의 세레머니 김주성</p>
        									</a>
        								</div>
        							</div>
        						</div>
        					</li>
        					<li class="matches dm"  style="display: none;" >
        						<div class="detailleft">
        							<h2>MATCHES</h2>
        							<ul>
        								<li><a href="">일정 / 결과</a></li>
        								<li><a href="">기록 / 순위</a></li>
        							</ul>
        						</div>
        						<div class="detailright">
        							<div class="mbox">
        								<h4>PREV MATCHES</h4>
        								<div class="scorebox">
        									<div class="mleft">
        										<img alt="FC서울 logo" src="https://fcseoulpub.s3.ap-northeast-2.amazonaws.com/multi01/Club/Club/1675316444376.png">
        										<p>FC 서울</p>
        									</div>
        									<div class="mcenter">
        										<div class="mc1">
        											<p>0</p>	<!-- 졌을때 클래스 -->
        											<p>:</p>	
        											<p>1</p>	<!-- 이겼을때 클래스 -->
        										</div>
        									</div>
        									<div class="mright">
        										<img alt="대구 logo" src="https://fcseoulpub.s3.ap-northeast-2.amazonaws.com/multi01/Club/Club/em_K17.png">
        										<p>대구</p>
        									</div>
        									<div class="matchtime">
        										<p>2023.06.04(일) 19:00</p>
        										<p>DGB대구은행파크</p>
        									</div>
        									<div class="matchresult">
        										<a href="">경기결과</a>
        									</div>
        								</div>
        							</div>
        							<div class="mbox mid">
        								<h4>NEXT MATCHES</h4>
        								<div class="scorebox">
        									<div class="mleft">
        										<img alt="FC서울 logo" src="https://fcseoulpub.s3.ap-northeast-2.amazonaws.com/multi01/Club/Club/1675316444376.png">
        										<p>FC 서울</p>
        									</div>
        									<div class="mcenter">
        										<p class="vs">VS</p>
        									</div>
        									<div class="mright">
        										<img alt="인천 logo" src="https://fcseoulpub.s3.ap-northeast-2.amazonaws.com/multi01/Club/Club/em_K18.png">
        										<p>인천</p>
        									</div>
        								</div>
        								<div class="matchtime">
        									<p>2023.06.07(수) 19:30</p>
        									<p>인천축구전용경기장</p>
        								</div>
        								<div class="nomatch" style="display: none;">		<!-- 매치가 없을때 사용-->
        									<img alt="" src="https://www.fcseoul.com/resources/front/images/common/nogame_dropdown.jpg">
        								</div>
        							</div>
        							<div class="mbox2">
        								<p>
        									<img alt="k리그 logo" src="https://www.fcseoul.com/resources/front/images/common/ico_kLeague.png">
        									K LEAGUE 1
        								</p>
        								<p>현재순위 (16경기 기준)</p>
        								<p>
        									<strong>3</strong>
        									위
        								</p>
        								<div class="teamrecode">
        									<span>
        										<b>8</b>
        										승
        									</span>
        									<span>
        										<b>3</b>
        										무
        									</span>
        									<span>
        										<b>5</b>
        										패
        									</span>
        									<span>
        										<b>27</b>
        										점
        									</span>
        								</div>
        								<div class="allrecode">
        									<a href="" class="arbtn">전체순위</a>
        								</div>
        							</div>
        						</div>
        					</li>
        					<li class="tickets dm"  style="display: none;" >
        						<div class="detailleft">
        							<h2>TICKETS</h2>
        							<ul>
        								<li><a href="">티켓 예매</a></li>
        								<li><a href="">시즌티켓</a></li>
        								<li><a href="">단체 입장권</a></li>
        								<li><a href="">1865 스카이박스</a></li>
        							</ul>
        						</div>
        						<div class="detailright">
        							<a href="">
        								<img alt="" src="https://www.fcseoul.com/resources/front/images/common/img_drop_t4.jpg?20230216">
        							</a>
        						</div>
        					</li>
        					<li class="membership dm"  style="display: none;" >
        						<div class="detailleft">
        							<h2>MEMBERSHIP</h2>
        							<ul>
        								<li><a href="" onclick="ready()">멤버십(GS&POINT) 카드</a></li>
        								<li><a href="" onclick="ready()">멤버십(GS&POINT) 카드 안내</a></li>
        							</ul>
        						</div>
        						<div class="detailright">
									<div class="membox">	 <!-- float left marginleft 60px  -->
        								<a href="">
        									<img alt="" src="https://www.fcseoul.com/resources/front/images/common/img_drop_m1.jpg">
        								</a>
        							</div>
        							<div class="membox">
        								<a href="">
        									<img alt="" src="https://www.fcseoul.com/resources/front/images/common/img_drop_m2.jpg">
        								</a>
        							</div>
        						</div>
        					</li>
        					<li class="club dm"  style="display: none;" >
        						<div class="detailleft">
        							<h2>CLUB</h2>
        							<ul>
        								<li><a href="">선수단 소개</a></li>
        								<li><a href="" onclick="ready()">유스팀 소개</a></li>
        								<li><a href="">구단 소개</a></li>
        								<li><a href="" onclick="ready()">스폰서</a></li>
        								<li><a href="" onclick="ready()">전자공고</a></li>
        							</ul>
        						</div>
        						<div class="rightclub">
        							<div class="clubbox">
        								<div class="lbtn "> <img alt="" src="https://www.fcseoul.com/resources/front/images/sub/common/btn_seatPrev.png"> </div>
	        								<ul>
	        									<li>
	        										<a href="">
	        											<div class="pinfo">
	        												<p class="position">
	        													<span>FW</span> 
	        													<span>7</span>
	        												</p>	
	        												<p class="name">나상호</p> 	
	        												<br>
	        												<p class="goal"> 
	        													<strong>득점</strong> <span>8</span>
	        												</p>
	        												<p class="assist">
	        													<strong>도움</strong> <span>2</span>
	        												</p>
	        											</div>
	        											<img alt="" src="https://files.fcseoul.com/data03/Club/front_sml_img/1676855921670.png">
	        										</a>
	        									</li>	
	        									<!-- 	
	        									<li>
	        										<a href="">
	        											<div class="pinfo1">
	        												<span>MF</span> 
	        												<span>5</span> <br>
	        												<p>오스마르</p>
	        											</div>
	        											<img alt="" src="https://files.fcseoul.com/data03/Club/front_sml_img/1676857759521.png">
	        										</a>
	        									</li>
	        									<li>
	        										<a href="">
	        											<div class="pinfo2">
	        												<span>DF</span> 
	        												<span>2</span> <br>
	        												<p>황현수</p>
	        											</div>
	        											<img alt="" src="https://files.fcseoul.com/data03/Club/front_sml_img/1676858623975.png">
	        										</a>
	        									</li>
	        									<li>
	        										<a href="">
	        											<div class="pinfo3">
	        												<span>GK</span> 
	        												<span>1</span> <br>
	        												<span>백종범</span>
	        											</div>
	        											<img alt="" src="https://files.fcseoul.com/data03/Club/front_sml_img/1676857424509.png">
	        										</a>
	        									</li>
	        									 -->
	        								</ul>
	        							<div class="rbtn"> <img alt="" src="https://www.fcseoul.com/resources/front/images/sub/common/btn_seatNext.png"> </div>
        							</div>
        							<div class="clubbox">
        								<a href="">
        									<img alt="FC서울 유스" src="https://www.fcseoul.com/resources/front/images/common/img_drop_c2.jpg?2023022101">
        								</a>
        							</div>
        							<div class="clubbox">
        								<a href="">
        									<img alt="코칭스태프" src="https://www.fcseoul.com/resources/front/images/common/img_drop_c3.jpg?210909">
        								</a>
        							</div>
        						</div>
        					</li>
        					<li class="fanzone dm"  style="display: none;" >
        						<div class="detailleft">
        							<h2>FAN ZONE</h2>
        							<ul>
        								<li><a href="">공식 SNS</a></li>
        								<li><a href="SocialBoard.jsp?id=<%=id%>">소셜게시판</a></li>
        								<li><a href="">FAQ</a></li>
        								<li><a href="">Q&A</a></li>
        								<li><a href="" onclick="ready()">이벤트 ZONE</a></li>
        								<li><a href="" onclick="ready()">FC서울 승리버스</a></li>
        							</ul>
        						</div>
        						<div class="detailright">
        							<div class="fanbox">	<!-- margin-left27px  float left-->
        								<a href="">
        									<img alt="" src="https://www.fcseoul.com/resources/front/images/common/img_drop_f3.jpg">
        								</a>
        							</div>
        							<div class="fanbox">
        								<a href="">
        									<img alt="" src="https://www.fcseoul.com/resources/front/images/common/img_drop_f2.jpg">
        								</a>
        							</div>
        							<div class="fanbox">
        								<a href="">
        									<img alt="" src="https://www.fcseoul.com/resources/front/images/common/img_drop_f1.jpg">
        								</a>
        							</div>
        						</div>
        					</li>
        					<li class="shopb dm"  style="display: none;" >
        						<div class="detailleft">
        							<h2>SHOP</h2>
        							<ul>
        								<li><a href="" class="dshop">온라인 쇼핑몰</a></li>
        							</ul>
        						</div>
        						<div class="detailright">
        							<div class="shopbox">
        								<strong>BEST ITEM</strong>
        								<div class="shopitem">
        								
        									<div class="inner">
        										<div class="lbtn"> <img alt="" src="https://www.fcseoul.com/resources/front/images/sub/common/btn_seatPrev.png"> </div>
	        										<div class="inner1">
		        										<ul>
		        											<div class="shopslide">
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
																			<img alt="" src="	https://files.fcseoul.com/multi01/SHOP/Product/Product/202341979204_S.jpg">
																		</div>
																		<p>23 개인 마킹</p>
																		<p class="price">₩17,000</p>
			        												</a>
			        											</li>
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
			        														<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/202282052545_S.jpg">
			        													</div>
			        													<p> 22. FC서울 레인보우 LAMP</p>
			        													<p class="price">₩15,000</p>
			        												</a>
			        											</li>
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
			        														<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/202271211194_S.jpg">
			        													</div>
			        													<p>22 FCSEOUL 타투 스티커</p>
			        													<p class="price">₩3,500</p>
			        												</a>
			        											</li>
			        											<li>
		        												<a href="">
		        													<div class="shopimg">
		        														<img alt="" src="	https://files.fcseoul.com/multi01/SHOP/Product/Product/202282049176_S.jpg">
		        													</div>
		        													<p>22. FC서울 포토레인보우 (기성용)</p>
		        													<p class="price">₩10,000</p>
		        												</a>
		        											</li>
		           											</div>
		           										</ul>
		           										<ul>
		           											<div class="shopslide">	
			           											<li>
			        												<a href="">
			        													<div class="shopimg">
			        														<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/20231350501_S.jpg">
			        													</div>
			        													<p>23시즌 K리그 공식패치</p>
			        													<p class="price">₩13,000</p>
			        												</a>
			        											</li>
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
			        														<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/202315420300_S.jpg">
			        													</div>
			        													<p>23 GS칼텍스 (골드,필드용)</p>
			        													<p class="price">₩6,000</p>
			        												</a>	
			        											</li>
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
			        														<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/202315421730_S.jpg">
			        													</div>
			        													<p>23 팔 스폰서 (홈)</p>
			        													<p class="price">₩20,000</p>
			        												</a>
			        											</li>
			        											<li>
		        												<a href="">
		        													<div class="shopimg">
		        														<img alt="" src="	https://files.fcseoul.com/multi01/SHOP/Product/Product/202315421311_S.jpg">
		        													</div>
		        													<p>23 팔 스폰서 (어웨이)</p>
		        													<p class="price">₩20,000</p>
		        												</a>
		        											</li>
		        											</div>
		        										</ul>
		        										<ul>
		        											<div class="shopslide">
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
			        														<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/202315423790_S.jpg">
			        													</div>
			        													<p>23 등번호+이름 (골드,필드용)</p>
			        													<p class="price">₩17,000</p>
			        												</a>
			        											</li>
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
				        													<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/2022814549652_S.jpg">
			        													</div>
				        												<p>22. FC서울 WHITE 니트머플러</p>
				        												<p>₩23,000</p>
			        												</a>
			        											</li>
			        											<li>
			        												<a href="">
			        													<div class="shopimg">
				        													<img alt="" src="https://files.fcseoul.com/multi01/SHOP/Product/Product/2023127545997_S.jpg">
			        													</div>
				        												<p>23 신한플레이 (골드, 필드용)</p>
				        												<p class="price">₩6,000</p>
			        												</a>
			        											</li>
			        											<li>
		        												<a href="">
			        												<div class="shopimg">
			        													<img alt="" src="	https://files.fcseoul.com/multi01/SHOP/Product/Product/2023424111888_S.jpg">
			        												</div>
			        												<p>이달의 선수 패치</p>
			        												<p class="price">₩13,000</p>
		        												</a>
		        											</li>
		        											</div>
		        										</ul>
		        									</div>
	        									<div class="rbtn"> <img alt="" src="https://www.fcseoul.com/resources/front/images/sub/common/btn_seatNext.png"> </div>
        									</div>
        									
        								</div>
        							</div>
        						</div>
        					</li>
        				</ul>
        			</div>	
        		</div>
        	</div>
        </header>
    </div>
	<!-- 배너 -->
	<div class="bannerlayer" style="display: none;"></div>
	<div class="bannerlayer2" style="display: none;"></div>
	<!-- 메인 -->
	<section class="bannertop">
				<div class="container">
					<h2>TICKETS</h2>
				</div>
				<div class="contentButton">
					<div class="content">
						<ul>
							<li class="home"><a href="https://www.fcseoul.com/"></a></li>

							<li>
								<button class="button">
									TICKETS</button>
								<ul id="buttonUI" class = button123 style="display: none;">
									<li><a href="https://www.fcseoul.com/media/newsList">MEDIA</a>
									</li>
									<li><a
										href="https://www.fcseoul.com/Cmatches/schresultList">MATCHES</a>
									</li>
									<li><a
										href="https://www.fcseoul.com/tickets/reserveSingleTicket">TICKETS</a>
									</li>
									<li><a
										href="https://www.fcseoul.com/club/clubPlayerIntroductionList/FW">CLUB</a>
									</li>
									<li><a href="https://www.fcseoul.com/fanzone/sns">FAN
											ZONE</a></li>
								</ul>
							</li>

							<li>
								<button class="button">
									티켓 예매</button>
								<ul id="buttonUI2" class = button123 style="display: none;">
									<li><a href="http://localhost:9080/FCseoul/MatchInfo.html">티켓 예매</a>
									</li>
									<li><a href="http://localhost:9080/FCseoul/rankingList.html">시즌티켓</a>
									</li>
									<li><a href="http://localhost:9080/FCseoul/rankingList.html">단체 입장권</a>
									</li>
									<li><a href="http://localhost:9080/FCseoul/rankingList.html">1865 스카이박스</a>
									</li>
								</ul>
							</li>
						</ul>
					</div>
				</div>
		</section>
		<div class="mainSection">
			
				
			<div class="sns1">
			<div class="sns1top">
				<div class="sns1left">
					<span>share</span>
					<img alt="" src="https://www.fcseoul.com/resources/front/images/sub/common/ico_gt.png">
					<a href="">
						<img alt="" src="https://www.fcseoul.com/resources/front/images/sub/common/ico_sns1.png">
					</a>
				</div>
				<h3>소셜계시판</h3>
				<div class="sns1right">
					<button>URL 복사</button>
				</div>
			</div>
			<!--계시판이용안내  -->
			<div class="howtouse">
				<img alt="" src="https://www.fcseoul.com/resources/front/images/sub/fanzone/img__sbGuide.png">
				<div class="howtousetext">
					<p> <strong>계시판 이용안내</strong> </p>
					<p>
						건전한 소셜게시판 문화 조성을 위해 
						<span> 비방이나 불쾌감 조성, 부적절 언어, 반사회적 질서행위, 광고성 글, 기타 그 밖에 이와 유사한 글</span> 
						등이 관리자의 모니터링을 통해 확인되는 경우 홈페이지(서비스 이용) 약관에 따라 별도의 고지 없이 게시(댓글)글이 삭제될 수 있으며, 상습적이거나 그 정도가 심한 경우에는 부득이 계정 차단 및 기타 조치가 이루어 질 수 있는 점 양지하여 주시기 바랍니다. 감사합니다.
					</p>
				</div>
			</div>
			
			<div class="socialtop">
				<h4>소셜 계시판</h4>
				<form action="SocialBoard.jsp">
					<input type="hidden" name="id" value="<%=id %>"/>
					<input type="hidden" name="page" value="1"/>
					<select class="selectbox" name="search">
						<option value="all">전체</option>
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="name">이름/닉네임</option>
					</select>
					<input class="searchbox" type="text" name="searchTxt" placeholder="검색어를 입력해주세요.">
					<input class="submitbox" type="submit" name="searchBtn" value="검색">
				</form>
			</div>
			
			<table>
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>댓글</th>
				</tr>
				<%
				for(SocialBoardDto sbDto : sbMainList) {
				%>
					<tr>
						<td><%=sbDto.getBno() %></td>
						<td> <a href="SocialBoardDetail.jsp?id=<%=id %>&bno=<%=sbDto.getBno()%>&page=<%=pageNum%>"><%=sbDto.getTitle() %></a></td>
						<td>
							<div class="writer">
								<img alt="" src="https://www.fcseoul.com/resources/front/images/sub/fanzone/ico__login_fs.jpg">
								<%=sbDto.getName() %>
							</div>
						</td>
						<td><%=sbDto.getwDate() %></td>
						<td><%=sbDto.getrNum() %></td>
					</tr>
				<%
				}
				%>
			</table>
			
			<div class="sociallast">
				<div class="numpage">
					<a href="SocialBoard.jsp?page=<%=pageNum-1%>&searchBtn=&search="></a>
					<%
					for(int i=1; i<=count/10+1; i++) {
						if(pageNum == i) {
						%>
							<a class="pnum on" href="SocialBoard.jsp?page=<%=i%>&searchBtn=&search="><%=i %></a>
						<%
						} else {
						%>
							<a class="pnum" href="SocialBoard.jsp?page=<%=i%>&searchBtn=&search="><%=i %></a>
						<%	
						}
					}
					if (pageNum == count/10+1) {
					%>
						<a href="SocialBoard.jsp?page=<%=count/10+1%>&searchBtn=&search="></a>
					<%
					} else {
					%>
						<a href="SocialBoard.jsp?page=<%=pageNum+1%>&searchBtn=&search="></a>
					<%	
					}
					%>
				</div>
				<div class="writebtn">
					<a href="SocialBoardWrite.jsp?id=<%=id%>&page=<%=pageNum%>&searchBtn=&search=">
						<span>쓰기</span>
					</a>
				</div>
			</div>
		</div>
			
			
		</div>
	<!-- 메인 -->
<footer class="footer" id="footer">
			<section class="mainbot">
				<div class="contentwrap">
					<div class="sponsorwrap">
						<strong> main sponsors </strong>
						<div class="imgl">
							<a href="http://www.gs.co.kr" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_01.jpg
                                                                "
								alt="GS">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.gsenc.com/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_02.jpg?20230310"
								alt="GS건설">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.gscaltex.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_03.jpg"
								alt="GS칼텍스]">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.gs25.gsretail.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_05.jpg"
								alt="GS 25">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.gsshop.com" target="_blank"> <img
								src="        https://www.fcseoul.com/resources/front/images/main/sponsor/img_04.jpg"
								alt="GS SHOP">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.gseps.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_06.jpg"
								alt="GS EPS">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.gspower.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_07.jpg"
								alt="GS 파워">
							</a>
						</div>

					</div>
					<div class="sponsorwrap">
						<strong> official sponsors </strong>
						<div class="imgl">
							<a href="http://www.shinhancard.com" target="_blank"> <img
								src="        https://www.fcseoul.com/resources/front/images/main/sponsor/img_08.jpg
                                                                "
								alt="신한카드">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.truefriend.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_09.jpg"
								alt="한국투자증권">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.kbinsure.co.kr" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_10.jpg"
								alt="KB손해보험">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.kbsec.com/go.able" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_11.jpg"
								alt="KB증권">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.nhqv.com/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_12.jpg"
								alt="NH투자증권">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.uplus.co.kr" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_13.jpg
                                                                "
								alt="엘지유플러스">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.lgensol.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_14.jpg"
								alt="엘지 에너지솔루션">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.lgchem.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_15.jpg"
								alt="엘지화학">
							</a>
						</div>
					</div>
					<div class="sponsorwrap2">
						<strong> official kit supplier </strong>
						<div class="imgl">
							<a href="http://www.prospecs.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_16.jpg"
								alt="프로스펙스">
							</a>
						</div>
					</div>
					<div class="sponsorwrap3">
						<strong> ofiicial principal partners </strong>
						<div class="imgl">
							<a href="http://www.tmon.co.kr" target="_blank"> <img
								src="        https://www.fcseoul.com/resources/front/images/main/sponsor/img_18.jpg"
								alt="티몬">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.han-don.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_17.jpg?20230310"
								alt="한돈">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.keumyang.com" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_20.jpg?20230310"
								alt="1865">
							</a>
						</div>
						<div class="imgr">
							<a
								href="http://www.https://www.theclasshyosung.com/ko/desktop/passenger-cars.html"
								target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_21.jpg"
								alt="더클래스 효성">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.heineken.com/nl" target="_blank"> <img
								src="        https://www.fcseoul.com/resources/front/images/main/sponsor/img_19.jpg"
								alt="하이네켄">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.hurom.co.kr/" target="_blank"> <img
								src="        https://www.fcseoul.com/resources/front/images/main/sponsor/img_22.jpg?20230310"
								alt="휴롬">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.https://www.fedex.com/ko-kr/home.html"
								target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/logo-37.jpg"
								alt="페덱스">
							</a>
						</div>
					</div>
					<div class="sponsorwrap">
						<strong> ofiicial partners </strong>
						<div class="imgl">
							<a href="http://seoultwotop.com/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_25.jpg"
								alt="서울투탑정형외과 재활의학과">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.madisesang.com/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_24.jpg"
								alt="마디세상병원">
							</a>
						</div>
						<div class="imgl">
							<a href="http://www.xn--9m1b22a80igvdu3q.kr/" target="_blank">
								<img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_00.jpg"
								alt="더드림병원">
							</a>
						</div>
						<div class="imgr">
							<a href="https://www.seoul1hospital.com/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_23.jpg?20230310"
								alt="서울원병원">
							</a>
						</div>
						<div class="imgl">
							<a href="https://www.redcap.co.kr/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_27.jpg?20230310"
								alt="redcap투어">
							</a>
						</div>
						<div class="imgr">
							<a href="http://www.cocacola.co.kr/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_28.jpg
                                                                "
								alt="코카콜라">
							</a>
						</div>
						<div class="imgl">
							<a href="https://amigonacho.com/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/main/sponsor/img_31.jpg"
								alt="아미고">
							</a>
						</div>
					</div>
				</div>
				<div style="clear: both;"></div>
			</section>
			<div class="contentwrap2">
				<div class="footer1">
					<div class="foot">
						<div class="pri">
							<a href="">개인정보처리방침</a>
						</div>
						<div class="pri1">
							<a href="">이용약관</a>
						</div>
						<div class="pri1">
							<a href="">이메일무단수집거부</a>
						</div>
						<div class="pri1">
							<a href="">사이트맵</a>
						</div>
						<div class="pri1">
							<a href="">윤리경영제보</a>
						</div>
						<div class="pri1">
							<a href="">마케팅 제휴문의</a>
						</div>
						<div class="pri2">
							<a href="https://www.fcseoul.com/vr/stadium" target="_blank">
								<img
								src="        https://www.fcseoul.com/resources/front/images/common/btn_vr.png"
								alt="경기장 vr 보기">
							</a>
						</div>
						<div class="pri2">
							<a href="http://www.youtube.com/user/FCSEOUL" target="_blank">
								<img
								src="https://www.fcseoul.com/resources/front/images/common/btn_sns3.png"
								alt="유튜브">
							</a>
						</div>
						<div class="pri2">
							<a href="https://instagram.com/fcseoul/" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/common/btn_sns2.png"
								alt="인스타그램">
							</a>
						</div>
						s
						<div class="pri2">
							<a href="https://www.facebook.com/fcseoul" target="_blank"> <img
								src="https://www.fcseoul.com/resources/front/images/common/btn_sns1.png"
								alt="페이스북">
							</a>
						</div>
					</div>
					<div style="clear: both;"></div>
				</div>
				<div class="footer2">
					<div class="foot1">
						<img
							src="https://www.fcseoul.com/resources/front/images/common/img_logo_gray.png"
							alt="FC SEOUL">
					</div>
					<div class="foot2">
						<ul>
							<li>대표자명 : 여은주</li>
							<li>대표전화 : 02-306-5050</li>
							<li>개인정보정책책임자 : 이재근</li>
							<li>서울시 마포구 월드컵로 240 서울월드컵경기장 내</li>
						</ul>
						<p>Copyright©2019 GS Sports Football Club Seoul</p>
					</div>
					<div class="foot3">
						<img
							src="https://www.fcseoul.com/resources/front/images/common/img_award.png">
					</div>
				</div>
			</div>
		</footer>
</body>
</html>