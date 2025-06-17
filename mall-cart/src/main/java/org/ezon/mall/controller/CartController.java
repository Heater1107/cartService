package org.ezon.mall.controller;

import java.util.List;

import org.ezon.mall.dto.CartItemRequestDTO;
import org.ezon.mall.dto.DeleteCartItemsRequestDTO;
import org.ezon.mall.entity.CartItem;
import org.ezon.mall.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;


@RestController
@RequestMapping("/api/cart")
public class CartController {
	
	@Autowired
	private CartService cartService;

	public CartController(CartService cartService) {
		this.cartService = cartService;
	}

	// 장바구니 상품 추가
	@PostMapping
	public ResponseEntity<String> addCartItem(@RequestBody CartItemRequestDTO req) {
		cartService.addCartItem(req);
		return ResponseEntity.ok("장바구니에 상품이 담겼습니다!");
	}
	
	// 장바구니 목록 조회
	@GetMapping
	public ResponseEntity<List<CartItem>> getCartItems(@RequestParam Long userId) {
		List<CartItem> items = cartService.getCartItems(userId);
		return ResponseEntity.ok(items);
	}
	
	// 장바구니 상품 수량 변경
	@PutMapping("/{cartItemId}")
	public ResponseEntity<String> updateCartItem(@PathVariable Long cartItemId, @RequestBody CartItemRequestDTO req) {
		cartService.updateCartItem(cartItemId, req.getQuantity());
		return ResponseEntity.ok("수량이 변경되었습니다.");
	}
	
	// 장바구니 상품 삭제
	@DeleteMapping("/{cartItemId}") 
	public ResponseEntity<String> deleteCartItem(@PathVariable Long cartItemId) {
		cartService.deleteCartItem(cartItemId);
		return ResponseEntity.ok("상품이 장바구니에서 삭제되었습니다.");
		
	}
	
	// 결제 완료 후 여러 cartItemId를 한 번에 삭제 
	@DeleteMapping("/items")
	public ResponseEntity<Void> deleteCartItems(@RequestBody DeleteCartItemsRequestDTO req) {
	    cartService.deleteItemsByCartItemIds(req.getCartItems());
	    return ResponseEntity.ok().build();
	}

	
}
