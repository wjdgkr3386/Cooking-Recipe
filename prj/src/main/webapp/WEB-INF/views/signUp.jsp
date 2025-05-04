<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	.siupUp_container{
		width: 400px;
		padding: 10px;
		border: 1px solid #FFE1E6;
		border-radius: 10px;
	}
	.inputField{
		width: 100%;
		height: 60px;
		margin: 0 0 30 0;
		padding: 5px;
		border: 1px solid #FFE1E6;
	}
	.explanation{
		float: left;
	}
	.signUp{
		width: 100px;
		height: 50px;
		margin: 20 0 0 0;
		border-radius: 10px;
		border: none;
		cursor: pointer;
	}
</style>
<script>
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	function signUp(){
		var pwd = $("[name='pwd']").val();
		var pwdCheck = $(".pwd").val();
		
		//유효성 검사
	    if (!isValid()) {
	        return;
	    }
		
		if(pwd!=pwdCheck){
			alert("비밀번호가 다릅니다.");
			return;
		}
		
		//랜덤 uid 생성
		$("[name='uuid']").val(rCode(15));
		
		var formObj = $("[name='signUpForm']");
		ajax(
		     "/signUpProc.do",
		     "post",
		     formObj,
		     function (cnt) {
		    	 if(cnt == -13){
		    		 alert("이미 계정이 있습니다.");
		    	 }else if(cnt == -12){
		    		 signUp();
		    	 }else if(cnt > 0){
		    		 location.replace("/login.do");
		    	 }else if(cnt == 0){
		    		 alert("실패");
		    	 }
		     }
		);
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	//유효성 검사 메서드
	function isValid() {
	    var isValid = true;
	    var messages = [];
	
		//입력 필드 가져오기
	    var mid = $("[name='mid']").val().trim();
	    var pwd = $("[name='pwd']").val().trim();
	    var email = $("[name='email']").val().trim();

	    if (mid === "") {
	        messages.push("아이디를 입력하세요.");
	        isValid = false;
	    }else if (!/^[a-zA-Z0-9]{6,15}$/.test(mid)) { // 영어+숫자 6~10자리
	        messages.push("아이디는 영어와 숫자로 6~15자리여야 합니다.");
	        isValid = false;
	    }
	    
	    if (pwd === "") {
	        messages.push("비밀번호를 입력하세요.");
	        isValid = false;
	    }else if (!/^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$/.test(pwd)) { // 영어+숫자+특수문자 8~15자리
	        messages.push("비밀번호는 영어, 숫자, 특수문자를 포함한 8~20자리여야 합니다.");
	        isValid = false;
	    }
	    
	    if (email === "") {
	        messages.push("이메일을 입력하세요.");
	        isValid = false;
	        //첫 문자는 영어, @ 나오기 전까지는 영어+숫자 4~12자리, @ 하나, 영어+숫자 하나 이상, . 하나 , 소문자 2~4자리 
	    } else if (!/^([a-zA-Z][a-zA-Z0-9]{4,16})@([a-z0-9]+\.)[a-z]{2,4}$/.test(email)) { // 이메일 형식
	        messages.push("유효한 이메일 주소를 입력하세요.");
	        isValid = false;
	    }
	    
	    // 에러 메시지 출력
	    if (!isValid) {
	        alert(messages.join("\n"));
	    }
	
	    return isValid;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
</script>
</head>
<body>
<center>
	<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.href='/cookingRecipe.do'">Cooking Recipe</h1>
	<br>
	
	<div style="font-size:20px; font-weight:bold; color:grey;">회원가입</div>
<form name="signUpForm">
	<div class="siupUp_container">
		<input type="text" class="inputField" name="mid" placeholder="아이디">
		<input type="password" class="inputField" name="pwd" placeholder="비밀번호">
		<input type="password" class="inputField pwd" placeholder="비밀번호 재확인">
		<input type="email" class="inputField" name="email" placeholder="이메일">
		
		<input type="button" class="signUp" value="회원가입" onclick="signUp()">
		<input type="hidden" name="uuid">
	</div>
</form>
</center>
</body>
</html>