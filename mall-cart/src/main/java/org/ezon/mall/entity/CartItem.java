package org.ezon.mall.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "cart_item")
public class CartItem {
	
	// 장바구니 상품 식별 번호
	@Id
	@GeneratedValue(strategy =  GenerationType.IDENTITY)
	private Long cartItemId;
	
	// 상품 식별 번호
	@Column(nullable = false)
	private Long productId;
	
	// 장바구니 식별 번호
	@Column(nullable = false)
	private Long cartId;
	
	// 장바구니 상품 갯수 
	@Column(nullable = false)
	private Long quantity;
	
	// 장바구니 상품 선택 여부
	private Boolean selected;
}
