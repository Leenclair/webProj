<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Leenclair</title>
<link rel="stylesheet" href="<c:url value='/css/style.css'/>">
<link rel="stylesheet" href="<c:url value='/css//core.css'/>" class="template-customizer-core-css" />
<!-- Bootstrap CSS -->
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
    integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
<script src="<c:url value='/js/jquery-3.6.0.min.js'/>"></script>
<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
<!-- kakaoLogin script -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">
	//register
	window.addEventListener('load', () => {
      const forms = document.getElementsByClassName('validation-form');

      Array.prototype.filter.call(forms, (form) => {
        form.addEventListener('submit', function (event) {
          if (form.checkValidity() === false) {
            event.preventDefault();
            event.stopPropagation();
          }

          form.classList.add('was-validated');
        }, false);
      });
    }, false);
	
	//kakaoLogin
	window.Kakao.init('203c8bb5d763dccf8f0413ba656231eb');

        function kakaoLogin() {
            window.Kakao.Auth.login({
                scope: 'profile_nickname, account_email', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
                success: function(response) {
                    console.log(response) // 로그인 성공하면 받아오는 데이터
                    window.Kakao.API.request({ // 사용자 정보 가져오기 
                        url: '/v2/user/me',
                        success: (res) => {
                            const kakao_account = res.kakao_account;
                            console.log(kakao_account)
                        }
                    });
                    window.location.href='<c:url value="/"/>' //리다이렉트 되는 코드
                },
                fail: function(error) {
                    console.log(error);
                }
            });
        }
        
        window.Kakao.init('203c8bb5d763dccf8f0413ba656231eb');
    	function kakaoLogout() {
        	if (!Kakao.Auth.getAccessToken()) {
    		    console.log('Not logged in.');
    		    return;
    	    }
    	    Kakao.Auth.logout(function(response) {
        		alert(response +' logout');
    		    window.location.href='/'
    	    });
    };

    function secession() {
    	Kakao.API.request({
        	url: '/v1/user/unlink',
        	success: function(response) {
        		console.log(response);
        		//callback(); //연결끊기(탈퇴)성공시 서버에서 처리할 함수
        		window.location.href='<c:url value="/login/main"/>'
        	},
        	fail: function(error) {
        		console.log('탈퇴 미완료')
        		console.log(error);
        	},
    	});
    };
</script>
<!-- register style -->
<style>
    .validation-form {
      max-width: 680px;

      padding: 32px;

      background: #fff;
      -webkit-border-radius: 10px;
      -moz-border-radius: 10px;
      border-radius: 10px;
      -webkit-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      -moz-box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15);
      box-shadow: 0 8px 20px 0 rgba(0, 0, 0, 0.15)
    }
  </style>
</head>
<body>
	<section class="login-form">
		<h1>Hello, World!</h1>
		<form action="<c:url value='/login/login'/>" method="post">
			<div class="int-area">
				<input type="text" name="userid" id="userid" autocomplete="off" required value="${cookie.ckUserId.value }">
				<label for="id">user name</label>
			</div>
			<div class="int-area">
				<input type="password" name="pwd" id="pwd" autocomplete="pw" required>
				<label for="pw">password</label>
			</div>
			<div class="m-3">
            	<div class="form-check">
                	<input class="form-check-input" type="checkbox" id="remember-me" name="chkSaveId" 
                	 <c:if test="${!empty cookie.ckUserId }">
                	 	checked="checked"
                	 </c:if> />
                	<label class="form-check-label" for="remember-me"> Remember Me </label>
            	</div>
            </div>
			<div class="btn-area">
				<button id="btn" type="submit">LOGIN</button>
			</div>
		</form>
		<div class="caption">
			<!-- <a href="<c:url value='/login/register'/>">처음 방문이신가요? 가입하기</a> -->
			<a href="#register" data-bs-toggle="modal">처음 방문이신가요? 가입하기</a>
		</div>
		<div class="caption">
			<a href="#myModal" data-bs-toggle="modal">비밀번호를 잊어버리셨어요?</a>
		</div>
	</section>
	
	<div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">Leenclair</h5>
	        
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form>
	          <div class="mb-3">
	            <label for="recipient-name" class="col-form-label"><span>메일 주소 입력후 Send information를 누르시면 입력하신 주소로 비밀번호가 전송됩니다<br></span>E-Mail</label>
	            <input type="text" class="form-control" id="recipient-name">
	          </div>
	          <!-- <div class="mb-3">
	            <label for="message-text" class="col-form-label">Message:</label>
	            <textarea class="form-control" id="message-text"></textarea>
	          </div> -->
	        </form>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
	        <button type="button" class="btn btn-primary">Send information</button>
	      </div>
	    </div>
	  </div>
	</div>
