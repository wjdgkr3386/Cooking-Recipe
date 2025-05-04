<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>공지사항 작성</title>
<style>
	h1{
		text-align: center;
		margin: 30px;
	}
/* 	div{
		border: 1px solid black;
	} */
	.select-div{
		width: 1000px;
		height: 50px;
		margin: 0 auto 5;
		box-sizing: border-box;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.format{
		width: 150px;
		height: 100%;
	}
	.submitBtn{
		width: 100px;
		height: 100%;
		background: lightgreen;
		border-radius: 15px;
		font-size: 17px;
	}
	
	.main-container{
		width: 1000px;
		height: 800px;
		margin: 0 auto;
	}
	.title{
		width: 100%;
		height: 60px;
		padding: 15px;
		margin-bottom: 5px; 
		font-size: 15px;
	}
	.content{
		width: 100%;
		height: 725px;
		font-size: 17px;
		text-align: left;
		padding: 10px;
		resize: none;
		overflow-y: auto;
		overflow-x: hidden;
	}
</style>
<script>
function selectChange(value){
	var content;
	if (value === "general") {
content=`
[공지사항]

안녕하세요. 언제나 저희 서비스를 이용해주셔서 감사합니다.

공지 내용:
`;
	} else if (value === "event") {
content=`
[이벤트 안내]

안녕하세요! 새로운 이벤트 소식을 전해드립니다.

이벤트 기간: 
이벤트 내용:
참여 방법: 

많은 참여 부탁드립니다!
`;
	} else if (value === "update") {
content=`
[업데이트 내역]

안녕하세요. 업데이트 내용을 안내드립니다.

업데이트 일시: 
주요 변경 사항:
- 
- 

더 나은 서비스를 제공하기 위해 노력하겠습니다.
`;
	}
	
	$(".content").text(content);
}

function save(){
	var title = $("[name='title']");
	if(!checkSubject(title)){
		return;
	}
	
	var formObj = $("[name='noticeForm']");
	ajax(
		"/noticeSaveProc.do",
		"post",
		formObj,
		function (cnt) {
			if(cnt>0){
				location.replace('/notice.do');
			}else{
				alert("실패");
			}
		}
	);
}
</script>
</head>
<body>
	<h1>공지사항</h1>
	<div class="select-div">
	  <select class="format" onchange="selectChange(this.value)">
	    <option value="">-- 형식을 선택하세요 --</option>
	    <option value="general">일반 공지</option>
	    <option value="update">업데이트 안내</option>
	    <option value="event">이벤트</option>
	  </select>
	  <input type="button" class="submitBtn" value="등록" onclick="save()">
	</div>
	<form name="noticeForm">
		<div class="main-container">
			<input type="text" class="title" name="title" placeholder="제목">
			<textarea class="content" name="content"></textarea>
		</div>
	</form>
</body>
</html>
