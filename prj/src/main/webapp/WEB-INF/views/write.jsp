<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<link href="//fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet" type="text/css">
<link href="https://cdn.jsdelivr.net/gh/moonspam/NanumSquare@2.0/nanumsquare.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<title>기본 서식 툴</title>
<style>
	body{
	    margin: 0;
	    padding: 0;
	    overflow-x: hidden;
	    font-family: sans-serif;
	}
	
	label{
		display: block;
		font-size: 25px;
		margin: 4px;
		padding: 0 20px;
		user-select: none;
	}
	
	input[type="checkbox"] {
		width: 20px;
		height: 20px;
		margin: 0 15 0 0;
	}
		
	.savebar{
		display: flex;
		justify-content: space-between;
		align-items: center;
		height: 60px;
	}
	
	.save{
        font-size: 20px;
        background: none;
        border: none;
        cursor: pointer;
        padding: 5px 10px;
        margin: 0 20 0 0;
	}
	
	.save_btn{
		border-radius: 10px;
		background-color: #DFFFE0;
		color: green;
		font-weight: 500;
	}
	.title{
		height: 60px;
		width: 99%;
		border-radius: 10px;
		margin: 0 10;
		padding: 10 15;
		box-sizing: border-box;
		background-color: #FFF5F8;
		border: none;
		font-size: 20px;
	}
    .toolbar {
        margin: 20px 10px;
        display: flex;
        align-items: center;
        gap: 15px;
    }

    .tool {
        height: 30px;
        font-size: 18px;
        background: none;
        border: none;
        cursor: pointer;
    }

    .editor {
        box-sizing: border-box;
        width: 100%;
        min-height: 400px;
        border: 1px solid grey;
        padding: 10px;
        font-size: 16px;
        outline: none;
    }

    .alignment {
        width: 20px;
        height: 20px;
        cursor: pointer;
    }

    select {
        border: none;
        font-size: 18px;
        padding: 0 5px;
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
    }
    
    .image{
    	border-radius:5px;
    	height:25px;
    	margin: 0 15px;
    }
	
    .upload-box_ingredient-checkbox_container{
    	width: 100%;
    	display: flex;
		justify-content: center;
		align-items: center;
    	margin: 30 0px;
    	gap: 60px;
    }
    
    .upload-box{
    	border: 1px solid black;
    	border-radius: 10px;
    	width: 400px;
    	height: 400px;
    	cursor: pointer;
    	display: inline-flex;
		justify-content: center;
		align-items: center;
    }
    
    .ingredient-checkbox{
    	border: 1px solid black;
    	border-radius: 10px;
    	width: 400px;
    	height: 400px;
    	display: inline-block;
		overflow-y: auto;
		overflow-x: hidden;
		box-sizing: border-box;
    }
    
    
    .toolbarHeader{
    	height: 60px;
    	width: 100%;
    	border-bottom: 1px solid grey;
        margin: 0;
        display: none;
        align-items: center;
        gap: 15px;
        position: fixed; /* 화면에 고정 */
	    top: 0; /* 화면 최상단 위치 */
	    left: 0;
	    box-shadow: 0px -5px 10px rgba(0, 0, 0, 0.3);
	    background-color: white;
    }
    
    .bottomSavebar{
    	height: 60px;
    	width: 100%;
    	display: flex;
		justify-content: center;
		align-items: center;
		gap: 10px;
    }
    
    .bottomCancel{
    	height: 60px;
    	width: 48%;
    	display: flex;
		justify-content: center;
		align-items: center;
    	background-color: #FFF5F8;
    	color: black;
    	font-weight: 500;
    	border-radius: 10px;
    	cursor: pointer;
    }
    .bottomSave{
    	height: 60px;
    	width: 48%;
    	display: flex;
		justify-content: center;
		align-items: center;
    	background-color: #EBFAF0;
    	color: green;
    	font-weight: 500;
    	border-radius: 10px;
    	cursor: pointer;
    }
