<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/sys_img/수저.png">
<title>쿠킹레시피</title>
<style>
	div{
		border: 1px solid black;
	}
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
		width: 1600px;
		height: 100%;
		left: 0;
		overflow-y: auto;
		overflow-x: hidden;
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
		border: 1px solid black;
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
		border-spacing: 30 30; /* 가로간격 세로간격 */
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
		width:100%;
		height: 90%;
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
		font-size: 20px;
		text-align: center;
	}
	.menubar{
		width: 2000px;
		height: 50px;
		display: flex;
		gap: 200px;
		justify-content: center;
		align-items: center;
		margin: 15 auto;
	}
	.item{
		cursor: pointer;
		font-size: 20px;
	}
</style>
<script>
	function logout(){
		var formObj = $("[name='logoutForm']");
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
</script>
</head>
<body>
	<h1 style="margin-top:50px; text-align:center; cursor:pointer;" onclick="location.reload()">Cooking Recipe</h1>
	<div style="text-align:right; padding:0 30;">
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
			<span style="cursor:pointer;">
				${requestScope.mid}
			</span>
			&nbsp; | &nbsp; 
			<span style="cursor:pointer;" onclick="logout()">
				로그아웃
			</span>
		</c:if>
	</div>
	<div class="menubar">
		<span class="item" onclick="goWrite()">레시피 공유</span>
		<span class="item">찜한 레시피</span>
		<span class="item">마이페이지</span>
		<span class="item">공지사항</span>
	</div>
	<div style="width:2000px; height:800px; position: relative; margin: 0 auto;">
		<div class="recipe_container">
			<table class="recipe_table">
				<tr>
					<td class="card">
						<img class="image" src="/sys_img/x.png" alt="이미지">
						<div class="food_name">요리 이름</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="ingredient_container">
			<div class="search_button_div">
				<input type="button" class="search_button" value="검색">
			</div>
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
		</div>
	</div>
<!-- 로그아웃을 위한 form -->
<form name="logoutForm">
</form>
</body>
</html>