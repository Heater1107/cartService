package org.ezon.msa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("contentPage", "pages/buyer/test-productList.jsp");
        return "buyer_layout";
    }
    
}