</style>
<script>
	let savedRange;
	let editor;
	$(function(){init();});
	function init(){
		//커서 저장
    	editor = document.querySelector('.editor');
    	editor.focus();
		const range = document.createRange();
		range.selectNodeContents(editor);
		range.collapse(true);
		savedRange = range.cloneRange();
		
	    // 실시간으로 커서 위치 추적
	    editor.addEventListener('focus', updateSavedRange);
	    editor.addEventListener('keyup', updateSavedRange);
	    editor.addEventListener('click', updateSavedRange);

        $(".editor").on('input', function () {
            if (this.innerHTML.trim() === "<br>" || this.innerHTML.trim() === "<div><br></div>") {
                this.innerHTML = '';
            }
        });
        
        $('#fileInput').change(function(event) {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    // e.target.result는 읽어들인 파일 데이터를 포함합니다. 일종의 경로이다.
                    const url = e.target.result;
                    
                	const selection = window.getSelection();
                	
                	if (selection.rangeCount > 0) {
                		const range = selection.getRangeAt(0);
                        const startContainer = range.startContainer;  // 커서가 있는 위치의 노드
                        if (editor.contains(startContainer)) {
                        	savedRange = range;
                        }
                        
                	    const img = document.createElement('img');
                	    img.src = url;
                	    img.style.maxWidth = '100%';
                	    img.style.display = 'block';
                	    
                	    //이미지 넣기
                	    savedRange.insertNode(img);
                	    
                	    //이미지를 넣고 커서를 이미지 뒤로 이동
                        savedRange.setStartAfter(img);
                        savedRange.setEndAfter(img);
                        selection.removeAllRanges();
                        selection.addRange(savedRange);
                        
                        $('#fileInput').val('');
            		}
                };
                reader.readAsDataURL(file); // 파일을 Data URL 형식으로 읽습니다.
            }
        });
        
        $("[name='contentForm'] input[name='title']").on('keydown', function(event) {
            if (event.key === 'Enter') {
                event.preventDefault();
            }
        });
        
        $('#foodImg').change(function(event) {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    // e.target.result는 읽어들인 파일 데이터를 포함합니다. 일종의 경로이다.
                    $('.upload-box').html('<img src="' + e.target.result + '" alt="Profile Picture" style="width:100%; height:100%; object-fit:fill; border-radius:10px;">');
                };
                reader.readAsDataURL(file); // 파일을 Data URL 형식으로 읽습니다.
            }else{
            	$('.upload-box').html('완성된 음식 사진을 올려주세요.');
            }
        });
        
		window.addEventListener("scroll", function () {
		    let header = $(".toolbarHeader"); // 헤더 요소
		    let scrollY = window.scrollY;

		    if (scrollY > 200) { 
		        header.css({"display":"flex"});
		    } else {
		    	header.css({"display":"none"});
		    }
		});
		
		window.addEventListener('pageshow', function(event) {
			const title = window.sessionStorage.getItem("title");
			const r_code = window.sessionStorage.getItem("r_code");
			const content = window.sessionStorage.getItem("content");
		    if (title) {
		        $("[name='title']").val(title);
		    }
		    if (r_code) {
		        $("[name='r_code']").val(r_code);
		    }
		    if (content) {
		        $(".editor").html(content);
		    }
		    window.sessionStorage.removeItem("title");
		    window.sessionStorage.removeItem("r_code");
		    window.sessionStorage.removeItem("content");
		});
		
		window.addEventListener("load", function () {
		    const [navigation] = performance.getEntriesByType("navigation");
		    if (navigation && navigation.type === "reload") {
		        $(".title").val('');
		        $(".editor").html('');
		    }
		});
    }//init 종료ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

	//커서 마지막 위치 추적
    function updateSavedRange() {
        const selection = window.getSelection();
        if (selection.rangeCount > 0) {
            savedRange = selection.getRangeAt(0).cloneRange();
        }
    }
    
	function inputHr(){
		const selection = window.getSelection();
		if (selection.rangeCount > 0) {
			const range = selection.getRangeAt(0);
            const startContainer = range.startContainer;  // 커서가 있는 위치의 노드
            if (editor.contains(startContainer)) {
            	savedRange = range;
            }
            
            const hr = document.createElement('hr');
            hr.style.display = 'block';
            hr.style.border = 'none';
            hr.style.borderTop = '2px solid #F2C9D4';
            
            savedRange.insertNode(hr);
            savedRange.setStartAfter(hr);
            savedRange.setEndAfter(hr);
            selection.removeAllRanges();
            selection.addRange(savedRange);
		}
	}
	
    function execCommand(command, value = '') {
        const selection = window.getSelection();
        if (selection.rangeCount > 0) {
            document.execCommand(command, false, value);
        }
    }

    function fontStyle(font) {
        execCommand('fontName', font);
    }

    function setFontSize(size) {
        execCommand('fontSize', size);
    }

    function setFontColor(color) {
        execCommand('foreColor', color);
    }

    function setBackgroundColor(color) {
        execCommand('backColor', color);
    }

    function alignText(alignType) {
        execCommand(alignType);
    }
    
    function uploadPost(){
    	const content = $(".editor").html();
    	const title = $("[name='title']").val().trim();
    	const foodImg = $("input[name='foodImg']");
    	const ingredient = $("[name='ingredient']");
    	
    	if(title===""){
    		alert("제목을 입력해주세요.");
    		$("[name='title']")[0].scrollIntoView({ behavior: 'smooth' });
    		return;
    	}else if(title.length>25){
    		alert("제목은 25글자 이하로 써주세요.");
    		$("[name='title']")[0].scrollIntoView({ behavior: 'smooth' });
    		return;
    	}
    	if(content.trim()===""){
    		alert("내용을 입력해주세요.");
    		$(".editor")[0].scrollIntoView({ behavior: 'smooth' });
    		return;
    	}
    	if(foodImg.val() === ""){
    		alert("완성된 음식 사진을 올려주세요.");
    		$('.upload-box')[0].scrollIntoView({ behavior: 'smooth' });
    		return;
    	}
    	if( ingredient.filter(":checked").length === 0 ){
    		alert("레시피에 필요한 재료를 선택해주세요.");
    		ingredient[0].scrollIntoView({ behavior: 'smooth' });
    		return;
    	}
    	
        const editorContent = $('.editor').html();
        const editorSize = new Blob([editorContent]).size;
        if (editorSize > 1024 *100) {
            alert("게시글 본문 용량은 100KB까지 첨부할 수 있습니다.");
            return;
        }
        
    	$("[name='content']").val(content);
    	$("[name='r_code']").val(rCode(17));
    	
    	var formObj = $("[name='contentForm']");
		ajax(
			"/writeInsertProc.do",
			"post",
			formObj,
			function (cnt) {
				if(cnt>0){
					location.replace("/cookingRecipe.do");
				}else if(cnt== -11){
					alert("세션이 없습니다.");
					location.replace("/login.do");
				}else if(cnt== -18){
					alert("완성된 요리의 사진이 지정된 확장자가 아닙니다. jpg, jpeg, jfif, png");
					$("#foodImg").val('');
				}else if(cnt== -20){
					alert("완성된 요리의 사진에 문제가 있습니다.");
				}else if(cnt==0){
					alert("실패");
				}
			}
		);
    }
    
    
    function TemporarySave(){
    	const content = $(".editor").html();
    	const title = $("[name='title']").val().trim();
		const r_code = $("[name='r_code']");
		
    	$("[name='content']").val(content);
    	if(r_code.val()===''){
    		$("[name='r_code']").val(rCode(17));
    	}

    	var formObj = $("[name='contentForm']");
    	ajax(
   			"/writeTemporarySaveProc.do",
   			"post",
   			formObj,
   			function (cnt) {
   				if(cnt>0){
   					alert("성공");
   				}else if(cnt== -18){
   					alert("완성된 요리의 사진이 지정된 확장자가 아닙니다. jpg, jpeg, jfif, png");
   				}else{
   					alert("실패");
   				}
   			}
    	);
    }
    
    function goSaved(){
    	const content = $(".editor").html();
    	const title = $("[name='title']").val();
    	const r_code = $("[name='r_code']").val();
    	window.sessionStorage.setItem("content", content);
    	window.sessionStorage.setItem("title", title);
    	window.sessionStorage.setItem("r_code", r_code);
    	location.href="/write/saved.do";
    }
    
    function cancel(){
    	if(confirm( "글쓰기를 취소하시겠습니까?" )){
			location.href='/cookingRecipe.do';
    	}
    }
