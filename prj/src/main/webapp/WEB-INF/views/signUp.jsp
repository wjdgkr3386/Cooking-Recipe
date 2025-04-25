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
	$(function(){init();});
	function init(){
		$("[name='mid']").val("wjdgkr3386");
		$("[name='pwd']").val("kjh3765!");
		$(".pwd").val("kjh3765!");
		$("[name='email']").val("wjdgkr3386@naver.com");
	}
	function signUp(){
		var pwd = $("[name='pwd']").val();
		var pwdCheck = $(".pwd").val();
		if(pwd!=pwdCheck){
			alert("비밀번호가 다릅니다.");
			return;
		}
		
		var formObj = $("[name='signUpForm']");
		ajax(
		     "/signUpProc.do",
		     "post",
		     formObj,
		     function (cnt) {
		    	 if(cnt == -13){
		    		 alert("이미 계정이 있습니다.");
		    	 }else if(cnt > 0){
		    		 location.replace("/login.do");
		    	 }else if(cnt == 0){
		    		 alert("실패");
		    	 }
		     }
		);
	}
	
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
	</div>
</form>
</center>
</body>
</html>