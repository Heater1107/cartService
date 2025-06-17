<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>테스트 상품상세</title>
    <style>
        body { background: #f7f7fa; font-family: '맑은 고딕', Arial, sans-serif;}
        .container { max-width: 500px; margin: 60px auto; background: #fff; border-radius: 18px; box-shadow: 0 2px 16px #0001; padding: 38px 30px 34px 30px; }
        .img { width: 150px; border-radius: 10px; margin-bottom: 18px;}
        .title { font-size: 22px; font-weight: 700; margin-bottom: 8px;}
        .price { font-size: 20px; color: #d32f2f; font-weight: bold;}
        .seller-link { color: #257; text-decoration: underline; font-size: 16px; font-weight: 600; cursor: pointer; margin-bottom: 14px; display: inline-block;}
        .btn { padding: 9px 26px; margin-right: 7px; font-size: 16px; border-radius: 7px; border: none; cursor: pointer;}
        .btn-wish { background: #fff; color: #d32f2f; border: 1.5px solid #d32f2f;}
        .btn-wish.active { background: #d32f2f; color: #fff;}
        .btn-cart { background: #257; color: #fff; border: none; padding: 9px 26px; border-radius: 7px; cursor: pointer;}
    </style>
    <link href="${pageContext.request.contextPath}/css/common/base.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
    <div style="margin-bottom: 16px;">
        <label>
            테스트용 유저ID:
            <input type="number" id="userIdInput" value="1" min="1" style="width:70px;">
        </label>
    </div>
    <img class="img" id="productImg" src="">
    <div class="title" id="productName"></div>
    <div class="price" id="productPrice"></div>
    <div>
        <span class="seller-link" id="sellerLink"></span>
    </div>
    <button class="btn btn-wish" id="wishBtn" onclick="toggleWish()">♡ 찜하기</button>
    <button class="btn btn-cart" id="cartBtn" onclick="addToCart()">장바구니 담기</button>
</div>

<!-- ... 생략 ... -->
	<script src="/js/buyer/wish.js"></script>
	<script>
	    const productId = parseInt(new URLSearchParams(location.search).get('productId'), 10) || 1;
	    let product = null;
	    let wishStatus = false;
	
	    function loadProductDetail() {
	        fetch('http://localhost:8080/api/products/' + productId)
	            .then(res => res.json())
	            .then(data => {
	                product = data;
	                document.getElementById('productImg').src = product.image || '';
	                document.getElementById('productName').innerText = product.name || '';
	                const price = product.discountPrice && product.discountPrice > 0 ? product.discountPrice : product.price;
	                document.getElementById('productPrice').innerText = (price ? price.toLocaleString() : '') + '원';
	                document.getElementById('sellerLink').innerText = '판매자정보 >';
	                document.getElementById('sellerLink').onclick = function() {
	                    location.href = '/buyer/sellerInfo?sellerUserId=' + (product.userId || '');
	                };
	                fetchWishStatus(productId, function(status) {
	                    wishStatus = status;
	                    renderWishBtn();
	                });
	            })
	            .catch(() => {
	                document.getElementById('productName').innerText = '상품을 불러올 수 없습니다.';
	                document.getElementById('wishBtn').style.display = 'none';
	                document.getElementById('cartBtn').style.display = 'none';
	            });
	    }
	
	    function renderWishBtn() {
	        const btn = document.getElementById('wishBtn');
	        if (!btn) return;
	        btn.innerText = wishStatus ? '♥ 찜취소' : '♡ 찜하기';
	        btn.classList.toggle('active', wishStatus);
	    }
	
	    function onWishBtnClick() {
	        toggleWish(productId, function(added) {
	            wishStatus = added;
	            renderWishBtn();
	            alert(added ? '찜 목록에 추가되었습니다!' : '찜이 해제되었습니다.');
	        });
	    }
	
	    function addToCart(quantity = 1) {
	        const userId = getUserId();
	        fetch('http://localhost:8080/api/cart', {
	            method: 'POST',
	            headers: { 'Content-Type': 'application/json' },
	            body: JSON.stringify({ userId, productId, quantity })
	        })
	        .then(res => {
	            if (res.ok) alert('장바구니에 담겼습니다.');
	            else alert('장바구니 담기 실패');
	        })
	        .catch(() => alert('장바구니 담기 중 오류가 발생했습니다.'));
	    }
	
	    document.getElementById('wishBtn').onclick = onWishBtnClick;
	
	    loadProductDetail();
	</script>
</body>
</html>