</script>
</head>
<body>
<form name="contentForm">
	<div class="savebar">
		<span>
			<img src="/sys_img/x.png" style="height:20px; height:20px; padding:20px; cursor:pointer;" onclick="cancel()">
		</span>
		<span>
			<input class="save" type="button" value="임시" onclick="goSaved()">
			<input class="save" type="button" value="임시등록" onclick="TemporarySave()">
			<input class="save save_btn" type="button" value="등록" onclick="uploadPost()">
		</span>
	</div>
	<hr>
	<div style="width:100%;">
		<input type="text" name="title" class="title" placeholder="제목" value="${requestScope.title}">
	</div>
    <div class="toolbar">
    	<img class="tool image" src="/sys_img/이미지.png" onclick="$('#fileInput').click();">
    	<input type="file" id="fileInput" name="image" style="display:none;">
    	
        <select class="tool" onchange="fontStyle(this.value)">
            <option value="sans-serif">기본서체</option>
            <option value="Malgun Gothic">맑은고딕</option>
            <option value="Nanum Gothic">나눔고딕</option>
            <option value="NanumSquare">나눔스퀘어</option>
            <option value="Gulim">굴림체</option>
            <option value="Dotum">돋움체</option>
            <option value="Batang">바탕체</option>
            <option value="Gungsuh">궁서체</option>
        </select>

        <input type="button" class="tool" value="굵게" onclick="execCommand('bold')">
        <input type="button" class="tool" value="이탤릭체" onclick="execCommand('italic')">
        <input type="button" class="tool" value="밑줄" onclick="execCommand('underline')">
        <input type="button" class="tool" value="취소선" onclick="execCommand('strikeThrough')">
        <img class="tool image" src="/sys_img/수평선.png" onclick="inputHr()">
        <input type="button" class="tool" value="●" onclick="execCommand('insertUnorderedList')">

        <select class="tool" onchange="setFontSize(this.value)">
            <option value="1">10</option>
            <option value="2">13</option>
            <option value="3">16</option>
            <option value="4" selected>18</option>
            <option value="5">24</option>
            <option value="6">32</option>
            <option value="7">48</option>
        </select>

        <select class="tool" onchange="setFontColor(this.value)">
            <option value="#000000">글자색상</option>
            <option value="#000000">검정</option>
            <option value="#808080">회색</option>
            <option value="#ffffff">하양</option>
            <option value="#ff0000">빨강</option>
            <option value="#ff7f00">주황</option>
            <option value="#ffff00">노랑</option>
            <option value="#adff2f">연두</option>
            <option value="#008000">초록</option>
            <option value="#00ffff">하늘</option>
            <option value="#0000ff">파랑</option>
            <option value="#800080">보라</option>
            <option value="#ff69b4">분홍</option>
        </select>

        <select class="tool" onchange="setBackgroundColor(this.value)">
            <option value="#ffffff">배경색상</option>
            <option value="#000000">검정</option>
            <option value="#808080">회색</option>
            <option value="#ffffff">하양</option>
            <option value="#ff0000">빨강</option>
            <option value="#ff7f00">주황</option>
            <option value="#ffff00">노랑</option>
            <option value="#adff2f">연두</option>
            <option value="#008000">초록</option>
            <option value="#00ffff">하늘</option>
            <option value="#0000ff">파랑</option>
            <option value="#800080">보라</option>
            <option value="#ff69b4">분홍</option>
        </select>

        <img class="alignment tool" src="/sys_img/왼쪽정렬.png" onclick="alignText('justifyleft')">
        <img class="alignment tool" src="/sys_img/가운데정렬.png" onclick="alignText('justifycenter')">
        <img class="alignment tool" src="/sys_img/오른쪽정렬.png" onclick="alignText('justifyright')">
    </div>

	<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
	<!-- 편집기 -->
	<!-- ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ -->
    <div class="editor" contenteditable="true" spellcheck="false">${requestScope.content}</div>


	<div class="upload-box_ingredient-checkbox_container">
	    <div class="upload-box" onclick="$('#foodImg').click()">
	    	완성된 음식 사진을 올려주세요.
	    </div>
		<div class="ingredient-checkbox">
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
    <input type="file" id="foodImg" name="foodImg" style="display:none;">
    
    <div class="bottomSavebar">
    	<span class="bottomCancel" onclick="cancel()">
    		취소
    	</span>
    	<span class="bottomSave" onclick="uploadPost()">
    		저장
    	</span>
    </div>
    
	<input type="hidden" name="content">
	<input type="hidden" name="r_code">
