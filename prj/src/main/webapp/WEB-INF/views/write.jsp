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
	body {
	    margin: 0;
	    padding: 0;
	    overflow-x: hidden;
	    font-family: sans-serif;
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
    }

	//커서 마지막 위치 추적
    function updateSavedRange() {
        const selection = window.getSelection();
        if (selection.rangeCount > 0) {
            savedRange = selection.getRangeAt(0).cloneRange();
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
    
    function sendContent(){
    	const content = $(".editor").html();
    	$("[name='content']").val(content);
    	$("[name='r_code']").val(rCode(17));
    	
    	var formObj = $("[name='contentForm']");
		ajax(
		     "/writeInsertProc.do",
		     "post",
		     formObj,
		     function (cnt) {
		    	 alert(cnt);
		     }
		);
    }
</script>
</head>
<body>
<form name="contentForm">
	<div class="savebar">
		<span>
			<img src="/sys_img/x.png" style="height:20px; height:20px; padding:20px; cursor:pointer;">
		</span>
		<span>
			<input class="save" type="button" value="임시">
			<input class="save" type="button" value="임시등록">
			<input class="save save_btn" type="button" value="등록" onclick="sendContent()">
		</span>
	</div>
	<hr>
	<div style="width:100%;">
		<input type="text" name="title" class="title" placeholder="제목">
	</div>
    <div class="toolbar">
    	<img class="tool" src="/sys_img/이미지.png" style="border-radius:5px; height:25px; margin: 0 15px;" onclick="$('#fileInput').click();">
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
            <option value="#000000">글자</option>
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
            <option value="#ffffff">배경</option>
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

    <div class="editor" contenteditable="true" spellcheck="false"></div>
	<input type="hidden" name="content">
	<input type="hidden" name="r_code">
</form>
</body>
</html>
