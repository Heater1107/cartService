<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>나의 찜 목록 - 롯데ON 스타일</title>
    <link rel="stylesheet" href="/css/buyer/wish.css">
</head>
<body>
    <div class="wish-container">
        <h2 class="wish-title">찜 목록</h2>
        <div class="wish-tabs">
            <button class="wish-tab active" data-tab="product">상품</button>
            <button class="wish-tab" data-tab="seller">판매자</button>
        </div>
        <div class="wish-content">
            <div id="wishProductTab" class="wish-tab-content"></div>
            <div id="wishSellerTab" class="wish-tab-content" style="display:none"></div>
        </div>
    </div>
    <script src="/js/buyer/wish.js"></script>
</body>
</html>