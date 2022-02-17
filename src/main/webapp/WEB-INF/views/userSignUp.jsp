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

    <title>헝픽 회원가입</title>
    
	<link href="resources/css/sb-admin-2.min.css" rel="stylesheet">
	<link href="resources/css/user.css" rel="stylesheet">
	<script src="https://kit.fontawesome.com/730c440743.js" crossorigin="anonymous"></script>
	<script src="resources/js/jquery-3.4.1.min.js"></script>
	<script>
	var checkId 	= false;
	var checkPw 	= false;
	var checkName 	= false;
	var checkNick 	= false;
	var checkEmail 	= false;
	var checkNumber = false;
	
	var emailData;

	var validateId 		= RegExp(/^[A-Za-z0-9]{5,20}$/);
	var validatePw 		= RegExp(/^[A-Za-z0-9]{8,16}$/);
	var validateName 	= RegExp(/^[A-Za-z가-힣]{2,17}$/);
	var validateNick 	= RegExp(/^[가-힣a-zA-Z0-9]{2,10}$/);
	var validateEmail 	= RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	var validateNumber 	= RegExp(/^01[0179][0-9]{7,8}$/);

	
	function UserSignUp() {
		var val_Id 			= $("#memberId").val();
		var val_Pw 			= $("#memberPw").val();
		var val_Name 		= $("#memberName").val();
		var val_Nickname	= $("#memberNickname").val();
		var val_Email 		= $("#memberEmail").val();
		var val_Number 		= $("#memberNumber").val();

		if (val_Id == "") {
			$("#memberId").focus();
			$("#resultId").text("아이디를 입력해주세요").css("color", "red");
			return;
		}
		if (val_Pw == "") {
			$("#memberPw").focus();
			$("#resultPw").text("비밀번호를 입력해주세요").css("color", "red");
			return;
		}
		if (val_Name == "") {
			$("#memberName").focus();
			$("#resultName").text("이름을 입력해주세요").css("color", "red");
			return;
		}
		if (val_Nickname == "") {
			$("#memberNickname").focus();
			$("#resultNickname").text("닉네임을 입력해주세요").css("color", "red");
			return;
		}
		if (val_Email == "") {
			$("#memberEmail").focus();
			$("#resultEmail").text("이메일을 입력해주세요").css("color", "red");
			return;
		} else if (checkEmail == false) {
			$("#memberEmail").focus();
			$("#resultEmail").text("이메일 인증을 진행해주세요").css("color", "red");
			return;
		} 
		if (val_Number == "") {
			$("#memberNumber").focus();
			$("#resultNumber").text("전화번호를 입력해주세요").css("color", "red");
			return;
		}

		if (
		checkId == true &&
		checkPw == true &&
		checkName == true &&
		checkNick == true && 
		checkEmail == true &&
		checkNumber == true 
		) {
			$("#UserSignUp").submit();
		} else {
			return;
		}
	}