<!-- register 모달 -->
	<div class="modal fade" id="register" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="container">
					<div class="input-form-backgroud row">
						<div class="input-form col-md-12 mx-auto">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">회원가입</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<form class="validation-form"
								action="<c:url value='/login/register'/>" method="post"
								novalidate>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="name">이름</label> <input type="text"
											class="form-control" id="name" name="name" placeholder=""
											value="" required>
										<div class="invalid-feedback">이름을 입력해주세요.</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="userid">아이디</label> <input type="text"
											class="form-control" id="userid" name="userid" placeholder=""
											value="" required>
										<div class="invalid-feedback">아이디를 입력해주세요.</div>
										<div class="invalid-feedback">이미 사용중인 아이디 입니다.</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-6 mb-3">
										<label for="pwd">비밀번호</label> <input type="password"
											class="form-control" id="pwd" name="pwd" required>
										<div class="invalid-feedback">비밀번호 입력해주세요.</div>
									</div>
									<div class="col-md-6 mb-3">
										<label for="pwd2">비밀번호 확인</label> <input type="password"
											class="form-control" id="pwd2" required>
										<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
									</div>
								</div>

								<div class="mb-3">
									<label for="email">이메일</label> <input type="email"
										class="form-control" id="email" name="email" required>
									<div class="invalid-feedback">이메일을 입력해주세요.</div>
								</div>

								<div class="row">
									<div class="col-md-8 mb-3">
										<label for="address">주소</label> <input type="text"
											class="form-control" id="address" name="address">
									</div>
									<div class="col-md-4 mb-3">
										<label for="">&nbsp;</label>
										<button class="form-control">주소검색</button>
									</div>
								</div>
								<div class="mb-3">
									<label for="address2">상세주소</label> <input type="text"
										class="form-control" id="address2" name="address2"
										placeholder="상세주소를 입력해주세요.">
								</div>

								<div class="mb-3">
									<label for="root">가입 경로</label> <select
										class="custom-select d-block w-100" id="root">
										<option value=""></option>
										<option>검색</option>
										<option>지인추천</option>
									</select>
								</div>
								<hr class="mb-4">
								<div class="custom-control custom-checkbox">
									<input type="checkbox" class="custom-control-input"
										id="aggrement" required> <label
										class="custom-control-label" for="aggrement">개인정보 수집 및
										이용에 동의합니다.</label>
									<div class="invalid-feedback">동의해주셔야 가입이 가능합니다.</div>
								</div>
								<button class="btn btn-primary btn-lg btn-block" type="submit">
									가입완료</button>
							<!-- 카카오로그인 -->
							<div id="kakaoLogin">
								<a href="javascript:kakaoLogin();">
								<img style="margin-top:11px;" alt="kakaoLoginButton"
									src="<c:url value='/assets/img/kakao/kakao_login_large_wide.png'/>">
								</a>
							</div>
							</form>
						</div>
					</div>
					<footer class="my-3 text-center text-small">
						<p class="mb-1">&copy; 2022 Leenclair</p>
					</footer>
				</div>
			</div>
		</div>
	</div>
</body>
</html>