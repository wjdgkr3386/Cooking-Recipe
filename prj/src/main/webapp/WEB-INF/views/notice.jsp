<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공지사항</title>
  <style>
    body {
      font-family: 'Arial', sans-serif;
      padding: 20px;
      background-color: #f8f9fa;
    }
    h1 {
      color: #333;
    }
    .notice-list {
      list-style: none;
      padding: 0;
    }
    .notice-item {
      background: white;
      border: 1px solid #ddd;
      padding: 15px;
      margin-bottom: 10px;
      cursor: pointer;
      transition: background 0.2s;
    }
    .notice-item:hover {
      background: #f0f0f0;
    }
    .notice-date {
      font-size: 0.9em;
      color: #888;
    }
    .notice-content {
      display: none;
      margin-top: 10px;
      color: #444;
    }
  </style>
</head>
<body>

  <h1>공지사항</h1>
  <ul class="notice-list">
    <li class="notice-item" onclick="toggleNotice(this)">
      <strong>[업데이트] 재료 기반 레시피 검색 기능 추가</strong>
      <div class="notice-date">2025.05.04</div>
      <div class="notice-content">
        이제 냉장고 속 재료만 골라서 해당 재료로 만들 수 있는 레시피를 찾을 수 있어요!<br>
        많은 이용 부탁드립니다.
      </div>
    </li>
    <li class="notice-item" onclick="toggleNotice(this)">
      <strong>[공지] 서비스 점검 안내</strong>
      <div class="notice-date">2025.05.03</div>
      <div class="notice-content">
        5월 5일(월) 01:00~03:00까지 서버 점검이 진행됩니다.<br>
        이용에 불편을 드려 죄송합니다.
      </div>
    </li>
  </ul>

  <script>
    function toggleNotice(item) {
      const content = item.querySelector('.notice-content');
      content.style.display = content.style.display === 'block' ? 'none' : 'block';
    }
  </script>

</body>
</html>
