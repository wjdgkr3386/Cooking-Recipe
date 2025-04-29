<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>임시</title>
<style>	
	body{
	    margin: 0;
	    padding: 0;
	    overflow-x: hidden;
	}
	.header {
		border: 1px solid #FFF5F8;
		box-shadow: 0px -5px 10px rgba(0, 0, 0, 0.3);
		width: 100%;
		height: 60px;
		margin: 0;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.headerText {
		font-size: 20px;
		font-weight: bold;
	}
	.tempRecipeDiv{
		display: flex;
		justify-content: space-between;
		align-items: center;
		border: 1px solid #FFF5F8;
		box-shadow: 0px 1px 1px rgba(0, 0, 0, 0.1);
		width: 100%;
		height: 60px;
	}
	.title{
		cursor: pointer;
		height: 60px;
		width: 100%;
		display:inline-block;
		text-align: left;
		line-height: 60px;
		padding-left: 15px;
	}
	.deleteBtn{
		height: 60px;
		cursor: pointer;
		box-sizing: border-box;
		padding: 10px;
	}
</style>
<script>
function load(r_code, title, uuid, content, foodImgBase64){
	if(!confirm("임시글을 불러오면\n작성 중인 글은 사라집니다.\n선택한 글을 불러오시겠습니까?")){
		return;
	} 

	$("[name='r_code']").val(r_code);
	$("[name='title']").val(title);
	$("[name='uuid']").val(uuid);
	$("[name='content']").val(content);
	$("[name='foodImgBase64']").val(foodImgBase64);
	
	document.tempForm.action = "/loadWrite.do";
	document.tempForm.method = "post";
	document.tempForm.submit();
	
}

function deleteRecipe(r_code){
	if(!confirm("선택한 임시글을 삭제하시겠습니까?")){
		return;
	}
	
	$("[name='r_code']").val(r_code);
	var formObj = $("[name='tempForm']");
	ajax(
		"/tempDeleteProc.do",
		"post",
		formObj,
		function (cnt) {
			if(cnt>0){
				location.reload();
			}else if(cnt== -11){
				alert("세션이 없습니다.");
				location.href="/login.do";
			}else{
				alert("실패");
			}
		}
	);
}
</script>
</head>
<body>
<div class="header">
	<span class="headerText">임시글</span>
</div>
<div class="body-div">
<c:forEach var="data" items="${requestScope.tempRecipe}" varStatus="s">
	<div class="tempRecipeDiv">
		<span class="title" onclick="load('${data.R_CODE}','${data.TITLE}','${data.UUID}','${data.CONTENT}','${data.FOODIMG}')">
		<c:choose>
		    <c:when test="${not empty data.TITLE}">
		        ${data.TITLE}
		    </c:when>
		    <c:otherwise>
		        임시글${s.index + 1}
		    </c:otherwise>
		</c:choose>
		</span>
		<img class="deleteBtn" src="/sys_img/쓰레기통.png" onclick="deleteRecipe('${data.R_CODE}')">
	</div>
</c:forEach>
</div>
<form name="tempForm">
	<input type="hidden" name="r_code">
	<input type="hidden" name="title">
	<input type="hidden" name="uuid">
	<input type="hidden" name="content">
	<input type="hidden" name="foodImgBase64">
</form>
</body>
</html>