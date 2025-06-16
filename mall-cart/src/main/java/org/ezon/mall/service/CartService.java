package org.ezon.mall.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.ezon.mall.dto.CartItemRequestDTO;
import org.ezon.mall.entity.Cart;
import org.ezon.mall.entity.CartItem;
import org.ezon.mall.exception.CartErrorCode;
import org.ezon.mall.exception.CartException;
import org.ezon.mall.repository.CartItemRepository;
import org.ezon.mall.repository.CartRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CartService {
	
	@Autowired
	private CartRepository cartRepository;
	
	@Autowired
	private CartItemRepository cartItemRepository;

	public CartService(CartRepository cartRepository, CartItemRepository cartItemRepository) {
		this.cartRepository = cartRepository;
		this.cartItemRepository = cartItemRepository;
	}

	// 장바구니에 상품 추가
	public void addCartItem(CartItemRequestDTO req) {
		if(req.getQuantity() == null || req.getQuantity() <= 0) {
			throw new CartException("상품의 수량은 1개 이상이어야 합니다.", CartErrorCode.INVALID_REQUEST);
		}
		
		Cart cart = cartRepository.findByUserId(req.getUserId());
		if(cart == null) {
			cart = Cart.builder().userId(req.getUserId()).build();
			cart = cartRepository.save(cart);
		}
		
		List<CartItem> items = cartItemRepository.findByCartId(cart.getCartId());
		CartItem target = null;
		for(int i = 0; i < items.size(); i++) {
			CartItem item = items.get(i);
			if(item.getProductId().equals(req.getProductId())) {
				target = item;
				break;
			}
		}
		
		if(target != null) {
			// 장바구니에 같은 상품이 이미 있다면 수량 증가
			target.setQuantity(target.getQuantity() + req.getQuantity());
			if(req.getSelected() != null) {
				target.setSelected(req.getSelected());
			}
			cartItemRepository.save(target);
		} else {
			// 장바구니에 같은 상품 이없다면 새로 추가 
			CartItem cartItem = CartItem.builder()
					.cartId(cart.getCartId())
					.productId(req.getProductId())
					.quantity(req.getQuantity())
					.selected(req.getSelected())
					.build();
			cartItemRepository.save(cartItem);
		}
	}
	
	// 장바구니 목록 조회
	public List<CartItem> getCartItems(Long userId) {
		Cart cart = cartRepository.findByUserId(userId);
		if(cart == null) {
			return new ArrayList<CartItem>();
		}
		return cartItemRepository.findByCartId(cart.getCartId());
	}
	
	// 장바구니 상품 수량 변경
	public void updateCartItem(Long cartItemId, Long quantity) {
		if(quantity == null || quantity <= 0) {
			throw new CartException("상품의 수량은 1개 이상이어야 합니다.", CartErrorCode.INVALID_REQUEST);
		}
		Optional<CartItem> opt = cartItemRepository.findById(cartItemId);
		if(!opt.isPresent()) {
			throw new CartException("장바구니에 해당 상품이 없습니다.", CartErrorCode.NOT_FOUND);
		}
		CartItem item = opt.get();
		item.setQuantity(quantity);
		cartItemRepository.save(item);
	}
	
	// 장바구니 상품 삭제
	public void deleteCartItem(Long cartItemId) {
		if(!cartItemRepository.existsById(cartItemId)) {
			throw new CartException("장바구니에 해당 상품이 없습니다.", CartErrorCode.NOT_FOUND);
		}
		cartItemRepository.deleteById(cartItemId);
	}
	
	// 결제후 장바구니 상품 삭제
	public void deleteItemsByCartItemIds(List<Long> cartItems) {
	    if (cartItems == null || cartItems.isEmpty()) {
	        throw new CartException("삭제할 상품 정보가 없습니다.", CartErrorCode.INVALID_REQUEST);
	    }
	    boolean deleted = false;
	    for (Long cartItemId : cartItems) {
	        if (cartItemRepository.existsById(cartItemId)) {
	            cartItemRepository.deleteById(cartItemId);
	            deleted = true;
	        }
	    }
	    if (!deleted) {
	        throw new CartException("삭제할 장바구니 상품이 없습니다.", CartErrorCode.NOT_FOUND);
	    }
	}

}
