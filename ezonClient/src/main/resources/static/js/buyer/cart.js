const API_BASE = "http://localhost:8080"; // [수정] 게이트웨이 API 엔드포인트로 고정

let cartItems = [];
let selectedIds = new Set();

/**
 * 총 n건(장바구니 담긴 전체 상품 수) 숫자만 빨간색
 */
function updateOrderCount() {
    const checkedCount = selectedIds.size;
    document.getElementById('orderCount').innerHTML = `<span class="count-num">${checkedCount}</span>`;
}

// ===============================
// [실제 서비스] 상품 서비스에서 productId별 정보 조회
// ===============================
async function fetchProductInfoList(productIds) {
    if (!productIds || productIds.length === 0) return [];
    // 상품 서비스에서 여러 상품 정보 한 번에 조회 (게이트웨이 경유)
    const res = await fetch(`${API_BASE}/api/products?productIds=${productIds.join(',')}`); // [수정]
    return await res.json();
}

// ===============================
// 장바구니 목록+상품정보 조회 (실서비스 연동)
// ===============================
async function fetchCartWithProductInfo() {
    const userId = getUserId();
    const cartRes = await fetch(`${API_BASE}/api/cart?userId=${userId}`); // [수정]
    const cartData = await cartRes.json(); // [{cartItemId, productId, quantity}...]

    if (!cartData || cartData.length === 0) {
        cartItems = [];
        renderCart();
        return;
    }

    // 실제 서비스: 상품 서비스에서 productId별로 정보 조회
    const productIds = cartData.map(item => item.productId);
    const productInfoList = await fetchProductInfoList(productIds);

    // productId 기반 맵핑
    const productInfoMap = {};
    productInfoList.forEach(item => productInfoMap[item.productId] = item);

    cartItems = cartData.map(item => ({
        ...item,
        ...productInfoMap[item.productId]
    }));

    renderCart();
}

// ===============================
// 장바구니 화면 렌더링 (이전과 동일)
function renderCart() {
    const listDiv = document.getElementById('cartList');
    if (cartItems.length === 0) {
        listDiv.innerHTML = `<div style="text-align:center; color:#aaa; font-size:20px; padding:70px 0;">장바구니에 담긴 상품이 없습니다.</div>`;
        document.getElementById('itemSum').innerText = 0;
        document.getElementById('shippingFee').innerText = 0;
        document.getElementById('orderTotal').innerText = '0원';
        document.getElementById('itemCount').innerText = 0;
        updateOrderCount();
        return;
    }
    let sum = 0, checkedCount = 0;
    let html = '';

    // [중복배송비 합산 방지용]
    const checkedProductIds = new Set();
    let shippingFeeSum = 0;

    for (let i = 0; i < cartItems.length; i++) {
        const item = cartItems[i];
        const finalPrice = (item.discountPrice && item.discountPrice > 0) ? item.discountPrice : item.price;
        const isDiscounted = (item.discountPrice && item.discountPrice > 0 && item.discountPrice < item.price);
        let discountRate = 0;
        if (isDiscounted) {
            discountRate = Math.round((1 - item.discountPrice / item.price) * 100);
        }
        const checked = selectedIds.has(item.cartItemId);

        if (checked) {
            sum += finalPrice * item.quantity;
            checkedCount++;
            if (!checkedProductIds.has(item.productId)) {
                shippingFeeSum += item.shippingFee ? Number(item.shippingFee) : 0;
                checkedProductIds.add(item.productId);
            }
        }

        html += `
        <div class="cart-card">
            <input type="checkbox" class="cart-checkbox" 
                id="cartChk_${item.cartItemId}" 
                ${checked ? 'checked' : ''} 
                onchange="toggleItem(${item.cartItemId})">
            <img src="${item.image || 'https://cdn.pixabay.com/photo/2016/03/05/19/02/salad-1238248_1280.jpg'}" class="cart-img" alt="상품">
            <div class="cart-card-info">
                <div class="cart-card-title">${item.name || '상품명'}</div>
            </div>
            <div class="cart-card-action">
                <div class="cart-qty-wrap">
                    <button class="qty-btn" onclick="changeQuantity(${item.cartItemId}, ${item.quantity - 1})">-</button>
                    <input type="number" class="qty-input" min="1" value="${item.quantity}" onchange="setQuantity(${item.cartItemId}, this.value)">
                    <button class="qty-btn" onclick="changeQuantity(${item.cartItemId}, ${item.quantity + 1})">+</button>
                </div>
                ${
                    isDiscounted
                    ? `<span class="discount-rate">${discountRate}%↓</span>`
                    : `<span class="discount-rate">&nbsp;</span>`
                }
                <div class="cart-price-fraction">
                    ${
                        isDiscounted
                        ? `<span class="origin-price">${(item.price * item.quantity).toLocaleString()}원</span>
                           <span class="final-price">${(finalPrice * item.quantity).toLocaleString()}원</span>`
                        : `<span class="final-price">${(finalPrice * item.quantity).toLocaleString()}원</span>`
                    }
                </div>
                <button class="cart-remove-btn" onclick="deleteItem(${item.cartItemId})">&times;</button>
            </div>
        </div>
        `;
    }

    listDiv.innerHTML = html;

    // 금액 합산/배송비/최종합계 표시
    document.getElementById('itemSum').innerText = sum.toLocaleString();
    document.getElementById('shippingFee').innerText = shippingFeeSum.toLocaleString();
    document.getElementById('orderTotal').innerText = (sum + shippingFeeSum).toLocaleString() + '원';
    document.getElementById('itemCount').innerText = checkedCount;
    updateOrderCount();

    // 전체선택 체크박스 상태 동기화
    const selectAll = document.getElementById('selectAll');
    if (selectAll) {
        selectAll.checked = (checkedCount > 0 && checkedCount === cartItems.length);
        selectAll.indeterminate = (checkedCount > 0 && checkedCount < cartItems.length);
    }
}

