<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*"%>
<%@ page import="java.util.HashMap"%>
<%
	HashMap<String, String> hashMap = new HashMap<>();
	hashMap.put("Name", "iPhone");
	hashMap.put("company", "Apple");
	hashMap.put("OS", "iOS");
	hashMap.put("category", "Phone");
	JSONObject iphone = new JSONObject(hashMap);
	
	hashMap = new HashMap<>();
	hashMap.put("Name", "Galaxy Note 9");
	hashMap.put("company", "Samsung");
	hashMap.put("OS", "Android");
	hashMap.put("category", "Phone");
	JSONObject galaxyNote9 = new JSONObject(hashMap);
	
	JSONArray jsonArray = new JSONArray();
	jsonArray.add(iphone);
	jsonArray.add(galaxyNote9);
	
	System.out.println(jsonArray.toJSONString());
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		
	</script>
</body>
</html>