$(document).ready(function() {
	$("#EmailChk").hide();
	$("#NumberChk").hide();
	
	
	/* --------------- 이메일 검사 --------------- */
	$("#Email_Transmit").click(function() {
		var val_Email = $("#memberEmail").val();
		
		if (val_Email == "") {
			$("#resultEmail").text("이메일을 입력해주세요").css("color", "red");
			checkEmail = false;
			return false;
		} else if (validateEmail.test($('#memberEmail').val())) {
			var url = "chkEmail.do";
			$.getJSON(url,{"mail" : val_Email},function(json) {
				if (json.result == true) {
					
					var url = "sendEmail.do";
					$.getJSON(url,{"mail" : val_Email}, function(json) {
						
						$("#resultEmail").text("인증번호가 전송되었습니다").css("color","blue");
						$("#memberEmail").prop("readonly", true);
						$("#EmailChk").show();
						
						$("#Email_Check").click(function() {
							var Email_Number = $("#Email_Number").val();
							if (Email_Number == "") {
								$("#resultEmailChk").text("인증 번호를 입력해주세요").css("color","red");
							} else if (Email_Number == json.key) {
								$("#resultEmailChk").text("인증 완료되었습니다").css("color","blue");
								$("#resultEmail").text("인증 완료되었습니다").css("color","blue");
								$("#EmailChk").hide();
								$("#Email_Transmit").hide();
								checkEmail = true;
							} else {
								$("#resultEmailChk").text("잘못된 인증번호입니다").css("color","red");
								checkEmail = false;
								return false;
							}
						});
					});
				} else {
					$("#resultEmail").text("이미 존재하는 이메일입니다").css("color","red");
					checkEmail = false;
					return false;
				}
			});
		} else {
			$("#resultEmail").text("형식에 맞지 않는 이메일입니다").css("color", "red");
			checkEmail = false;
			return false;
		}
	});

	/* --------------- 아이디 검사 --------------- */
	$("#memberId").blur(function() {
		var val_Id = $("#memberId").val();
		
		if (val_Id == "") {
			$("#resultId").text("아이디를 입력해주세요").css("color", "red");
			checkId = false;
			return false;
		}

		if (validateId.test($('#memberId').val())) {
			var url = "chkId.do";
			$.getJSON(url,{"id" : val_Id},function(json) {
				var result_text = json.result;
				var result = eval(result_text);

				if (result) {
					$("#resultId").text("사용 가능한 아이디입니다").css("color","blue");
					checkId = true;
					} else {
						$("#resultId").text("이미 존재하는 아이디입니다").css("color","red");
						checkId = false;
						return false;
					}
			});
		} else {
			$("#resultId").text("사용할 수 없는 아이디입니다").css("color", "red");		
			checkId = false;
			return false;
		}
	});

	/* --------------- 비밀번호 검사 --------------- */
	$("#memberPw").blur(function() {
		var val_Pw = $("#memberPw").val();
		if (val_Pw == "") {
			$("#resultPw").text("비밀번호를 입력해주세요").css("color", "red");
			checkPw = false;
			return false;
		}
		if (validatePw.test($('#memberPw').val())) {
			$("#resultPw").text("사용 가능한 비밀번호입니다").css("color", "blue");
			checkPw = true;
		} else {
			$("#resultPw").text("사용할 수 없는 비밀번호입니다").css("color", "red");
			
			checkPw = false;
		}
	});

	/* --------------- 이름 검사 --------------- */
	$("#memberName").blur(function() {
		var val_Name = $("#memberName").val();
		if (val_Name == "") {
			$("#resultName").text("이름을 입력해주세요").css("color", "red");
			return false;
		}
		if (validateName.test($('#memberName').val())) {
			$("#resultName").text("사용 가능한 이름입니다").css("color", "blue");
			checkName = true;
		} else {
			$("#resultName").text("올바른 이름을 입력해주세요").css("color", "red");
			checkName = false;
			return false;
		}
	});

	/* --------------- 닉네임 검사 --------------- */
	$("#memberNickname").blur(function() {
		var val_Namename = $("#memberNickname").val();
		if (val_Namename == "") {
			$("#resultNickname").text("닉네임을 입력해주세요").css("color","red");
			checkNick = false;
			return false;
		}
		if (validateNick.test($('#memberNickname').val())) {
			var url = "chkNickname.do";

			$.getJSON(url, {"nickname" : val_Namename}, function(json) {
				var result_text = json.result;
				var result = eval(result_text);
				if (result) {
					$("#resultNickname").text("사용 가능한 닉네임입니다").css("color", "blue");
					checkNick = true;
				} else {
					$("#resultNickname").text("이미 존재하는 닉네임입니다").css("color", "red");
					checkNick = false;
					return false;
				}
			});
		} else {
			$("#resultNickname").text("사용할 수 없는 닉네임입니다").css("color","red");
			checkNick = false;
			return false;
		}
	});

	/* --------------- 전화번호 인증번호 전송 --------------- */
	$("#Number_Transmit").click(function() {
		var val_Number = $("#memberNumber").val();
		if (val_Number == "") {
			$("#resultNumber").text("전화번호를 입력해주세요").css("color", "red");
			checkNumber = false;
		} else if (validateNumber.test($('#memberNumber').val())) {
			var url = "chkNumber.do";
			$.getJSON(url, {"number" : val_Number}, function(json) {
				var result_text = json.result;
				var result = eval(result_text);
				if (result) {
					$("#resultNumber").text("사용 가능한 전화번호입니다").css("color", "blue");
					var code2 = ""; 
					$("#NumberChk").show();
					alert("인증번호 발송이 완료되었습니다.\n휴대폰에서 인증번호 확인을 해주십시오"); 
					var phone = $("#memberNumber").val(); 
					$.ajax({ 
					type:"GET", 
					url:"phoneCheck?phone=" + phone, 
					cache : false, 
					success:function(data) { 
						$("#memberNumber").prop("readonly", true);
						$("#Number_Number").prop("readonly", false);
						code2 = data;
						emailData = data;
					}});
				} else {
					$("#resultNumber").text("사용할 수 없는 전화번호입니다").css("color", "red");
					checkNumber = false;
				}
			});	
		} else {
			$("#resultNumber").text("사용할 수 없는 전화번호입니다").css("color", "red");
			checkNumber = false;
		}
	});
	
	/* --------------- 전화번호 인증번호 확인 --------------- */	
	$("#Number_Check").click(function() {
		var val_Number_Number = $("#Number_Number").val();
		if(emailData == val_Number_Number) {
			$("#resultNumber").text("인증 완료되었습니다").css("color","blue");
			$("#NumberChk").hide();
			$("#Number_Transmit").hide();
			checkNumber = true;
		} else {
			$("#resultNumber").text("잘못된 인증번호입니다").css("color","red");
			$("#Number_Number").attr("value", "");
		}
	});
});
</script>
	