// ===============================
// 장바구니 선택/수량/삭제 관련
// ===============================
window.toggleItem = function(cartItemId) {
    if (selectedIds.has(cartItemId)) {
        selectedIds.delete(cartItemId);
    } else {
        selectedIds.add(cartItemId);
    }
    renderCart();
}

window.toggleAll = function(checkbox) {
    if (checkbox.checked) {
        selectedIds = new Set(cartItems.map(item => item.cartItemId));
    } else {
        selectedIds = new Set();
    }
    renderCart();
}

// ===============================
// 수량 변경(증감/직접입력)
// ===============================
function changeQuantity(cartItemId, quantity) {
    if(quantity < 1) return;
    fetch(`${API_BASE}/api/cart/${cartItemId}`, { // [수정]
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({ quantity })
    }).then(res => {
        if(res.ok) fetchCartWithProductInfo();
    });
}

function setQuantity(cartItemId, quantity) {
    quantity = parseInt(quantity);
    if(isNaN(quantity) || quantity < 1) return;
    fetch(`${API_BASE}/api/cart/${cartItemId}`, { // [수정]
        method: 'PUT',
        headers: {'Content-Type': 'application/json'},
        body: JSON.stringify({ quantity })
    }).then(res => {
        if(res.ok) fetchCartWithProductInfo();
    });
}

// ===============================
// 장바구니 상품 삭제
// ===============================
function deleteItem(cartItemId) {
    fetch(`${API_BASE}/api/cart/${cartItemId}`, { method: 'DELETE' }) // [수정]
        .then(res => {
            if(res.ok) {
                selectedIds.delete(cartItemId);
                fetchCartWithProductInfo();
            }
        });
}

// ===============================
// 주문하기 버튼 클릭 처리
// ===============================
function orderNow() {
    if (selectedIds.size === 0) {
        alert("주문할 상품을 선택해주세요.");
        return;
    }
    let orderSummary = '';
    let total = 0;
    let orderItems = [];
    let deleteCartItemIds = []; 
    for (const item of cartItems) {
        if (selectedIds.has(item.cartItemId)) {
            const finalPrice = (item.discountPrice && item.discountPrice > 0) ? item.discountPrice : item.price;
            orderSummary += `${item.name || '상품명'} x${item.quantity} (${(finalPrice * item.quantity).toLocaleString()}원)\n`;
            total += finalPrice * item.quantity;
            orderItems.push({
                productId: item.productId,
                quantity: item.quantity
            });
            deleteCartItemIds.push(item.cartItemId); 
        }
    }

    // ===============================
    // [테스트/개발] 결제 완료시 장바구니 선택 상품 삭제
    // 실제 서비스에서는 주문·결제 콜백 후 이 부분만 호출
    // ===============================
    fetch(`${API_BASE}/api/cart/items`, { // [수정]
        method: 'DELETE',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            cartItems: deleteCartItemIds // ★
        })
    }).then(res => {
        if(res.ok) {
            alert(
                `주문상품:\n${orderSummary}\n총 결제금액: ${total.toLocaleString()}원\n\n결제가 완료되었습니다!\n선택한 상품이 장바구니에서 삭제되었습니다.`
            );
            fetchCartWithProductInfo();
        } else {
            res.text().then(msg => alert('장바구니 상품 삭제 실패: ' + msg));
        }
    });
    // [실제 서비스]에서는 아래 주석 참고
    // fetch('/api/orders', {
    //     method: 'POST',
    //     headers: {'Content-Type':'application/json'},
    //     body: JSON.stringify({ userId: getUserId(), items: orderItems })
    // }).then(res => {
    //     if(res.ok) {
    //         alert('주문이 정상적으로 접수되었습니다!');
    //         // 장바구니 목록 새로고침/비우기 등 처리
    //     } else {
    //         res.text().then(msg => alert('주문 실패: ' + msg));
    //     }
    // });
    alert(`주문상품:\n${orderSummary}\n총 결제금액: ${total.toLocaleString()}원\n\n※ 실제 운영에선 /api/orders로 주문 요청`);
}

// ===============================
// 로그인/세션 등에서 userId 받아오는 함수 (임시)
// ===============================
function getUserId() {
    const input = document.getElementById('userId');
    return input ? parseInt(input.value, 10) : 1;
}

// ===============================
// 페이지 진입시 장바구니 조회
// ===============================
window.onload = function() {
    fetchCartWithProductInfo();
};
