<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>post</title>
<style>
	body {
	    margin: 0;
	    padding: 0;
	    overflow-x: hidden;
	}
	hr{
		border: none;
		border-top: 1px solid #edd8e8;
		width: 100%;
		margin: 10 auto;
	}
/* 	div{
		border: 1px solid black;
	} */
	.mainContainer{
		width: 70%;
		margin: 50 auto 0;
		box-sizing: border-box;
	}
	.title-div{
		height: 100px;
		width: 100%;
		box-sizing: border-box;
		font-size: 30px;
		font-weight: 400;
		display: flex;
		align-items: center;
		padding: 10 15;
	}
	.content-div{
		min-height: 600px;
		width: 100%;
		padding: 10px;
		box-sizing: border-box;
	}
</style>
<script>

</script>
</head>
<body>
<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.href='/cookingRecipe.do'">Cooking Recipe</h1>
<div class="mainContainer">
	<div class="title-div">
		${requestScope.postMap.TITLE}
	</div>
	<hr>
	<div class="content-div">
		${requestScope.postMap.CONTENT}
	</div>
</div>
</body>
</html>