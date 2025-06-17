package org.ezon.msa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/buyer")
public class BuyerViewController {
	
	@GetMapping
	public String buyerMain(Model model) {
		model.addAttribute("contentPage", "pages/buyer/main.jsp");
		return "buyer_layout";
	}
	
	@GetMapping("/myPage")
	public String buyerMy(Model model) {
		model.addAttribute("contentPage", "pages/buyer/buyer_myPage_layout.jsp");
		model.addAttribute("subContentPage", "pages/buyer/buyer_myPage_main.jsp");
		return "buyer_layout";
	}

	// 장바구니 이동
	@GetMapping("/cart")
	public String cart(Model model) {
		model.addAttribute("contentPage", "pages/buyer/cart.jsp");
		return "buyer_layout";
	}
	
	// 찜 목록 이동
	@GetMapping("/wish")
	public String wish(Model model) {
		model.addAttribute("contentPage", "pages/buyer/buyer_myPage_layout.jsp");
		model.addAttribute("subContentPage", "pages/buyer/wish.jsp");
		return "buyer_layout";
	}
	// 아래는 테스트 이후 삭제
	// 테스트 상품목록
	@GetMapping("/productList")
	public String testProductList(Model model) {
		model.addAttribute("contentPage", "pages/buyer/test-productList.jsp");
		return "buyer_layout";
	}

	// 테스트 상품상세
	@GetMapping("/productDetail")
	public String testProductDetail(Model model) {
		model.addAttribute("contentPage", "pages/buyer/test-productDetail.jsp");
		return "buyer_layout";
	}

	// 테스트 판매자 정보
	@GetMapping("/sellerInfo")
	public String testSellerInfo(Model model) {
		model.addAttribute("contentPage", "pages/buyer/test-sellerInfo.jsp");
		return "buyer_layout";
	}
}
