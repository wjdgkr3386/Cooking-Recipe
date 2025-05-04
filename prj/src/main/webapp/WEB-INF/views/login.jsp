<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
	.inputField{
		width: 240px;
		height: 90px;
		margin: 10 auto 0;
	}
	.mid , .pwd{
		width: 240px;
		height: 40px;
		padding: 5px;
		margin-top: 5px;
	}
	
	.btn{
		width: 75px;
		height: 40px;
		margin: 0 15px;
	}
	
	.findAccount-div{
		width: 240px;
		margin: 0 auto;
		text-align:right;
	}
	.findAccount:hover{
		color:blue;
		cursor: pointer;
	}
	.btn-div{
		width: 240px;
		margin: 0 auto;
	}
</style>
<script>
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
$(function(){init();});
function init(){
    //엔터를 눌렀을때 폼 제출 방지
    $("[name='loginForm'] input").on('keydown', function(event) {
        if (event.key === 'Enter') {
            //폼 제출 방지
            event.preventDefault();
            login();
        }
    });
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function login(){
	var formObj = $("[name='loginForm']");
	ajax(
	     "/loginProc.do",
	     "post",
	     formObj,
	     function (loginCnt) {
	    	 if(loginCnt==1){
	    		 location.href = "/cookingRecipe.do";
	    	 }else{
	    		 alert("로그인 실패!");
	    	 }
	     }
	);
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
</script>
</head>
<body>
	<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.href='/cookingRecipe.do'">Cooking Recipe</h1>
	<br>
	<form name="loginForm">
	<div class="inputField">
		<input type="text" class="mid" name="mid" placeholder="아이디"><br>
		<input type="password" class="pwd" name="pwd" placeholder="패스워드">
	</div>
	<div class="findAccount-div">
		<a class="findAccount" onclick="location.href='/findAccount.do'">계정 찾기</a>
	</div>
	</form>
	<div class="btn-div">
		<input type="button" class="btn" value="확인" onclick="login()">
		<input type="button" class="btn" value="회원가입" onclick="location.href = '/signUp.do';">
	</div>
</body>
</html>