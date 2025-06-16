package org.ezon.mall.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class GlobalExceptionHandler {
	
	// 장바구니 예외 처리
	@ExceptionHandler(CartException.class)
	public ResponseEntity<CartErrorResponse> handleCartException(CartException ex) {
		HttpStatus status = HttpStatus.INTERNAL_SERVER_ERROR;
		if(ex.getErrorCode() == CartErrorCode.NOT_FOUND) {
			status = HttpStatus.NOT_FOUND;
		} else if(ex.getErrorCode() == CartErrorCode.INVALID_REQUEST) {
			status = HttpStatus.BAD_REQUEST;
		} else if(ex.getErrorCode() == CartErrorCode.CART_LIMIT_EXCEEDED) {
			status = HttpStatus.FORBIDDEN;
		}
		CartErrorResponse error = new CartErrorResponse(false, ex.getMessage(), ex.getErrorCode().name());
		return ResponseEntity.status(status).body(error);
	}
	
	// 그 외 모든 예외
	@ExceptionHandler(Exception.class)
	public ResponseEntity<CartErrorResponse> handleOtherExceptions(Exception ex) {
		ex.printStackTrace(); 
		CartErrorResponse error = new CartErrorResponse(false, "서버 오류가 발생했습니다.", CartErrorCode.UNKNOWN_ERROR.name());
		return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(error);
	}
	
	// 에러 응답 DTO
	public static class CartErrorResponse {
		private boolean success;
		private String message;
		private String code;
		
		public CartErrorResponse(boolean success, String message, String code) {
			this.success = success;
			this.message = message;
			this.code = code;
		}
		
		public boolean isSuccess() {
			return success;
		}
		
		public String getMessage() {
			return message;
		}
		
		public String getCode() {
			return code;
		}
		
	}
}
