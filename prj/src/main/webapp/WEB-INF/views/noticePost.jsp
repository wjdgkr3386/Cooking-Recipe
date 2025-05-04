<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
	h1{
		margin: 40 auto 60;
		text-align: center;
	}
	div{
		border: 1px solid black;
	}
	.title{
		width: 1000px;
		height: 60px;
		margin: 0 auto;
		padding: 15px;
		margin-bottom: 5px; 
		font-size: 15px;
		box-sizing: border-box;
	}
	.content{
		width: 1000px;
		height: 800px;
		margin: 0 auto;
		padding: 15px;
		box-sizing: border-box;
		overflow-y: auto;
		overflow-x: hidden;
	}
</style>
<script>

</script>
</head>
<body>
	<h1>공지사항</h1>
	<div class="title">
		${noticeMap.TITLE}
	</div>
	<div class="content">
		${noticeMap.CONTENT}
	</div>
</body>
</html>