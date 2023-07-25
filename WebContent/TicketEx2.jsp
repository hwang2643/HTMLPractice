<%@ page language="java" contentType="text/html; charset=UTF-8"											
pageEncoding="UTF-8"%>	
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.HashMap"%>
<%@page import="java.sql.*"%>
<%
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String dbId = "project";
	String dbPw = "p1234";
%>
<%
	HashMap<String, String> hashMap = new HashMap<>();
	JSONArray jsonArray = new JSONArray();
	
	Class.forName(driver);
	Connection conn = DriverManager.getConnection(url, dbId, dbPw);
	
	String sql = "SELECT * FROM seat";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	
	ResultSet rs = pstmt.executeQuery();
	
	while(rs.next()) {
// 		hashMap = new HashMap<>();
		hashMap.put("section", rs.getString("section"));
		hashMap.put("x_start", rs.getString("x_start"));
		hashMap.put("x_end", rs.getString("x_end"));
		hashMap.put("y_start", rs.getString("y_start"));
		hashMap.put("y_end", rs.getString("y_end"));
		JSONObject seat = new JSONObject(hashMap);
		jsonArray.add(seat);
	}
	
	rs.close();
	pstmt.close();
	conn.close();
	
// 	out.println(jsonArray.toJSONString());
%>										
<!DOCTYPE html>											
<html>											
<head>											
	<meta charset="UTF-8">										
	<title>Insert title here</title>										
	<link rel="stylesheet" href="Ticket.css">	
	<script src="js/jquery-3.7.0.min.js"></script>								
	<script>                
            document.addEventListener("DOMContentLoaded", function() {
            const canvas = document.getElementById("canvas");
            const tooltip = document.getElementById("cursor");
            const canvasDraw = document.getElementById("canvasDraw");
            const h1 = document.querySelector(".h1");
            const h2 = document.querySelector(".h2");
            const ctx = canvas.getContext("2d");
            const ctxDraw = canvasDraw.getContext("2d");

            const img = new Image();
            img.src =
              "https://image.toast.com/aaaaab/ticketlink/TKL_CONCERT/fcseoul_2023_area_0414.png?2048x2048";
            img.onload = function() {
              ctx.drawImage(img, 65, 30, 550, 550);
            };

            canvas.onmousemove = function(event) {
              const x = event.clientX - canvas.offsetLeft;
              const y = event.clientY - canvas.offsetTop;

              if (x >= 238 && x <= 282 && y >= 318 && y <= 370) {
                tooltip.textContent = "동측G구역 \n [동측지정석] 0석";
                tooltip.style.left = event.clientX + "px";
                tooltip.style.top = event.clientY + "px";
                tooltip.style.display = "block";

                document.onclick = function(event) {
                  canvas.style.display = "none";
                  canvasDraw.style.display = "block";
                  h1.style.display = "none";
                  h2.style.display = "block";
                  tooltip.style.display = "none";
                };
              } else {
                tooltip.style.display = "none";

                document.onclick = function(event) {
                  alert("준비중 입니다.");
                };
              }
            };

            for (let i = 220; i < 458; i += 14) {
              for (let j = 150; j < 458; j += 14) {
                ctxDraw.fillStyle = "#e0e0e0";
                ctxDraw.fillRect(i, j, 10, 10);
              }
            }

            ctxDraw.clearRect(290, 150, 98, 56);
            ctxDraw.fillRect(304, 124, 66, 64);

            let jArr = <%=jsonArray.toJSONString()%>;
            let clickArr = [];

            canvasDraw.onmousemove = function(event) {
              const x = event.clientX - canvasDraw.offsetLeft;
              const y = event.clientY - canvasDraw.offsetTop;
              let tooltipText = "";

              for (let i = 0; i < jArr.length; i++) {
                const region = jArr[i];
                if (
                  x >= region.x_start &&
                  x <= region.x_end &&
                  y >= region.y_start &&
                  y <= region.y_end
                ) {
                  tooltipText = `동측G구역 [동측지정석] `+(i+1)+`번`;
                  tooltip.style.left = event.clientX + "px";
                  tooltip.style.top = event.clientY + "px";
                  tooltip.textContent = tooltipText;
                  tooltip.style.display = "block";

                  canvasDraw.onclick = function(event) {
                    const rectX = region.x_start - 20;
                    const rectY = region.y_start - 173;
                    const clickX = region.x_start;
                    const clickY = region.y_start;

                    clickArr.push([clickX, clickY]);

                    ctxDraw.fillStyle = "red";
                    ctxDraw.fillRect(rectX, rectY, 10, 10);

                    canvasDraw.onclick = function(event) {
                      for (let j = 0; j < clickArr.length; j++) {
                        if (
                          clickX === clickArr[j][0] &&
                          clickY === clickArr[j][1]
                        ) {
                          ctxDraw.fillStyle = "#e0e0e0";
                          ctxDraw.fillRect(rectX, rectY, 10, 10);
                          clickArr.splice(j, 1);
                          break;
                        }
                      }
                    };
                  };
                  break;
                }
              }
            };
            canvasDraw.onmouseout = function() {
              tooltip.style.display = "none";
            };
          });
        </script>									
