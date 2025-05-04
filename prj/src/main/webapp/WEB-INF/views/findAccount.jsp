<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정 찾기</title>
<style>
	.Find-div{
		border: 1px solid #F5E0F5;
		text-align: center;
		width: 600px;
		height: 250px;
		margin: 0 auto;
		font-size: 25px;
	}
	.mid , .email{
		border: 1px solid #F5E0F5;
		width: 400px;
		height: 60px;
	}
	input[type="button"]{
		margin-top: 30px;
	}
</style>
<script>
function findMid(){
	var formObj = $("[name='findMidForm']");
	var email = formObj.find(".email").val().trim();
	if(email ==""){
		alert("이메일을 입력해주세요.");
		return;
	}
	ajax(
	     "/findMidProc.do",
	     "post",
	     formObj,
	     function (mid) {
	    	 if(!mid){
	    		 alert("일치하는 계정이 없습니다.");
	    	 }else{
		    	 alert(mid);
	    	 }
	     }
	);
}

function findPwd(){
	var formObj = $("[name='findPwdForm']");
	var mid = formObj.find(".mid").val().trim();
	var email = formObj.find(".email").val().trim();
	if(mid ==""){
		alert("아이디를 입력해주세요.");
		return;
	}
	if(email ==""){
		alert("이메일을 입력해주세요.");
		return;
	}
	ajax(
	     "/findPwdProc.do",
	     "post",
	     formObj,
	     function (pwd) {
	    	 if(!pwd){
	    		 alert("일치하는 계정이 없습니다.");
	    	 }else{
		    	 alert(pwd);
	    	 }
	     }
	);
}
</script>
</head>
<body>
<form name="findMidForm">
<h1 style="margin:50 0; text-align:center; cursor:pointer;" onclick="location.href='/cookingRecipe.do'">Cooking Recipe</h1>
<div class="Find-div">
	<strong>아이디 찾기</strong>
	<br><br>
	<div>
		<input type="text" class="email" name="email" placeholder="이메일">
	</div>
	<input type="button" value="아이디 찾기" onclick="findMid()">
</div>
<br><br>
</form>
<form name="findPwdForm">
<div class="Find-div">
	<strong>비밀번호 찾기</strong>
	<br><br>
	<div>
		<input type="text" class="mid" name="mid" placeholder="아이디">
	</div>
	<div>
		<input type="text" class="email" name="email" placeholder="이메일">
	</div>
	<input type="button" value="비밀번호 찾기" onclick="findPwd()">
</div>
</form>
</body>
</html>