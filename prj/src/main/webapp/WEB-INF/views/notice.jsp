<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<style>
body {
	margin: 0;
	padding: 0;
	overflow-x: hidden;
}
div{
	border: 1px solid black;
}
h1{
	margin: 30 auto 100;
	text-align: center;
}
.btn-div{
	width: 1000px;
	height: 30px;
	margin: 0 auto;
	text-align:right;
	box-sizing: border-box;
}
.table-notice{
	border: 1px solid black;
	width: 1000px;
	height: 800px;
	margin: 0 auto;
	padding: 10px;
	box-sizing: border-box;
}
</style>
<script>

</script>
</head>
<body>
<h1>공지사항</h1>
<div class="btn-div">
	<a style="cursor:pointer;" onclick="location.href='/noticeWrite.do'">게시글 작성</a>
</div>
<table class="table-notice">
	<tr>
		<td>
		<td>
	</tr>
</table>
</html>