</head>											
<body>											
	<div id="wrap_reserve">										
		<div id="header">									
			<div class="reserve_title">								
				<h1>							
					<span class="blind"></span>						
				</h1>							
				<h2>예매</h2>							
			</div>								
			<ul class="reserve_step">								
				<li class="step1">							
					<span>날짜/회차선택</span>						
				</li>							
				<li class="step2 on">							
					<span>등급/좌석선택						
					</span>						
				</li>							
				<li class="step3">							
					<span>권종/할인/매수선택</span>						
				</li>							
				<li class="step4">							
					<span>배송선택/예매확인</span>						
				</li>							
				<li class="step5">							
					<span>결제</span>						
				</li>							
			</ul>								
		</div>									
		<div id="container">									
			<div class="reserve_content">								
				<div class="reserve_left">							
					<div class="reserve_prdt_info">						
						<p class="etc_info">					
							<span class="date">2023.07.01(토) 19:30</span>				
							<span class="place">서울월드컵경기장</span>				
						</p>					
						<div class="tit">					
							<h4 class="prdt">FC서울 vs 대전하나시티즌</h4>				
						</div>					
						<div id="cursor"></div>	
						<div id="cursor2"></div>	
						<div id="circle"></div>			
						<div class="select_seat">					
							<div class="in">				
								<canvas id="canvas" width="680" height="604" style="display: block;">			
								</canvas>			
								<canvas id="canvasDraw" width="680" height="604" style="display: none; background-color: white; z-index: 15; position: absolute;"></canvas>			
							</div>				
							<div class="select_seat_info">				
								<div class="seat_header h1" style="display: none;">			
									<strong class="txt">등급을 먼저 선택 후, 좌석선택 유형을 선택해 주세요.</strong>		
								</div>			
								<div class="seat_header h2" style="display: block;">			
									<strong class="txt">직접선택으로 예매 진행이 가능합니다. 좌석을 선택해 주세요.</strong>		
								</div>			
							</div>				
							<div class="seat_option">				
								<button type="button" id="btn_back"></button>			
							</div>				
						</div>					
					</div>						
				</div>							
				<div class="reserve_right">							
					<div class="top_info_area map_area">						
						<img src="https://image.toast.com/aaaaab/ticketlink/TKL_CONCERT/fcseoul_2023_area_0414.png?173x173"/>					
					</div>						
					<div class="reserve_artbx">						
						<div>					
							<div class="bx_tit">				
								<h4 class="reserve_tit seat_select">			
									등급선택		
								</h4>			
								<a href="#" class="btn btn_blank ng-binding">			
									새로고침		
								</a>			
							</div>				
						</div>					
						<ul class="seat_lst">					
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(68, 138, 202)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">SKY LOUNGE</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(146, 91, 194)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">c</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(146, 91, 194)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">한돈 스카이펍2 테이블석(2인)</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(32, 189, 181)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">한돈 스카이펍2 테라스석 A,B</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(146, 91, 194)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">한돈 스카이펍1테이블석(3인)</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(146, 91, 194)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">한돈 스카이펍1 테이블석(2인)</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(32, 189, 181)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">한돈 스카이펍1 테라스석 A,B</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(166, 78, 27)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">VIP테이블석(2인)</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(33, 131, 128)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">VIP테이블석(1인)</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(166, 78, 27)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">VIP테이블석 법인(2인)</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(33, 131, 128)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">VIP테이블석 법인(1인)</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(c)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">가족테이블석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:#ad8800"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">프리미엄 서측 센터지정석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:#e87e04"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">프리미엄 서측지정석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(249, 180, 45)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">서측지정석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(0, 0, 0)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">신한플레이 동측지정석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:#000456"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">북측자유석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:rgb(224, 3, 18)"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">북측지정석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
							<li>				
								<a href="" class="zero select">			
									<span class="seat_color" style="background:#80981e"></span>		
									<div class="seat_detail_info">		
										<span class="seat_grade">원정석</span>	
										<span class="seat">	
											<span class="">0</span>
											<span class="">석</span>
										</span>	
									</div>		
								</a>			
							</li>				
						</ul>					
					</div>						
					<div class="reserve_artbx">						
						<p class="reserve_notice_ly">좌석선점 및 자동배정 안내</p>					
					</div>						
					<div class="reserve_btn">						
						<a href="#" class="btn btn_blank">이전단계</a>					
						<a href="#" class="btn btn_blank">다음단계</a>					
					</div>						
				</div>							
			</div>								
		</div>									
	</div>										
</body>											
</html>												