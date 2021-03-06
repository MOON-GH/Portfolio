<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
$(document).ready(function(){
	$("#loading-div-background").css({ opacity: 1 });
	
	$("#inputId").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	$("#inputPassword").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	$("#inputPassword2").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	$("#inputName").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	$("#inputName").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	$("#inputNickName").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	$("#inputEmail").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	$("#inputBrith").keyup(function(e) {
		if(e.keyCode == 13) {
			join();
		}
	});
	
	$('#btnSignUp').click(function(e){
		join();
	});
});

function join(){
	// 회원가입시 빈값 및 중복 아이디 검사
	var memberId = $("#inputId");
	var memberPw = $("#inputPassword");
	var memberPw2 = $("#inputPassword2");
	var memberName = $("#inputName");
	var memberNick = $("#inputNickName");
	var email = $("#inputEmail");
	var birthDate = $("#inputBrith");
	
	var regExp = /^([_0-9a-zA-Z]){6,12}$/i;
	if(memberId.val() == null || memberId.val() == ""){
		alert("아이디를 입력하세요.");
		return memberId.focus();
	}
	if(memberId.val().match(regExp) == null){
		alert("아이디는 6~12글자로 입력해주세요. \n(특수문자는  _ 가능) ");
		return memberId.focus();
	}
	if(memberName.val() == null || memberName.val() == ""){
		alert("이름을 입력하세요.");
		return memberName.focus();
	}
	if(memberNick.val() == null || memberNick.val() == ""){
		alert("닉네임을 입력하세요.");
		return memberNick.focus();
	}
	if(memberPw.val() == null || memberPw.val() == ""){
		alert("비밀번호를 입력하세요.");
		return memberPw.focus();
	}
	if(memberPw.val() != memberPw2.val()){
		alert("비밀번호가 일치하지 않습니다.");
		return memberPw2.focus();
	}
	if(email.val() == null || email.val() == "") {
		alert("이메일을 입력하세요.");
		return email.focus();
	}
	
	regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-z-A-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{3,4}$/i;
	if(email.val().match(regExp) == null) {
		alert("이메일 형식이 올바르지 않습니다. \n올바른 형식으로 작성해주세요. \nex) sample@gmail.com");
		return email.focus();
	}
	
	if(birthDate.val() == null || birthDate.val() == ""){
		alert("생일을 입력하세요.");
		return birthDate.focus();
	}
	
	regExp = /^(19|20)\d{2}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[0-1])$/;
	if(birthDate.val().match(regExp) == null) {
		alert("생일 입력 형식이 올바르지 않습니다. \n올바른 형식으로 작성해주세요. \nex) yyyy-mm-dd");
		return birthDate.focus();
	}
	
	// overlay 보이기
	$("#loading-div-background").css({'z-index' : '9999'}).show();
	
	$.ajax({
		url: "<c:url value='/member/checkId.do'/>",
		data : {memberId : $('#inputId').val() },
		success : function (data, textStatus, XMLHttpRequest) {
			console.log(data);
			if(data.cnt == 1){
				alert(data.msg);
				// overlay 숨기기
				$("#loading-div-background").hide();
				return;
			}
			else {
				var formData = new FormData(document.regForm);
//					var formData = $("#registerForm").serialize();
//				console.log(formData);
				$.ajax({
					url: '<c:url value="/member/join.do" />',
					type: "POST",
					data: formData,
					dataType:'TEXT',
					cache: false,
					processData: false,
					contentType: false,
					success: function(data, textStatus, jqXHR) {
						data = $.parseJSON(data);
//							console.log(data);
						alert(data.msg);
						
						$("#loading-div-background").hide();	// overlay 숨기기
						
						movePage(null, data.nextPage, {pageName:'login'});
					},
					error: function(jqXHR, textStatus, errorThrown) {
						$("#loading-div-background").hide();	// overlay 숨기기
						
//						console.log(jqXHR);
//						console.log(textStatus);
//						console.log(errorThrown);
					}
				});
			}
		},
		error : function (XMLHttpRequest, textStatus, errorThrown) {
			$(tabId, myLayout.panes.center).html(XMLHttpRequest.responseText);
		}
	});
}
</script>
</head>
<body>
	<!-- START - Contain Wrapp -->
	<div class="contain-wrapp">
	    <div class="container">
	        <div class="form-block center-block">
	            <h2 class="title">회원 가입</h2>
	            <hr />
	            <form id="registerForm" name="regForm" class="form-horizontal">
	                <div class="form-group has-feedback">
	                    <label for="inputName" class="col-sm-3 control-label">아이디 <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="text" class="form-control" id="inputId" name="memberId" placeholder="User ID" required>
	                        <i class="fa fa-pencil form-control-feedback"></i>
	                    </div>
	                </div>
	                <div class="form-group has-feedback">
	                    <label for="inputName" class="col-sm-3 control-label">이름 <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="text" class="form-control" id="inputName" name="memberName" placeholder="User Name" required>
	                        <i class="fa fa-pencil form-control-feedback"></i>
	                    </div>
	                </div>
	                <%--
	                <div class="form-group has-feedback">
	                    <label for="inputLastName" class="col-sm-3 control-label">Last Name <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="text" class="form-control" id="inputLastName" placeholder="Last Name" required>
	                        <i class="fa fa-pencil form-control-feedback"></i>
	                    </div>
	                </div>
	                 --%>
	                <div class="form-group has-feedback">
	                    <label for="inputUserName" class="col-sm-3 control-label">닉네임 <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="text" class="form-control" id="inputNickName" name="memberNick" placeholder="Nick Name" required>
	                        <i class="fa fa-user form-control-feedback"></i>
	                    </div>
	                </div>
	                <div class="form-group has-feedback">
	                    <label for="inputPassword" class="col-sm-3 control-label">비밀번호 <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="password" name="memberPw" class="form-control" id="inputPassword" placeholder="Password" required>
	                        <i class="fa fa-lock form-control-feedback"></i>
	                    </div>
	                </div>
	                <div class="form-group has-feedback">
	                    <label for="inputPassword2" class="col-sm-3 control-label">비밀번호 확인 <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="password" name="memberPw2" class="form-control" id="inputPassword2" placeholder="Password Confirm" required>
	                        <i class="fa fa-lock form-control-feedback"></i>
	                    </div>
	                </div>
	                <div class="form-group has-feedback">
	                    <label for="inputEmail" class="col-sm-3 control-label">이메일 <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="email" class="form-control" id="inputEmail" name="email" placeholder="E-mail" required>
	                        <i class="fa fa-envelope form-control-feedback"></i>
	                    </div>
	                </div>
	                <div class="form-group has-feedback">
	                    <label for="inputBirth" class="col-sm-3 control-label">생년월일 <span class="text-danger small">*</span></label>
	                    <div class="col-sm-8">
	                        <input type="text" class="form-control" id="inputBrith" name="birthDate" placeholder="ex) yyyy-mm-dd" required>
	                        <i class="fa fa-pencil form-control-feedback"></i>
	                    </div>
	                </div>
	                <%-- 
	                <div class="form-group">
	                    <div class="col-sm-offset-3 col-sm-8">
	                        <div class="checkbox">
	                            <label class="custom-checkbox">I have read <a href="#">privacy policy</a> and <a href="#">customer agreement</a>
	                                <input type="checkbox" name="terms" required/>
	                                <div class="checkmark"></div>
	                            </label>
	                        </div>
	                    </div>
	                </div>
	                --%>
	                <div class="form-group">
	                    <div class="col-sm-offset-3 col-sm-8">
	                        <button type="button" id="btnSignUp" class="btn-e btn-block btn-e-primary">작성 완료</button>
	                    </div>
	                </div>
	            </form>
	        </div>
	        <p class="text-center space-top">계정이 이미 있습니까? <a href="javascript:movePage(this, '/member/goLoginPage.do', {pageName:'login'})">로그인</a></p>
	    </div>
	</div>
	<!-- END - Contain Wrapp -->
	
	<!-- overlay html start -->
	<div id="loading-div-background">
	      <div id="loading-div" class="ui-corner-all">
	           <img style="height:32px;width:32px;margin:30px;" src="<c:url value='/resources/img/please_wait.gif'/>" alt="Loading.."/>
	           <br>
	           	처리중. 잠시만 기다려주세요...
	      </div>
	</div>
	<!-- overlay html end -->
</body>
</html>