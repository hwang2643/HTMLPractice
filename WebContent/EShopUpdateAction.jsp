<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.EShopInsertActionDto"%>
<%@page import="dao.EShopUpdateActionDao"%>
<%

	String goodsId[] = request.getParameterValues("goodsId");
	String id = request.getParameter("id");
	String goodsSize[] = request.getParameterValues("goodsSize");
	String btnType = request.getParameter("btnType");
	String prdCheck[] = request.getParameterValues("prdCheck");
	String cartBtn = request.getParameter("cBtn");
	String wishListBtn = request.getParameter("wlBtn");
	String oQty[] = request.getParameterValues("amount");
// 	String cartQty[] = request.getParameterValues("qty");
// 	int buyPrdId = Integer.parseInt(request.getParameter("buyPrdId"));

	
	int idx = 0;
	for(int i=0; i<=goodsId.length-1; i++){
		if(cartBtn.equals("cDup"+i) || cartBtn.equals("cDel"+i)) {
			idx = i;
		}
	}
	
	EShopUpdateActionDao UpdateActDao = new EShopUpdateActionDao();
	EShopInsertActionDto goodsSel = UpdateActDao.goodsSel(goodsId[idx], goodsSize[idx]);
	String goodsImg = goodsSel.getGoodsImg();
	String goodsName = goodsSel.getGoodsName();
	int inventory = goodsSel.getInventory();
	int price = goodsSel.getPrice();
	
	
	
	boolean bc = false;
	boolean bw = false;
	boolean cartDup = false;
	boolean cartDel = false;
	boolean wishListDelAll = false;
	boolean wishListDelSel = false;
	
	
	if(btnType.equals("cart")) {
		bc = UpdateActDao.insertCart(id, goodsId[idx], goodsImg, goodsName, goodsSize[idx], inventory, oQty[idx], price);
	} else if(btnType.equals("wishList")) {
		bw = UpdateActDao.insertWishList(id, goodsId[idx]);
	} else if(cartBtn.equals("cDup"+idx)) {
		cartDup = UpdateActDao.cartDuplication(goodsId[idx], goodsSize[idx], oQty[idx], id);
	} else if(cartBtn.equals("cDel"+idx)) {
		cartDel = UpdateActDao.cartDelete(id, goodsId[idx], goodsSize[idx]);
	} else if(wishListBtn.equals("wlDelAll")){
		wishListDelAll = UpdateActDao.wishListDeleteAll(id);
	} else if(wishListBtn.equals("wlDelSel")) {
		for(int i=0; i<=goodsId.length-1; i++) {
			wishListDelSel = UpdateActDao.wishListDeleteSelect(id, goodsId[i]);
		}
	}
	int cnt = 0;
	if(bc || cartDup || cartDel) {
		cnt = 1;
	} else if(bw || wishListDelAll || wishListDelSel) {
		cnt = 2;
	} else if(btnType.equals("buy") || cartBtn.equals("buySel") || cartBtn.equals("buyAll")) {
		cnt = 3;
	}
// 	System.out.println(cnt);
%>
<script>
	
	if(<%=cnt%> == 1) {
		location.href="EShopCart.jsp?id=<%=id%>";
	} else if(<%=cnt%> == 2) {
		location.href="EShopWishList.jsp?id=<%=id%>";
	} 
<%-- 	else if(<%=cnt%> == 3) { --%>
<%-- 		location.href="EShopBuy.jsp?id=<%=id%>&goodsId=<%=goodsId[idx]%>&goodsSize=<%=goodsSize[idx]%>&amount=<%=oQty[idx]%>"; --%>
// 	}
</script>