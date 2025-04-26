<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<style>
	.mid , .pwd{
		width: 240px;
		height: 40px;
		padding: 5px;
		margin: 10 0 0 0px;
	}
	
	.btn{
		width: 75px;
		height: 40px;
		margin: 0 15px;
	}
	
</style>
<script>
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
</script>
</head>
<body>
<center>
	<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.href='/cookingRecipe.do'">Cooking Recipe</h1>
	<br>
	<form name="loginForm">
		<input type="text" class="mid" name="mid" placeholder="아이디"><br>
		<input type="password" class="pwd" name="pwd" placeholder="패스워드"><br><br>
	</form>
	
	<input type="button" class="btn" value="확인" onclick="login()">
	<input type="button" class="btn" value="회원가입" onclick="location.href = '/signUp.do';">
	
</center>
</body>
</html>