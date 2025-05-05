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
	input[type="checkbox"] {
	  width: 20px;
	  height: 20px;
	  accent-color: green; /* 체크 표시 색상 */
	  background-color: green; /* 배경 색상 */
	  border-radius: 4px; /* 테두리 둥글게 */
	  margin-right: 8px; /* 체크박스와 텍스트 간격 */
	  vertical-align: middle; /* 체크박스와 텍스트의 높이를 같게 */
	}
</style>
<script>

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	function goWrite(){
		var session = "<%= (String) session.getAttribute("mid") %>";
		if(session=="null"){
			alert("로그인이 필요한 기능입니다.");
			location.href="/login.do";
		}else{
			location.href="/write.do";
		}
	}

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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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
		<span class="item" onclick="goWrite()">레시피 작성</span>
		<span class="item" onclick="location.href='/myPage.do'">마이페이지</span>
		<span class="item" onclick="location.href='/notice.do'">공지사항</span>
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
				<input type="button" class="search_button" value="검색" title="아아아아" onclick="search()">
			</div>
			
<form name="searchForm">
			<div class="ingredient_checkbox">
			<label><input type="checkbox" name="ingredient" value="1">양파</label>
			<label><input type="checkbox" name="ingredient" value="2">감자</label>
			<label><input type="checkbox" name="ingredient" value="3">당근</label>
			<label><input type="checkbox" name="ingredient" value="4">마늘</label>
			<label><input type="checkbox" name="ingredient" value="5">대파</label>
			<label><input type="checkbox" name="ingredient" value="6">쪽파</label>
			<label><input type="checkbox" name="ingredient" value="7">부추</label>
			<label><input type="checkbox" name="ingredient" value="8">호박</label>
			<label><input type="checkbox" name="ingredient" value="9">애호박</label>
			<label><input type="checkbox" name="ingredient" value="10">오이</label>
			<label><input type="checkbox" name="ingredient" value="11">양배추</label>
			<label><input type="checkbox" name="ingredient" value="12">배추</label>
			<label><input type="checkbox" name="ingredient" value="13">콩나물</label>
			<label><input type="checkbox" name="ingredient" value="14">브로콜리</label>
			<label><input type="checkbox" name="ingredient" value="15">파프리카</label>
			<label><input type="checkbox" name="ingredient" value="16">방울토마토</label>
			<label><input type="checkbox" name="ingredient" value="17">고추</label>
			<label><input type="checkbox" name="ingredient" value="18">깻잎</label>
			<label><input type="checkbox" name="ingredient" value="19">무</label>
			<label><input type="checkbox" name="ingredient" value="20">버섯</label>
			
			<label><input type="checkbox" name="ingredient" value="21">돼지고기</label>
			<label><input type="checkbox" name="ingredient" value="22">소고기</label>
			<label><input type="checkbox" name="ingredient" value="23">닭고기</label>
			<label><input type="checkbox" name="ingredient" value="24">생선</label>
			<label><input type="checkbox" name="ingredient" value="25">새우</label>
			
			<label><input type="checkbox" name="ingredient" value="26">계란</label>
			<label><input type="checkbox" name="ingredient" value="27">두부</label>
			<label><input type="checkbox" name="ingredient" value="28">우유</label>
			<label><input type="checkbox" name="ingredient" value="29">치즈</label>
			<label><input type="checkbox" name="ingredient" value="30">참치</label>
			
			<label><input type="checkbox" name="ingredient" value="31">밥</label>
			<label><input type="checkbox" name="ingredient" value="32">라면</label>
			<label><input type="checkbox" name="ingredient" value="33">국수</label>
			<label><input type="checkbox" name="ingredient" value="34">식빵</label>
			<label><input type="checkbox" name="ingredient" value="35">떡</label>
			<label><input type="checkbox" name="ingredient" value="36">옥수수</label>
			
			<label><input type="checkbox" name="ingredient" value="37">간장</label>
			<label><input type="checkbox" name="ingredient" value="38">고추장</label>
			<label><input type="checkbox" name="ingredient" value="39">된장</label>
			<label><input type="checkbox" name="ingredient" value="40">설탕</label>
			<label><input type="checkbox" name="ingredient" value="41">소금</label>
			<label><input type="checkbox" name="ingredient" value="42">맛소금</label>
			<label><input type="checkbox" name="ingredient" value="43">후추</label>
			<label><input type="checkbox" name="ingredient" value="44">참기름</label>
			<label><input type="checkbox" name="ingredient" value="45">들기름</label>
			<label><input type="checkbox" name="ingredient" value="46">식초</label>
			<label><input type="checkbox" name="ingredient" value="47">고춧가루</label>
			<label><input type="checkbox" name="ingredient" value="48">카레가루</label>
			<label><input type="checkbox" name="ingredient" value="49">올리고당</label>
			<label><input type="checkbox" name="ingredient" value="50">물엿</label>
			<label><input type="checkbox" name="ingredient" value="51">꿀</label>
			<label><input type="checkbox" name="ingredient" value="52">다시다</label>
			<label><input type="checkbox" name="ingredient" value="53">맛술</label>
			<label><input type="checkbox" name="ingredient" value="54">소주</label>
			<label><input type="checkbox" name="ingredient" value="55">마요네즈</label>
			<label><input type="checkbox" name="ingredient" value="56">케찹</label>
			
			<label><input type="checkbox" name="ingredient" value="57">햄</label>
			<label><input type="checkbox" name="ingredient" value="58">소세지</label>
			<label><input type="checkbox" name="ingredient" value="59">베이컨</label>
			<label><input type="checkbox" name="ingredient" value="60">어묵</label>
			<label><input type="checkbox" name="ingredient" value="61">만두</label>
			
			<label><input type="checkbox" name="ingredient" value="62">김</label>
			<label><input type="checkbox" name="ingredient" value="63">멸치</label>
			<label><input type="checkbox" name="ingredient" value="64">다시마</label>
			<label><input type="checkbox" name="ingredient" value="65">버터</label>
			<label><input type="checkbox" name="ingredient" value="66">김치</label>
			</div>
			
<input type="hidden" name="choiceMenu" value="1">
</form>
		</div>
	</div>
<!-- 전송을 위한 form -->
<form name="submitForm">
	<input type="hidden" name="viewName" value="main.jsp">
</form>
</body>
</html>