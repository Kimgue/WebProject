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

<body id="page-top">
	<!-- 페이지 Wrapper 시작 -->
	<div id="wrapper">
	<!-- 사이드바 -->
	<jsp:include page="PageSide.jsp" flush="false"/>
	<!-- 컨텐츠 Wrapper 시작 -->
	<div id="content-wrapper" class="d-flex flex-column">
	<!-- 상단 -->
	<jsp:include page="PageHeader.jsp" flush="false"/>
					
		<!-- 메인 -->
		<div id="content">
			<div class="container-fluid">
				<div class="row">
					<div class="card d-inline-block w-100 h-100 shadow mt-3 mb-3">
						<div class="card-body">
							<div class="h1 mb-3">
								공지사항 조회
							</div>
						<form name="paging">
							<c:choose>
									<c:when test="${not empty listpage}">
										<table class="table">
											<tr>
												<td class="text-center" width=60>번호</td>
												<td width=350>제목</td>
												<td class="text-center"  width=100>관리자</td>
												<td class="text-center"  width=250>작성날짜</td>
												
											</tr>
											<c:forEach var="list" items="${listpage}">
												<tr>
													<td class="text-center" ><c:out value="${list.mbrDto.noticeCode}" /></td>
													<td><a href="view2?adminCode=${ list.mbrDto.adminCode }&noticeCode=${list.mbrDto.noticeCode}"><c:out value="${list.mbrDto.noticeTitle}" /></a></td>
													<td class="text-center" ><c:out value="${list.adminDto.adminName }"></c:out>
													<td class="text-center" ><c:out value="${list.mbrDto.noticeDate}" /></td>
												</tr>
											</c:forEach>
										</table>	
										<br>
										<div class="text-center">
											<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
										    	<a class="mr-1" href="Notice?page=${idx}">${idx}</a> 
										    </c:forEach>
									    </div>
										<hr>
										<input type="hidden" name="adminCode" />
										<input type="hidden" name="noticeCode" />									
									</c:when>
									
									<c:otherwise>
										<div class="h4 text-center">등록된 공지사항이 없습니다</div>
									</c:otherwise>
							</c:choose>

						</form>	
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 메인 컨텐츠 끝 -->
			
	<!-- 하단 -->
	<jsp:include page="PageFooter.jsp" flush="false"/>
	<!-- 컨텐츠 Wrapper 끝 -->
	</div>
	<!-- 페이지 Wrapper 끝 -->
	</div>
	<!-- 페이지 상단 버튼 -->
	<jsp:include page="PageTopBtn.jsp" flush="false"/>
    <script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="resources/js/sb-admin-2.min.js"></script>	
</body>
</html>