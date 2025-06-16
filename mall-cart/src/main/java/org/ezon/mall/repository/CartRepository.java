package org.ezon.mall.repository;

import org.ezon.mall.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CartRepository extends JpaRepository<Cart, Long> {

	// 구매자 ID로 장바구니 식별 
	Cart findByUserId(Long userId);
}
