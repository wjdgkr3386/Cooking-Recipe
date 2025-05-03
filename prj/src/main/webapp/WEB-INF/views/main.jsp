<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/sys_img/수저.png">
<title>쿠킹레시피</title>
<style>
	label{
		display: block;
		font-size: 19px;
		padding: 0 20px;
		margin: 4px;
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
	.ingredient_container{
		box-sizing: border-box;
		position: absolute;
		display: inline-block;
		width: 350px;
		height: 100%;
		right: 0;
	}
	.search_button_div{
		position: sticky;
		top: 0px;
		width:100%;
		height: 60px;
	}
	.ingredient_checkbox{
		overflow-y: auto;
		overflow-x: hidden;
		box-sizing: border-box;
		height: 740px;
		border: 1px solid lightpink;
		box-shadow: 0px 5px 1px rgba(0, 0, 0, 0.1);
	}
	.search_button{
		width:100%;
		height:100%;
		background-color: #1F70C1;
		color:white;
		font-size:40px;
		border-radius: 10px;
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
	.image:hover{
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
	.menubar{
		width: 2000px;
		height: 50px;
		display: flex;
		gap: 200px;
		justify-content: center;
		align-items: center;
		margin: 15 auto;
		border: 1px solid lightpink;
		box-shadow: -1px 5px 1px rgba(0, 0, 0, 0.1);
		user-select: none;
	}
	.item{
		cursor: pointer;
		font-size: 20px;
	}
</style>
<script>

	function logout(){
		var formObj = $("[name='submitForm']");
		ajax(
		     "/logout.do",
		     "post",
		     formObj,
		     function (cnt) {
		    	 location.reload();
		     }
		);
	}
	
	function goWrite(){
		var session = "<%= (String) session.getAttribute("mid") %>";
		if(session=="null"){
			alert("로그인이 필요한 기능입니다.");
			location.href="/login.do";
		}else{
			location.href="/write.do";
		}
	}
	
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
    
    function jjimList(){
		var session = "<%= (String) session.getAttribute("mid") %>";
		if(session=="null"){
			alert("로그인이 필요한 기능입니다.");
			location.href="/login.do";
		}
    	if($("[name='choiceMenu']").val()==="2") { return; }
		
		var formObj = $("[name='submitForm']");
		ajax(
			"/jjimList",
			"post",
			formObj,
			function (responseHtml) {
				var obj = $(responseHtml);
				var recipe_table = obj.find(".recipe_table");
				$(".recipe_table").replaceWith(recipe_table);
				$("[name='choiceMenu']").val("2");
				$(".recipeListBtn").css({"text-decoration":"none"});
				$(".jjimListBtn").css({"text-decoration":"underline"});
			}
		);
    }
    
    function recipeList(){
    	if($("[name='choiceMenu']").val()==="1") { return; }
		
		var formObj = $("[name='submitForm']");
		ajax(
			"/cookingRecipe.do",
			"post",
			formObj,
			function (responseHtml) {
				var obj = $(responseHtml);
				var recipe_table = obj.find(".recipe_table");
				$(".recipe_table").replaceWith(recipe_table);
				$("[name='choiceMenu']").val("1");
				$(".recipeListBtn").css({"text-decoration":"underline"});
				$(".jjimListBtn").css({"text-decoration":"none"});
			}
		);
    }
    
    function search(){
		var formObj = $("[name='searchForm']");
		ajax(
			"/search.do",
			"post",
			formObj,
			function (responseHtml) {
				var obj = $(responseHtml);
				var recipe_table = obj.find(".recipe_table");
				$(".recipe_table").replaceWith(recipe_table);
				$("[name='choiceMenu']").val("1");
				$(".recipeListBtn").css({"text-decoration":"underline"});
				$(".jjimListBtn").css({"text-decoration":"none"});
			}
		);
    }
    
    
</script>
</head>
<body>
	<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.reload()">Cooking Recipe</h1>
	<div style="text-align:right; width:2000px; margin:0 auto;">
		<c:if test="${empty requestScope.mid}">
			<span style="cursor:pointer;" onclick="location.href='/login.do'">
				로그인
			</span>
			&nbsp; | &nbsp; 
			<span style="cursor:pointer;" onclick="location.href='/signUp.do'">
				회원가입
			</span>
		</c:if>
		<c:if test="${not empty requestScope.mid}">
			<span style="cursor:pointer; user-select:none;" onclick="logout()">
				로그아웃
			</span>
		</c:if>
	</div>
	<div class="menubar">
		<span class="item recipeListBtn" style="text-decoration: underline;" onclick="recipeList()">레시피 목록</span>
		<span class="item jjimListBtn" onclick="jjimList()">찜 목록</span>
		<span class="item"onclick="goWrite()">레시피 작성</span>
		<span class="item" onclick="location.href='/myPage.do'">마이페이지</span>
		<span class="item">공지사항</span>
	</div>
	<div style="width:2000px; height:800px; position: relative; margin: 0 auto;">
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
		<div class="ingredient_container">
			<div class="search_button_div">
				<input type="button" class="search_button" value="검색" onclick="search()">
			</div>
			
<form name="searchForm">
			<div class="ingredient_checkbox">
				<label><input type="checkbox" name="ingredient" value="1">계란</label>
				<label><input type="checkbox" name="ingredient" value="2">김치</label>
				<label><input type="checkbox" name="ingredient" value="3">양파</label>
				<label><input type="checkbox" name="ingredient" value="4">감자</label>
				<label><input type="checkbox" name="ingredient" value="5">당근</label>
				<label><input type="checkbox" name="ingredient" value="6">마늘</label>
				<label><input type="checkbox" name="ingredient" value="7">대파</label>
				<label><input type="checkbox" name="ingredient" value="8">두부</label>
				<label><input type="checkbox" name="ingredient" value="9">우유</label>
				<label><input type="checkbox" name="ingredient" value="10">밥</label>
				<label><input type="checkbox" name="ingredient" value="11">라면</label>
				<label><input type="checkbox" name="ingredient" value="12">국수</label>
				<label><input type="checkbox" name="ingredient" value="13">식빵</label>
				<label><input type="checkbox" name="ingredient" value="14">떡</label>
				<label><input type="checkbox" name="ingredient" value="15">햄</label>
				<label><input type="checkbox" name="ingredient" value="16">참치</label>
				<label><input type="checkbox" name="ingredient" value="17">소세지</label>
				<label><input type="checkbox" name="ingredient" value="18">만두</label>
				<label><input type="checkbox" name="ingredient" value="19">버터</label>
				<label><input type="checkbox" name="ingredient" value="20">치즈</label>
				<label><input type="checkbox" name="ingredient" value="21">김</label>
				<label><input type="checkbox" name="ingredient" value="22">멸치</label>
				<label><input type="checkbox" name="ingredient" value="23">다시마</label>
				<label><input type="checkbox" name="ingredient" value="24">고추장</label>
				<label><input type="checkbox" name="ingredient" value="25">된장</label>
				<label><input type="checkbox" name="ingredient" value="26">간장</label>
				<label><input type="checkbox" name="ingredient" value="27">설탕</label>
				<label><input type="checkbox" name="ingredient" value="28">소금</label>
				<label><input type="checkbox" name="ingredient" value="29">후추</label>
				<label><input type="checkbox" name="ingredient" value="30">참기름</label>
				<label><input type="checkbox" name="ingredient" value="31">들기름</label>
				<label><input type="checkbox" name="ingredient" value="32">식초</label>
				<label><input type="checkbox" name="ingredient" value="33">케찹</label>
				<label><input type="checkbox" name="ingredient" value="34">마요네즈</label>
				<label><input type="checkbox" name="ingredient" value="35">카레가루</label>
				<label><input type="checkbox" name="ingredient" value="36">콩나물</label>
				<label><input type="checkbox" name="ingredient" value="37">부추</label>
				<label><input type="checkbox" name="ingredient" value="38">호박</label>
				<label><input type="checkbox" name="ingredient" value="39">애호박</label>
				<label><input type="checkbox" name="ingredient" value="40">오이</label>
				<label><input type="checkbox" name="ingredient" value="41">양배추</label>
				<label><input type="checkbox" name="ingredient" value="42">배추</label>
				<label><input type="checkbox" name="ingredient" value="43">고추</label>
				<label><input type="checkbox" name="ingredient" value="44">고춧가루</label>
				<label><input type="checkbox" name="ingredient" value="45">돼지고기</label>
				<label><input type="checkbox" name="ingredient" value="46">소고기</label>
				<label><input type="checkbox" name="ingredient" value="47">닭고기</label>
				<label><input type="checkbox" name="ingredient" value="48">생선</label>
			</div>
			
<input type="hidden" name="choiceMenu" value="1">
</form>
		</div>
	</div>
<!-- 전송을 위한 form -->
<form name="submitForm">
</form>
</body>
</html>