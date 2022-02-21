<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>헝픽</title>
    
   	<link href="resources/css/sb-admin-2.css" rel="stylesheet">
	<script src="https://kit.fontawesome.com/730c440743.js" crossorigin="anonymous"></script>
	<script src="resources/js/jquery-3.4.1.min.js"></script>
    
</head>

<body>
		<!-- 메인 -->
		<div id="content">
			<div id="menu_list">
				<c:forEach var="menu" items="${menu}">
					<c:url value="menuDetail" var="menuDetail">
						<c:param name="brandCode" value="${menu.brandCode}"/>
						<c:param name="menuCode" value="${menu.menuCode}"/>
						<c:param name="menuName" value="${menu.menuName}" />
					</c:url>
					<a href="${menuDetail}">
						<img src="<c:out value="resources/${menu.menuImg}"/>" alt="메뉴 이미지" height="270" width="270" />
					</a>
					<p style="font-size: 15pt">
						<a href="${menuDetail}">
							<c:out value="메뉴명: ${menu.menuName}" />
						</a>
					</p>		
					<p style="font-size: 15pt">
						<c:out value="메뉴가격: ${menu.menuPrice}" />
					</p>		
					<hr>
				</c:forEach>
			</div>
		</div>
		<!-- 메인 컨텐츠 끝 -->

    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="resources/js/sb-admin-2.min.js"></script>	
</body>
</html>