</form>


<!-- 상단에 고정할 헤더 -->
<div class="toolbarHeader">
    	<img class="tool image" src="/sys_img/이미지.png" onclick="$('#fileInput').click();">
    	<input type="file" id="fileInput" name="image" style="display:none;">
    	
        <select class="tool" onchange="fontStyle(this.value)">
            <option value="sans-serif">기본서체</option>
            <option value="Malgun Gothic">맑은고딕</option>
            <option value="Nanum Gothic">나눔고딕</option>
            <option value="NanumSquare">나눔스퀘어</option>
            <option value="Gulim">굴림체</option>
            <option value="Dotum">돋움체</option>
            <option value="Batang">바탕체</option>
            <option value="Gungsuh">궁서체</option>
        </select>

        <input type="button" class="tool" value="굵게" onclick="execCommand('bold')">
        <input type="button" class="tool" value="이탤릭체" onclick="execCommand('italic')">
        <input type="button" class="tool" value="밑줄" onclick="execCommand('underline')">
        <input type="button" class="tool" value="취소선" onclick="execCommand('strikeThrough')">
        <img class="tool image" src="/sys_img/수평선.png" onclick="inputHr()">

        <select class="tool" onchange="setFontSize(this.value)">
            <option value="1">10</option>
            <option value="2">13</option>
            <option value="3">16</option>
            <option value="4" selected>18</option>
            <option value="5">24</option>
            <option value="6">32</option>
            <option value="7">48</option>
        </select>

        <select class="tool" onchange="setFontColor(this.value)">
            <option value="#000000">글자색상</option>
            <option value="#000000">검정</option>
            <option value="#808080">회색</option>
            <option value="#ffffff">하양</option>
            <option value="#ff0000">빨강</option>
            <option value="#ff7f00">주황</option>
            <option value="#ffff00">노랑</option>
            <option value="#adff2f">연두</option>
            <option value="#008000">초록</option>
            <option value="#00ffff">하늘</option>
            <option value="#0000ff">파랑</option>
            <option value="#800080">보라</option>
            <option value="#ff69b4">분홍</option>
        </select>

        <select class="tool" onchange="setBackgroundColor(this.value)">
            <option value="#ffffff">배경색상</option>
            <option value="#000000">검정</option>
            <option value="#808080">회색</option>
            <option value="#ffffff">하양</option>
            <option value="#ff0000">빨강</option>
            <option value="#ff7f00">주황</option>
            <option value="#ffff00">노랑</option>
            <option value="#adff2f">연두</option>
            <option value="#008000">초록</option>
            <option value="#00ffff">하늘</option>
            <option value="#0000ff">파랑</option>
            <option value="#800080">보라</option>
            <option value="#ff69b4">분홍</option>
        </select>

        <img class="alignment tool" src="/sys_img/왼쪽정렬.png" onclick="alignText('justifyleft')">
        <img class="alignment tool" src="/sys_img/가운데정렬.png" onclick="alignText('justifycenter')">
        <img class="alignment tool" src="/sys_img/오른쪽정렬.png" onclick="alignText('justifyright')">
    </div>
</body>
</html>
