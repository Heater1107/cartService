package org.ezon.msa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminViewController {
	
	@GetMapping
	public String adminMain(Model model) {
		model.addAttribute("contentPage", "pages/admin/main.jsp");
		return "admin_layout";
	}
	
}
