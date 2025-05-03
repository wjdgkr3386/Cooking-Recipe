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
</style>
<script>
	
</script>
</head>
<body>
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

</body>
</html>