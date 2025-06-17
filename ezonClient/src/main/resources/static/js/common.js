/*
	servers url
	- 사용자 서비스(auth) 		: 10000
	- 상품 서비스(products) 	: 10100
	- 주문 서비스(orders) 		: 10200
	- 장바구니 서비스(cart) 		: 10300
	- 결제 서비스(payment)		: 10400
	- 배송 서비스(delivery) 	: 10500
	- 문의 서비스(oneToOnes) 	: 10600
	- 고객센터 서비스(customer) 	: 10700
	- 정산 서비스(settlement) 	: 10800
	- 찜 서비스(wish) 			: 10900 
*/

const authServer = "http://localhost:10000/api/auth";
const productsServer = "http://localhost:10100/api/products";
const ordersServer = "http://localhost:10200/api/orders";
const cartServer = "http://localhost:10300/api/cart";
const paymentServer = "http://localhost:10400/api/payment";
const deliveryServer = "http://localhost:10500/api/delivery";
const oneToOnesServer = "http://localhost:10600/api/oneToOnes";
const customerServer = "http://localhost:10700/api/customer";
const settlementServer = "http://localhost:10800/api/settlement";
const wishServer = "http://localhost:10900/api/wish";