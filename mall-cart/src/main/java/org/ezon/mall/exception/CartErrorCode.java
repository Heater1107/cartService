package org.ezon.mall.exception;

public enum CartErrorCode {
	NOT_FOUND,					// 없는 cart/cartItem
	INVALID_REQUEST,  			// 잘못된요청(수량 0개 이하)
	CART_LIMIT_EXCEEDED,		// 최대 구매갯수 초과
	UNKNOWN_ERROR
}
