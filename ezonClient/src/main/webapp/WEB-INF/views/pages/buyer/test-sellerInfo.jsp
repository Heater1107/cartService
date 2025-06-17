<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>테스트 판매자 정보</title>
    <style>
        body { background: #f7f9fa; font-family: '맑은 고딕', Arial, sans-serif; }
        .container { max-width: 500px; margin: 60px auto; background: #fff; border-radius: 17px; box-shadow: 0 3px 14px #0001; padding: 36px 30px 32px 30px;}
        .seller-title { font-size: 24px; font-weight: 700; color: #212529; margin-bottom: 13px;}
        .seller-category { color: #257; font-size: 16px; font-weight: 600;}
        .seller-info { color: #666; font-size: 16px; margin-bottom: 20px;}
        .btn-seller-wish { background: #fff; color: #d32f2f; border: 1.5px solid #d32f2f; padding: 9px 28px; font-size: 16px; border-radius: 8px; font-weight: 600; cursor: pointer;}
        .btn-seller-wish.active { background: #d32f2f; color: #fff;}
    </style>
</head>
<body>
<div class="container">
    <div class="seller-title" id="sellerName"></div>
    <div class="seller-category" id="sellerCategory"></div>
    <div class="seller-info" id="sellerInfo"></div>
    <button class="btn-seller-wish" id="sellerWishBtn" onclick="toggleSellerWish()">♡ 판매자 찜하기</button>
</div>
	<script>
		const sellerList = {
		    10: { name: '나이키 공식몰', category: '스포츠/패션', info: '대표: 김나이키' },
		    20: { name: '애플 공식 판매자', category: '가전/컴퓨터', info: '대표: 팀쿡' },
		    30: { name: '샤오미 스토어', category: '생활/디지털', info: '대표: 레이쥔' }
		};
		function getQueryParam(name) {
		    return new URLSearchParams(location.search).get(name);
		}
		const sellerUserId = parseInt(getQueryParam('sellerUserId'), 10) || 10;
		const seller = sellerList[sellerUserId] || sellerList[10];
		document.getElementById('sellerName').innerText = seller.name;
		document.getElementById('sellerCategory').innerText = seller.category;
		document.getElementById('sellerInfo').innerText = seller.info;
		
		// 판매자 찜(상태/토글)
		let sellerWishStatus = false;
		function fetchSellerWishStatus() {
		    const userId = 1;
		    fetch(`/api/wish/sellers?userId=${userId}`)
		        .then(res => res.json())
		        .then(data => {
		            sellerWishStatus = !!(data && Array.isArray(data) && data.some(item => item.sellerUserId === sellerUserId));
		            renderSellerWishBtn();
		        }).catch(() => {
		            sellerWishStatus = false;
		            renderSellerWishBtn();
		        });
		}
		function renderSellerWishBtn() {
		    const btn = document.getElementById('sellerWishBtn');
		    if (sellerWishStatus) {
		        btn.innerText = '♥ 찜취소';
		        btn.classList.add('active');
		    } else {
		        btn.innerText = '♡ 판매자 찜하기';
		        btn.classList.remove('active');
		    }
		}
		function toggleSellerWish() {
		    const userId = 1;
		    fetch('/api/wish/sellers/toggle', {
		        method: 'POST',
		        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
		        body: `userId=${userId}&sellerUserId=${sellerUserId}`
		    })
		    .then(res => res.json())
		    .then(result => {
		        sellerWishStatus = !!result;
		        renderSellerWishBtn();
		        alert(sellerWishStatus ? '판매자를 찜목록에 추가!' : '판매자 찜이 해제됨.');
		    }).catch(() => {
		        alert('찜 처리 중 오류가 발생했습니다.');
		    });
		}
		fetchSellerWishStatus();
	</script>
</body>
</html>
