<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<!-- jQuery -->
<!--     <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script> -->
    <!-- iamport.payment.js -->
<!--     <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script> -->
    <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8=" crossorigin="anonymous"></script>
<!--     <script> -->
<!-- // 	    const IMP = window.IMP; // 생략 가능 -->
<!-- // 	    IMP.init("imp42223837a"); -->
<!-- // 	    function requestPay() { -->
<!-- // 	        IMP.request_pay({ -->
<!-- // 	          pg: "INIpayTest", -->
<!-- // 	          pay_method: "card", -->
<!-- // 	          merchant_uid: "ORD20180131-0000011",   // 주문번호 -->
<!-- // 	          name: "노르웨이 회전 의자", -->
<!-- // 	          amount: 64900,                         // 숫자 타입 -->
<!-- // 	          buyer_email: "gildong@gmail.com", -->
<!-- // 	          buyer_name: "홍길동", -->
<!-- // 	          buyer_tel: "010-4242-4242", -->
<!-- // 	          buyer_addr: "서울특별시 강남구 신사동", -->
<!-- // 	          buyer_postcode: "01181" -->
<!-- // 	        }, function (rsp) { // callback -->
<!-- // 	          //rsp.imp_uid 값으로 결제 단건조회 API를 호출하여 결제결과를 판단합니다. -->
	          
<!-- // 	        }); -->
<!-- // 	      } -->
<!--     </script> -->
<script>
  function cancelPay() {
    jQuery.ajax({
      // 예: http://www.myservice.com/payments/cancel
      "url": "http://localhost:9090/WebProject1/EShopBuyCheckP2.jsp?id=hjw2643&oQty=1&goodsId=109&goodsSize=%EC%8B%A4%EB%B2%84&oQty=1&goodsId=108&goodsSize=%EC%BB%AC%EB%9F%AC&oQty=1&goodsId=84&goodsSize=FREE&delOption=%EB%B0%B0%EC%86%A1&oName=%ED%99%A9%EC%9E%AC%EC%9B%85&oEmail=hjw9981%40naver.com&oHTel1=&oHTel2=&oHTel3=&oPTel1=010&oPTel2=3236&oPTel3=2637&oPosNum=03302&oAddr1=%EC%A7%84%EA%B4%80%EB%8F%99&oAddr2=&req=+&payWay=%EC%8B%A0%EC%9A%A9%EC%B9%B4%EB%93%9C&buyBtn=instance", 
      "type": "POST",
      "contentType": "application/json",
      "data": JSON.stringify({
        "merchant_uid": "82568", // 예: ORD20180131-0000011
        "cancel_request_amount": 22000, // 환불금액
        "reason": "테스트 결제 환불" // 환불사유
        // [가상계좌 환불시 필수입력] 환불 수령계좌 예금주
        "refund_holder": "황재웅", 
        // [가상계좌 환불시 필수입력] 환불 수령계좌 은행코드(예: KG이니시스의 경우 신한은행은 88번)
        "refund_bank": "98" 
        // [가상계좌 환불시 필수입력] 환불 수령계좌 번호
        "refund_account": "110269565040" 
      }),
      "dataType": "json"
    });
  }
</script>
</head>
<body>
	<button onclick="cancelPay()">환불하기</button>


</body>
</html>