<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>테스트 상품목록</title>
    <style>
        body { background: #f8f9fa; font-family: '맑은 고딕', Arial, sans-serif; }
        .container { max-width: 900px; margin: 50px auto; }
        .product-list { display: flex; flex-wrap: wrap; gap: 30px; }
        .card { background: #fff; border-radius: 14px; box-shadow: 0 4px 20px #0001; width: 200px; padding: 24px 14px 18px 14px; text-align: center; transition: box-shadow 0.18s; cursor: pointer;}
        .card:hover { box-shadow: 0 8px 28px #0002; }
        .card-img { width: 110px; height: 110px; object-fit: cover; border-radius: 9px; }
        .card-title { font-size: 18px; margin: 12px 0 5px; font-weight: 600; color: #212529;}
        .card-price { color: #d32f2f; font-weight: bold; font-size: 15px;}
    </style>
    <link href="${pageContext.request.contextPath}/css/common/base.css" rel="stylesheet" type="text/css">
</head>
<body>
<div class="container">
    <h2>상품 목록 (테스트)</h2>
    <div class="product-list" id="productList"></div>
</div>
<script>
fetch('http://localhost:8080/api/products')
    .then(function(res) {
        if (!res.ok) throw new Error('fetch error');
        return res.json();
    })
    .then(function(productList) {
        console.log('상품 리스트:', productList);
        if (productList && productList.length > 0) {
            console.log(productList[0].image, productList[0].name, productList[0].price, productList[0].discountPrice);
        }
        var listDiv = document.getElementById('productList');
        if (!productList || productList.length === 0) {
            listDiv.innerHTML = '<div style="padding: 40px; color: #888;">상품이 없습니다.</div>';
            return;
        }
        listDiv.innerHTML = productList.map(function(p) {
            var priceVal = (typeof p.discountPrice === 'number' && p.discountPrice > 0) ? p.discountPrice : p.price;
            priceVal = priceVal ? priceVal.toLocaleString() : '0';
            return '<div class="card" onclick="location.href=\'/buyer/productDetail?productId=' + p.productId + '\'">' +
                   '<img class="card-img" src="' + (p.image || '') + '" alt="상품">' +
                   '<div class="card-title">' + (p.name || '') + '</div>' +
                   '<div class="card-price">' + priceVal + '원</div>' +
                   '</div>';
        }).join('');
    })
    .catch(function() {
        document.getElementById('productList').innerHTML =
            '<div style="padding:40px;color:#888;">상품 정보를 불러오지 못했습니다.</div>';
    });
</script>
</body>
</html>
