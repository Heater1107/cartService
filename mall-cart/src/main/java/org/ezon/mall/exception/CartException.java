package org.ezon.mall.exception;

public class CartException extends RuntimeException {
	
	private final CartErrorCode errorCode;

	public CartException(String message, CartErrorCode errorCode) {
		super(message);
		this.errorCode = errorCode;
	}
	
	public CartErrorCode getErrorCode() {
		return errorCode;
	}

}
