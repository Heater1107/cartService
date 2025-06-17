package org.ezon.msa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/seller")
public class SellerViewController {
	
	@GetMapping
	public String sellerMain(Model model) {
		model.addAttribute("contentPage", "pages/seller/main.jsp");
		return "seller_layout";
	}

}
