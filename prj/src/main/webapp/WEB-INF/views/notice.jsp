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
h1{
	margin: 40 auto 60;
	text-align: center;
}
tr:hover{
	background-color: #f1f1f1;
	cursor: pointer;
}
.btn-div{
	width: 1000px;
	height: 30px;
	margin: 0 auto;
	padding-right: 5px;
	text-align:right;
	box-sizing: border-box;
}
.tableNotice{
	border: 1px solid black;
	width: 1000px;
	min-height: 645px;
	margin: 0 auto;
	padding: 10px;
	box-sizing: border-box;
	display: block;
	font-size: 17px;
	border-radius: 10px;
	box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.1);
}
.tableNotice td {
	border: 1px solid black;
    padding: 5px;
    height: 50px;
}
.page{
    display:inline-block;
    border-radius: 10px;
    box-shadow: 0px 5px 5px rgba(0, 0, 0, 0.1);
    width:40px;
    height:40px;
    cursor:pointer;
    text-align: center;
    line-height: 40px;
    margin: 0 3px;
}
.first-td{
	width: 50px;
    text-align: center;
}
.second-td{
	width: 800px;
}
.third-td{
	width: 120px;
    text-align: center;
}
</style>
<script>
function pageNoClick(clickPageNo) {
    $("[name='selectPageNo']").val(clickPageNo);
    
	var formObj = $("[name='pageForm']");
	ajax(
		"/notice.do",
		"post",
		formObj,
		function (responseHtml) {
            var obj = $(responseHtml);
            var tempDiv = $("<div>").html(responseHtml);
            var newTable = tempDiv.find(".tableNotice");
            $(".tableNotice").replaceWith(newTable);
            var pageNos = obj.find(".pageNos");
            $(".pageNos").replaceWith(pageNos);
		}
	);
}

function goNoticePost(id){
    // 새로운 form 엘리먼트 생성
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "/notice/"+id;

    // 새로운 input 엘리먼트 생성
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "id";
    input.value = id;

    // form에 input 추가하고 바로 body에 추가하여 submit
    form.appendChild(input);
    document.body.appendChild(form).submit();
}
</script>
</head>
<body>
<h1>공지사항</h1>
<div class="btn-div">
	<if test="${requestScope.mid == xyz}">
		<a style="cursor:pointer;" onclick="location.href='/noticeWrite.do'">게시글 작성</a>
	</if>
</div>
<table class="tableNotice">
	<c:forEach var="i" items="${requestScope.searchList}">
		<tr onclick="goNoticePost('${i.ID}')">
			<td class="first-td">
				${i.ID}
			</td>
			<td class="second-td">
				${i.TITLE}
			</td>
			<td class="third-td">
				${i.CREATE_TIME}
			</td>
		</tr>
	</c:forEach>
</table>
<center>
<!-- 간격 띄우기 -->
<div style="height: 20px;"></div>
<div class="pageNos" style="user-select: none;">
    <span class="page" style="width:50px;" onClick="pageNoClick(1)">처음</span>
    <span class="page" onClick="pageNoClick(${requestScope.selectPageNo-1})">이전</span>
    <c:forEach var="pageNo" begin="${requestScope.begin_pageNo}" end="${requestScope.end_pageNo}">
        <c:choose>
            <c:when test="${requestScope.selectPageNo==pageNo}">
                <span class="page" style="font-weight:bold; color:blue;">${pageNo}</span>
            </c:when>
            <c:otherwise>
                <span class="page" onClick="pageNoClick(${pageNo})">${pageNo}</span>
            </c:otherwise>
        </c:choose>
    </c:forEach>
    <span class="page" onClick="pageNoClick(${requestScope.selectPageNo+1})">다음</span>
    <span class="page" style="width:50px;" onClick="pageNoClick(${requestScope.last_pageNo})">마지막</span>
</div>
<!-- 간격 띄우기 -->
<div style="height: 50px;"></div>
<form name="pageForm">
	<input type="hidden" name="selectPageNo" value="1">
</form>
</center>
</html>
