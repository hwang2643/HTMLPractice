<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.EShopBuyDao"%>
<%
	
	String[] goodsId = request.getParameterValues("goodsId");
	String id = "";
	String delOption = "";
	String oName = "";
	String oEmail = "";
	String oPhone = "";
	String oPostalNum = "";
	String oAddress = "";
	String req = "";
	String payWay = "";
	String oQty[] = request.getParameterValues("oQty");
	String goodsSize[] = request.getParameterValues("goodsSize");
	String buyBtn = "";
	String bcBtn = "";
// 	int[] oNum = new int[goodsId.length];
// 	for(int i=0; i<=oNum.length-1; i++) {
// 		oNum[i] = ((int)((Math.random()*100000))+10000);
// 	}
	int oNum = (int)((Math.random()*100000)+10000);
	
	try{
		id = request.getParameter("id");
		delOption = request.getParameter("delOption");
		oName = request.getParameter("oName");
		oEmail = request.getParameter("oEmail");
		oPhone = request.getParameter("oPTel1") + request.getParameter("oPTel2") + request.getParameter("oPTel3");
		oPostalNum = request.getParameter("oPosNum");
		oAddress = request.getParameter("oAddr1") + request.getParameter("oAddr2");
		req = request.getParameter("req");
		payWay = request.getParameter("payWay");
		buyBtn = request.getParameter("buyBtn");
		bcBtn = request.getParameter("BCBtn");
		
	} catch(Exception e) {
		
	}
	
	
	EShopBuyDao buyDao = new EShopBuyDao();
	boolean insertPayment = false;
	boolean insertOrderHistory = false;
	
	
	if(buyBtn.equals("instance")) {
		for(int i=0; i<=goodsId.length-1; i++) {
			insertPayment = buyDao.insertPayment(id, delOption, oName, oEmail, oPhone, oPostalNum, oAddress, req, payWay, oQty[i], goodsId[i], goodsSize[i], oNum);
		}
	} else if(bcBtn.equals("buy")) {
		for(int i=0; i<=goodsId.length-1; i++) {
			insertOrderHistory = buyDao.insertOrderHistory(id, goodsId[i], goodsSize[i], oQty[i]);
		}
	}
	
	int cnt = 0;
	if(insertPayment) {
		cnt = 1;
	} else if(insertOrderHistory) {
		cnt = 2;
	}
	
	
// 	System.out.println(cnt);
%>
<script>
	if(<%=cnt%> == 1) {
		location.href="EShopBuyCheck.jsp?id=<%=id%>&goodsId=<%=goodsId[0]%>&goodsSize=<%=goodsSize[0]%>&amount=<%=oQty[0]%>";
	} else if(<%=cnt%> == 2) {
		location.href="EShopBuySuccess.jsp?id=<%=id%>&goodsId=<%=goodsId[0]%>&goodsSize=<%=goodsSize[0]%>&amount=<%=oQty[0]%>";
	}
</script>