</head>

<body class="bg-gradient-primary">
    <div class="container">
        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">회원가입을 환영합니다!</h1>
                            </div>
                            <form id="UserSignUp" action="userSignUpSubmit" method="post">
                            	<div class="testcss">
	                                <div class="form-group">
		                                <input type="text" class="form-control form-control-user" id="memberId" name="memberId" placeholder="아이디">
		                                <div id="resultId"></div>
	                                </div>
								</div>
								
								<div class="testcss">
                                <div class="form-group">
                                    <input type="password" class="form-control form-control-user" id="memberPw" name="memberPw" placeholder="비밀번호">
                                    <div id="resultPw"></div>
                                </div>
                                </div>
                                
                                <div class="testcss">
                                <div class="form-group row">
                                	<div class="col-sm-6 mb-3 mb-sm-0">
	                                	<input type="text" class="form-control form-control-user" id="memberName" name="memberName" placeholder="이름">
	                                	<div id="resultName"></div>
                                	</div>
                                	
                                	<div class="col-sm-6">
	                                	<input type="text" class="form-control form-control-user" id="memberNickname" name="memberNickname" placeholder="닉네임">
	                                	<div id="resultNickname"></div>                                	
                                	</div>
                                </div>
                                </div>
                                
                                <div class="testcss">
                                <div class="form-group row">
                                	<div class="col-sm-9">
                                    	<input type="text" class="form-control form-control-user" id="memberEmail" name="memberEmail" placeholder="이메일을 입력해주세요">
                                    	<div id="resultEmail"></div>   
                                    </div>
									<div class="col-sm-3">
										<input type="button" class="btn btn-primary" id="Email_Transmit" value="인증번호 전송">
										
                                    </div>
                                </div>
                                </div>

								<div class="testcss" id="EmailChk">
                                <div class="form-group row">
                                	<div class="col-sm-9">
                                    	<input type="text" class="form-control form-control-user" id="Email_Number" placeholder="인증번호 입력">
                                    	<div id="resultEmailChk"></div>
                                    </div>
									<div class="col-sm-3">
										<input type="button" class="btn btn-primary" id="Email_Check" value="인증번호 확인">
										
                                    </div>
                                </div>
                                </div>                                

 								<div class="testcss">
                                <div class="form-group row">
                                	<div class="col-sm-9">
                                    	<input type="text" class="form-control form-control-user" id="memberNumber" name="memberNumber" placeholder="전화번호를 입력해주세요">
                                    	<div id="resultNumber"></div> 
                                    </div>
									<div class="col-sm-3">
										<input type="button" class="btn btn-primary" id="Number_Transmit" value="인증번호 전송">
										
                                    </div>
                                </div>
                                </div>

								<div class="testcss" id="NumberChk">
                                <div class="form-group row">
                                	<div class="col-sm-9">
                                    	<input type="text" class="form-control form-control-user" id="Number_Number" placeholder="인증번호 입력">
                                    	<div id="resultNumberChk"></div>   
                                    </div>
									<div class="col-sm-3">
										<input type="button" class="btn btn-primary" id="Number_Check" value="인증번호 확인">
										
                                    </div>
                                </div>
                                </div>    
                                
                                
                                <input type="button" class="btn btn-primary btn-user btn-block" value="회원가입">
                                <hr>
                                
                            </form>
                            <div class="text-center">
                                <a class="small" href="userLogin">이미 회원가입 하셨나요? 로그인</a>
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