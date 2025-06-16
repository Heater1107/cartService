package org.ezon.mall.repository;

import java.util.List;

import org.ezon.mall.entity.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long>{

	// 장바구니 ID로 cart_item 전부 찾기
	List<CartItem> findByCartId(Long cartId);
}
