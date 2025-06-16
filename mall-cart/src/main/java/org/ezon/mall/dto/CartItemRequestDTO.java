package org.ezon.mall.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CartItemRequestDTO {
	private Long userId;
	private Long productId;
	private Long quantity;
	private Boolean selected;
}
