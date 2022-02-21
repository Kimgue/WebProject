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
	
	<title>헝픽 로그인</title>
	
	<link href="resources/css/sb-admin-2.css" rel="stylesheet">
	<script src="https://kit.fontawesome.com/730c440743.js" crossorigin="anonymous"></script>
	<script src="resources/js/jquery-3.4.1.min.js"></script>
	<script src="resources/js/user/userLogin.js"></script>
</head>

<body class="bg-gradient-primary">

	<header class="d-flex align-items-center justify-content-center">
			<div class="card border-0 my-5 text-center bg-transparent">
				<a href="main" class="text-decoration-none">
                	<h1 class="font-weight-bolder text-warning">HUNGPICK</h1>
            	</a>
			</div>
    </header>
    
	<div class="container">
		
		<!-- Outer Row -->
		<div class="row justify-content-center">
			
			<div class="col-xl-10 col-lg-12 col-md-9">
				<div class="card o-hidden border-0 shadow-lg my-5">
					<div class="card-body p-0">
						<!-- Nested Row within Card Body -->
						<div class="row">
							<div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
							<div class="col-lg-6">
								<div class="p-5 text-center">
									<h1 class="h2 mb-4">로그인</h1>
									<form id="login" method="post">
		                            	<div class="inputHeight">
			                            	<input type="text" class="form-control col" id="Id" name="memberId" placeholder="아이디">
		                            	</div>
		                            	<div class="inputHeight">
			                            	<input type="password" class="form-control col" id="Pw" name="memberPw" placeholder="비밀번호">
		                            	</div>
									</form>
									<div class="form-group text-danger">
										${loginNotice}
									</div>
									<hr>
									<div>
										<input type="button" class="form-control btn btn-primary block" value="로그인" onclick="login()">
									</div>
									
									<br>
									
									<div>
			                            <div class="text-center">
			                                <a class="small" href="userFindId">아이디를 잊으셨나요?</a>
			                            </div>
			                            <div class="text-center">
			                                <a class="small" href="userFindPw">비밀번호를 잊으셨나요?</a>
			                            </div>		                            
										<div class="text-center">
											<a class="small" href="userSignUp">아직 아이디가 없으신가요?</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/js/sb-admin-2.min.js"></script>
</body>

</html>