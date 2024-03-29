package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dao.EShopCatePageDao;
import dto.EShopCatePageDto;

@WebServlet("/EShopCatePageServlet")
public class EShopCatePageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		int pageNum = 0;
		String id = request.getParameter("id");
		try{
			pageNum = Integer.parseInt(request.getParameter("page"));
			if(pageNum <= 0) {
				pageNum = 1;
			}
		} catch(NumberFormatException e) {
			pageNum = 1;
		}
		int endNum = pageNum * 15;
		int startNum = endNum - 14;
		
		int count = 0;
		
		String sel = request.getParameter("select");
		String type = request.getParameter("type");
		String maintxt = request.getParameter("maintxt");
		
		EShopCatePageDao catePageDao = new EShopCatePageDao();
//		ArrayList<EShopCatePageDto> prdList = catePageDao.EShopCateMainPrd(type, startNum, endNum, maintxt);
		ArrayList<EShopCatePageDto> prdList = null;
		ArrayList<EShopCatePageDto> prdListBest = catePageDao.EShopCateBestPrd(type, startNum, endNum, maintxt);
//		ArrayList<EShopCatePageDto> prdListprice = null;
		count = catePageDao.catePageCount(type, startNum, endNum, maintxt);
		
		switch(sel) {
		case "ALL" :
			prdList = catePageDao.EShopCateMainPrd(type, startNum, endNum, maintxt);
			break;
		case "LOW" :
			prdList = catePageDao.EShopCateMainPrdLowPrice(type, startNum, endNum, maintxt);
			break;
		case "HIGH" :
			prdList = catePageDao.EShopCateMainPrdHighPrice(type, startNum, endNum, maintxt);
		}
		response.setCharacterEncoding("utf-8");
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		JSONArray array = new JSONArray();
		for(EShopCatePageDto dto : prdList) {
			JSONObject obj = new JSONObject();
			obj.put("goodsId", dto.getGoodsId());
			obj.put("goodsImg", dto.getGoodsImg());
			obj.put("goodsName", dto.getGoodsName());
			obj.put("price", dto.getPrice());
			obj.put("newP", dto.getNewP());
			obj.put("bestP", dto.getBestP());
			array.add(obj);
		}
		out.println(array);
		
	}

}
