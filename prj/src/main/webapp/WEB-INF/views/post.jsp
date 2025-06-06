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
	    position: relative;
	}
	hr{
		border: none;
		border-top: 1px solid #edd8e8;
		width: 100%;
		margin: 10 auto;
	}
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
		padding: 10 0 0 15;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
	.content-div{
		min-height: 600px;
		width: 100%;
		padding: 10px;
		box-sizing: border-box;
	}
	.menu{
		max-height: 30px;
		padding: 0 20;
		cursor: pointer;
	}
	.menuBox{
		width: 130px;
		height: 120px;
		border: 1px solid black;
		border-radius: 10px;
		position: absolute;
		background-color: white;
		box-sizing: border-box;
		display: none;
	}
	.item{
		height: 40px;
		cursor: pointer;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.menuBody {
		position: fixed; /* 화면 전체 덮기 */
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		display: none;
		z-index: 999;
	}
	.foodImg{
		display: inline-block;
		width: 400px;
		height: 400px;
		vertical-align: top
	}
	.ingredient-box{
		display: inline-block;
		width: 200px;
		height: 400px;
		vertical-align: top;
		font-size: 20px;
	}
	.ingredient-box ul li{
		margin-bottom: 1px;
		line-height: 1.5;
	}
	.bottom-div{
		height: 60px;
		width: 100%;
		display: flex;
		justify-content: right;
		align-items: center;
		border-top: 1px solid #edd8e8;
		border-bottom: 1px solid #edd8e8;
		position: fixed;
		background-color:white;
		bottom: 0;
	}
	.heart{
		height: 40px;
		width: 40px;
		line-height: 40px;
		margin-right: 40px;
		cursor: pointer;
	}
	.jjim{
		margin-right: 20px;
		font-size: 20px;
		cursor: pointer;
		user-select: none;
		border-radius: 20px;
		border: none;
		width: 80px;
		height: 40px;
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
<script>
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
$(function(){init();});
function init(){
	$('.menu').on('click', function (e) {
		// 메뉴 위치 계산
		var offset = $(".menu").offset();
		selectHeight = $('.menu').outerHeight();
		selectWidth = $('.menu').outerWidth();
		menuBoxWidth = $('.menuBox').outerWidth();

		// menuBox를 버튼 위치 기준으로 배치
		$('.menuBox').css({
			top: offset.top + selectHeight + 20 + 'px',
			left: offset.left - menuBoxWidth + selectWidth + 'px',
			display: 'block'
		});

		// menuBody 전체 화면 표시
		$('.menuBody').css('display', 'block');
	});
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function hideMenuBox() {
	$('.menuBody').css('display', 'none');
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function goModify(r_code){
	location.href="/post/"+r_code+"/modify";
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function deletePost(r_code){
	if(!confirm( "삭제하시겠습니까?" )){
		return;
	}
	
	var formObj = $("[name='rCodeForm']");
	ajax(
		"/deletePostProc.do",
		"post",
		formObj,
		function (cnt) {
			if(cnt>0){
				location.replace("/cookingRecipe.do");
			}else if(cnt== -11){
				alert("세션이 없습니다.");
				location.replace("/login.do");
			}else{
				alert("실패");
			}
		}
	);
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function heartChange(){
	const r_code = $("[name='r_code']").val();
	fetch("/changeHeart.do?r_code="+r_code)
	  .then(response => response.json())
	  .then(data => {
			const cnt = data.cnt;
			if(cnt==1){
				$(".heart").attr('src', '/sys_img/빈하트.png');
			}else if(cnt==-11){
				alert("세션이 없습니다.");
				location.href="/login.do";
			}else{
				$(".heart").attr('src', '/sys_img/꽉찬하트.png');
			}
		})
	  .catch(error => console.error("Error:", error));
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function jjim(){
	const r_code = $("[name='r_code']").val();
	fetch("/jjim?r_code="+r_code)
	  .then(response => response.json())
	  .then(data => {
			const cnt = data.cnt;
			const thisObj = $(".jjim");
			if(cnt==1){
				thisObj.css({"background-color":"white" , "color":"#4caf50"});
			}else if(cnt==-11){
				alert("세션이 없습니다.");
				location.href="/login.do";
			}else{
				thisObj.css({"background-color":"#4caf50" , "color":"white"});
			}
		})
	  .catch(error => console.error("Error:", error));
}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
</script>
</head>
<body>
<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.href='/cookingRecipe.do'">Cooking Recipe</h1>
<div class="mainContainer">
	<div class="title-div">
		<span>
			${requestScope.postMap.TITLE}
		</span>
		<c:if test="${mid == postMap.MID}">
			<img class="menu" src="/sys_img/메뉴.png">
		</c:if>
	</div>
	<hr>
	<div class="foodImg_ingredient_container">
		<img class="foodImg" src="data:image/jpeg;base64, ${requestScope.postMap.FOODIMG}">
		<c:forEach begin="0" end="${(postIngredientMapSize-1)/12}" varStatus="s">
			<div class="ingredient-box">
				<ul>
					<c:choose>
					    <c:when test="${s.index != (postIngredientMapSize-1)/12}">
					    	<c:forEach var="data" items="${requestScope.postIngredientMap}" begin="${s.index * 12}" end="${(s.index*12) + 11}">
					        	<li>${data.INGREDIENT}</li>
					        </c:forEach>
					    </c:when>
						<c:otherwise>
					        <c:forEach var="data" items="${requestScope.postIngredientMap}" begin="${s.index * 12}" end="${requestScope.postIngredientMapSize-1}">
					        	<li>${data.INGREDIENT}</li>
					        </c:forEach>
					    </c:otherwise>
					</c:choose>
				</ul>
			</div>
		</c:forEach>
	</div>
	<hr>
	<div class="content-div">
		${requestScope.postMap.CONTENT}
	</div>
</div>
<div class="menuBody" onclick="hideMenuBox()">
	<div class="menuBox">
		<p class="item" onclick="goModify('${postMap.R_CODE}')">
			수정하기
		</p>
		<p class="item" onclick="deletePost('${postMap.R_CODE}')">
			삭제하기
		</p>
	</div>
</div>
<!-- 밑에 bottom-div 가 화면을 가리는 것을 방지 -->
<div style="height:100px;"></div>
<div class="bottom-div">
	<c:choose>
		<c:when test="${requestScope.heartCnt==0}">
			<img class="heart" src="/sys_img/빈하트.png" onclick="heartChange()">
		</c:when>
		<c:when test="${requestScope.heartCnt==1}">
			<img class="heart" src="/sys_img/꽉찬하트.png" onclick="heartChange()">
		</c:when>
	</c:choose>
	<c:choose>
		<c:when test="${requestScope.jjimCnt==0}">
			<a style="background-color:white; color:#4caf50;" class="jjim" onclick="jjim()">찜하기</a>
		</c:when>
		<c:when test="${requestScope.jjimCnt==1}">
			<a style="background-color:#4caf50; color:white;" class="jjim" onclick="jjim()">찜하기</a>
		</c:when>
	</c:choose>
</div>
<form name="rCodeForm">
	<input type="hidden" name="r_code" value="${requestScope.postMap.R_CODE}">
</form>
</body>
</html>