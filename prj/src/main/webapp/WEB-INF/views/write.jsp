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

    .toolbar {
        margin: 20px 10px;
        display: flex;
        align-items: center;
        gap: 10px;
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
    $(function () {
        $(".editor").on('input', function () {
            if (this.innerHTML.trim() === "<br>" || this.innerHTML.trim() === "<div><br></div>") {
                this.innerHTML = '';
            }
        });
    });

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
    	$("[name='r_code']").(rCode(17));
    	
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
    <div class="toolbar">
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

        <button class="tool" onclick="execCommand('bold')">굵게</button>
        <button class="tool" onclick="execCommand('italic')">이탤릭체</button>
        <button class="tool" onclick="execCommand('underline')">밑줄</button>
        <button class="tool" onclick="execCommand('strikeThrough')">취소선</button>

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
    
    <form name="contentForm">
    	<input type="hidden" name="content">
    	<input type="hidden" name="r_code">
    </form>
</body>
</html>
