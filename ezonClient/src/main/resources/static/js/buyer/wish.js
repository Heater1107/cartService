// ===============================
// [API BASE] 포트 고정 (MSA/테스트환경)
const WISH_API_BASE = 'http://localhost:8080/api/wish'; // 게이트웨이 경유로 포트 고정

// ===============================
// [실서비스 연동] 상품 정보/판매자 정보도 각각 API에서 조회
// ===============================
function getUserId() {
    // 상세페이지에서는 input에서 가져가고, 목록페이지 등에서는 1로 기본값 처리
    const input = document.getElementById('userIdInput');
    return input ? parseInt(input.value, 10) || 1 : 1;
}

// ===============================
// 상품 찜 목록 조회+렌더링 (실서비스 연동)
async function loadProductWishList() {
    const userId = getUserId();
    const res = await fetch(`${WISH_API_BASE}/products?userId=${userId}`);
    const list = await res.json();

    const wrap = document.getElementById('wishProductTab');
    if (!wrap) return;
    if (!list || list.length === 0) {
        wrap.innerHTML = `<div class="wish-empty">찜한 상품이 없습니다.</div>`;
        return;
    }
    // 2) 찜 목록에 해당하는 productId별 상품 정보 모두 불러오기
    const productIds = list.map(item => item.productId);
    let productInfoList = [];
    if (productIds.length > 0) {
        const res2 = await fetch(`http://localhost:8080/api/products?productIds=${productIds.join(',')}`);
        productInfoList = await res2.json();
    }
    const productInfoMap = {};
    productInfoList.forEach(item => productInfoMap[item.productId] = item);

    let html = '';
    list.forEach(item => {
        const info = productInfoMap[item.productId] || {};
        const finalPrice = (info.discountPrice && info.discountPrice > 0) ? info.discountPrice : info.price;
        const isDiscounted = (info.discountPrice && info.discountPrice > 0 && info.discountPrice < info.price);
        let discountRate = 0;
        if (isDiscounted) discountRate = Math.round((1 - info.discountPrice / info.price) * 100);

        html += `
        <div class="wish-card">
            <img class="wish-img" src="${info.image || ''}" alt="상품이미지">
            <div class="wish-info">
                <div class="wish-product-name" onclick="location.href='/test-상품상세.jsp?productId=${item.productId}'">${info.name || '상품명'}</div>
                <div class="wish-product-price">
                    ${isDiscounted ? `<span class="origin-price">${info.price.toLocaleString()}원</span>
                    <span class="discount-rate">${discountRate}%↓</span>
                    <span class="final-price">${finalPrice.toLocaleString()}원</span>`
                    : `<span class="final-price">${finalPrice ? finalPrice.toLocaleString() + '원' : ''}</span>`}
                </div>
            </div>
            <button class="wish-delete-btn" onclick="deleteProductWish(${item.productId})">삭제</button>
        </div>
        `;
    });
    wrap.innerHTML = `<div class="wish-list">${html}</div>`;
}

// ===============================
// 판매자 찜 목록 조회+렌더링 (실서비스 연동)
async function loadSellerWishList() {
    const userId = getUserId();
    const res = await fetch(`${WISH_API_BASE}/sellers?userId=${userId}`);
    const list = await res.json();

    const wrap = document.getElementById('wishSellerTab');
    if (!wrap) return;
    if (!list || list.length === 0) {
        wrap.innerHTML = `<div class="wish-empty">찜한 판매자가 없습니다.</div>`;
        return;
    }

    let html = '';
    list.forEach(item => {
        html += `
        <div class="wish-card">
            <div class="wish-info">
                <div class="wish-seller-name" onclick="location.href='/test-판매자.jsp?sellerUserId=${item.sellerUserId}'">${item.sellerUserId || '판매자'}</div>
                <div class="wish-seller-extra"></div>
            </div>
            <button class="wish-delete-btn" onclick="deleteSellerWish(${item.sellerUserId})">삭제</button>
        </div>
        `;
    });
    wrap.innerHTML = `<div class="wish-list">${html}</div>`;
}

// ===============================
// 상품 찜 삭제
function deleteProductWish(productId) {
    const userId = getUserId();
    if (!confirm('이 상품을 찜 목록에서 삭제하시겠습니까?')) return;
    fetch(`${WISH_API_BASE}/products/${productId}?userId=${userId}`, { method: 'DELETE' })
        .then(res => {
            if (res.ok) loadProductWishList();
            else alert('삭제 실패');
        });
}

// ===============================
// 판매자 찜 삭제
function deleteSellerWish(sellerUserId) {
    const userId = getUserId();
    if (!confirm('이 판매자를 찜 목록에서 삭제하시겠습니까?')) return;
    fetch(`${WISH_API_BASE}/sellers/${sellerUserId}?userId=${userId}`, { method: 'DELETE' })
        .then(res => {
            if (res.ok) loadSellerWishList();
            else alert('삭제 실패');
        });
}

// ===============================
// 상품상세, 목록 등에서 찜 상태 조회
function fetchWishStatus(productId, callback) {
    const userId = getUserId();
    fetch(`${WISH_API_BASE}/products?userId=${userId}`)
        .then(res => res.json())
        .then(data => {
            const wishStatus = !!(data && Array.isArray(data) && data.some(item => item.productId == productId));
            if (callback) callback(wishStatus);
        }).catch(() => {
            if (callback) callback(false);
        });
}

// ===============================
// 상품상세, 목록 등에서 찜 토글
function toggleWish(productId, onResult) {
    const userId = getUserId();
    fetch(`${WISH_API_BASE}/products/toggle`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `userId=${userId}&productId=${productId}`
    })
    .then(res => res.json())
    .then(result => {
        if (onResult) onResult(!!result);
    })
    .catch(() => {
        alert('찜 처리 중 오류가 발생했습니다.');
        if (onResult) onResult(false);
    });
}

// ===============================
// 판매자상세 등에서 찜 토글
function toggleSellerWish(sellerUserId, onResult) {
    const userId = getUserId();
    fetch(`${WISH_API_BASE}/sellers/toggle`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: `userId=${userId}&sellerUserId=${sellerUserId}`
    })
    .then(res => res.json())
    .then(result => {
        if (onResult) onResult(!!result);
    })
    .catch(() => {
        alert('찜 처리 중 오류가 발생했습니다.');
        if (onResult) onResult(false);
    });
}
