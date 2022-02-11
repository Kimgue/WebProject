<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib  prefix="spring" uri="http://www.springframework.org/tags" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="resources/js/jquery-3.4.1.min.js"></script>
</head>
<body>
<div align="center">
	<header class="head">
		<h1>이달의 기프티콘</h1>
	</header>
	<div class="container">
	<c:forEach var="gift" items="${gifticonList}">
			<img src="${gift.gifticonImg}" alt="${gift.gifticonImg}" height="270" width="270" />
			<c:out value="${gift.gifticonName}" /> 
			<c:out value="${gift.gifticonPrice}" />
			<a href="#">
				<input type="button" value="교환">
			</a>	
	</c:forEach>
	</div>
</div>
</body>
</html>