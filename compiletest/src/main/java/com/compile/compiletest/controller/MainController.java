package com.compile.compiletest.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.compile.security.Auth;

@Controller
public class MainController {
	
	@RequestMapping({"", "/main"})
	public String index(Model model) {
		return "main-out";
	}
	
	@Auth
	@RequestMapping("/main-in")
	public String indexA(Model model) {
		return "main";
	}
}