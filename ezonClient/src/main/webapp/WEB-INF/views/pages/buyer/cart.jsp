<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>롯데ON 장바구니 (MSA/목업)</title>
    <link rel="stylesheet" href="/css/buyer/cart.css">
    <link rel="stylesheet" href="/css/common/base.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/js/buyer/cart.js"></script>
</head>
<body>
    <div class="cart-page-container">
        <h2 class="cart-title">장바구니</h2>
        <!-- 테스트용 이후 삭제 -->
        <div style="max-width:400px;margin:0 auto 18px auto;display:flex;gap:8px;align-items:center;">
            <label>
                테스트용 유저ID:
                <input type="number" id="userId" value="1" min="1" style="width:70px;">
            </label>
            <button style="padding:6px 18px;border:none;border-radius:6px;background:#ed1c24;color:#fff;cursor:pointer;" onclick="fetchCartWithProductInfo()">조회</button>
        </div>
        <!-- 테스트용 이후 삭제 -->
        <div class="cart-main-flex">
            <div class="cart-left">
                <div class="cart-select-all">
                    <input type="checkbox" id="selectAll" onclick="toggleAll(this)">
                    <label for="selectAll"><b>전체선택</b> (<span id="itemCount">0</span>)</label>
                </div>
                <div id="cartList" class="cart-list"></div>
                <div class="cart-info-bottom">
                    <ul>
                        <li>장바구니에 담긴 상품은 99일까지 보관됩니다.</li>
                        <li>장바구니 수량이 초과된 경우 일부 상품만 보일 수 있습니다.</li>
                        <li>결제 시 배송비/쿠폰 등은 최종 주문서에서 확인 가능합니다.</li>
                        <li>롯데ON에서 직접 판매하는 상품은 묶음배송이 적용될 수 있습니다.</li>
                    </ul>
                </div>
            </div>
            <div class="cart-right">
                <div class="order-box">
                    <div class="order-box-label">결제예정금액</div>
                    <div class="order-info-row">
                        <span class="order-info-label">상품금액</span>
                        <span class="order-info-value"><span id="itemSum">0</span>원</span>
                    </div>
                    <div class="order-info-row">
                        <span class="order-info-label">배송비</span>
                        <span class="order-info-value"><span id="shippingFee">0</span>원</span>
                    </div>
                    <div class="order-bottom-row">
                        <span class="order-count">총 <span class="count-num" id="orderCount">0</span>건</span>
                        <span class="order-final-total" id="orderTotal">0원</span>
                    </div>
                    <button class="order-btn" onclick="orderNow()">주문하기</button>
                </div>
            </div>
        </div>
    </div>
    <a href="/buyer/productDetail">테스트용 상품 상세 페이지</a><br>
</body>
</html>
