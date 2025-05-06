<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style>
	span{
		display: inline-flex;
	}
	.myInfo-container{
		border: 1px solid black;
		box-sizing: border-box;
		border-radius:15px;
		width: 400px;
		height: 200px;
		margin: 40 auto;
		padding: 20px;
	}
	.first{
		width:55px;
		text-align:right;
	}
	.second{
		width:290px;
	}
	
	.recipe_container{
		box-sizing: border-box;
		position: absolute;
		display: inline-block;
		width: 1640px;
		height: 100%;
		left: 0;
		overflow-y: auto;
		overflow-x: hidden;
		border: 1px solid lightpink;
		box-shadow: -1px 5px 1px rgba(0, 0, 0, 0.1);
	}
	.recipe_table{
		table-layout: fixed;
		display: grid;
		box-sizing: border-box;
		width: 100%;
		height: 100%;
		border-spacing: 40 40; /* 가로간격 세로간격 */
		padding: 0 10px;
		overflow-y: auto;
		overflow-x: hidden;
	}
	.card{
		height: 485px;
		width: 485px;
		box-sizing: border-box;
	}
	.image{
		width:485px;
		height: 485px;
		box-sizing: border-box;
		border-radius: 10px;
		box-shadow: 0px -5px 10px rgba(0, 0, 0, 0.3);
		cursor: pointer;
	}
	.image:hover, .postBtn:hover{
		border: 2px solid #3498db;
		transition: border 0.3s;
	}
	.food_name{
		height:10%;
		box-sizing: border-box;
		font-size: 25px;
		text-align: center;
		padding: 5px;
	}
	.postBtn{
		width: 820px;
		height: 70px;
		border-radius:15px;
		font-size: 25px;
		border:none;
		cursor: pointer;
	}
	.postBtn-div{
		width:1640px;
		height:70px;
		margin:30 auto 10;
		display: flex;
		justify-content: space-between;
		align-items: center;
	}
</style>
<script>
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function goPost(r_code){
    // 새로운 form 엘리먼트 생성
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "/post/"+r_code;

    // 새로운 input 엘리먼트 생성
    var input = document.createElement("input");
    input.type = "hidden";
    input.name = "r_code";
    input.value = r_code;

    // form에 input 추가하고 바로 body에 추가하여 submit
    form.appendChild(input);
    document.body.appendChild(form).submit();
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function myPostList(){
	var session = "<%= (String) session.getAttribute("mid") %>";
	if(session=="null"){
		alert("로그인이 필요한 기능입니다.");
		location.href="/login.do";
	}
	
	var formObj = $("[name='submitForm']");
	ajax(
		"/myPage.do",
		"post",
		formObj,
		function (responseHtml) {
			var obj = $(responseHtml);
			var recipe_table = obj.find(".recipe_table");
			$(".recipe_table").replaceWith(recipe_table);
		}
	);
}

//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
function jjimList(){
	var session = "<%= (String) session.getAttribute("mid") %>";
	if(session=="null"){
		alert("로그인이 필요한 기능입니다.");
		location.href="/login.do";
	}
	
	var formObj = $("[name='submitForm']");
	ajax(
		"/jjimList",
		"post",
		formObj,
		function (responseHtml) {
			var obj = $(responseHtml);
			var recipe_table = obj.find(".recipe_table");
			$(".recipe_table").replaceWith(recipe_table);
		}
	);
}
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
</script>
</head>
<body>
<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.href='/cookingRecipe.do'">Cooking Recipe</h1>
<div class="myInfo-container">
	<h2 style="text-align:center">
		내 정보
	</h1>
	
	<div>
		<span class="first">아이디:</span>
		<span class="second">wjdgkr3386</span>
	</div>
	<div>
		<span class="first">이메일:</span>
		<span class="second">wjdgkr3386@naver.com</span>
	</div>
</div>
<div class="postBtn-div">
	<input class="postBtn" type="button" value="내 포스트" onclick="myPostList()">
	<input class="postBtn" type="button" value="찜한 포스트" onclick="jjimList()">
</div>
<div style="width:1640px; height:800px; position: relative; margin: 0 auto;">
	<div class="recipe_container">
		<table class="recipe_table">
			<c:if test="${requestScope.recipeListSize > 0}">
				<c:forEach begin="0" end="${(requestScope.recipeListSize-1)/3}" varStatus="stat">
					<c:choose>
						<c:when test="${stat.index != (requestScope.recipeListSize-1)/3}">
					    	<tr>
								<c:forEach var="data" items="${requestScope.recipeList}" begin="${(stat.index*3)}" end="${(stat.index*3)+2}">
									<td class="card">
										<img class="image" src='data:image/jpeg;base64, ${data.FOODIMG}' alt="이미지" onclick="goPost('${data.R_CODE}')">
										<div class="food_name">${data.TITLE}</div>
									</td>
								</c:forEach>
							</tr>
						</c:when>
					    <c:otherwise>
							<tr>
								<c:forEach var="data" items="${requestScope.recipeList}" begin="${(stat.index*3)}" end="${requestScope.recipeListSize-1}">
									<td class="card">
										<img class="image" src='data:image/jpeg;base64, ${data.FOODIMG}' alt="이미지" onclick="goPost('${data.R_CODE}')">
										<div class="food_name">${data.TITLE}</div>
									</td>
								</c:forEach>
							</tr>
					    </c:otherwise>
					</c:choose>
				</c:forEach>
			</c:if>
		</table>
	</div>
</div>

<!-- 전송을 위한 form -->
<form name="submitForm">
	<input type="hidden" name="viewName" value="myPage.jsp">
</form>
</body>
</html>