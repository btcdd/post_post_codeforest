package com.compile.compiletest.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.compile.compiletest.service.UserService;
import com.compile.compiletest.vo.UserVo;
import com.compile.security.AuthUser;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;	
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public String join(@ModelAttribute UserVo vo) {
		return "user/join";
	}
	
	@RequestMapping(value="/join", method=RequestMethod.POST)
	public String join(@ModelAttribute @Valid UserVo vo,BindingResult result,Model model) {
		if(result.hasErrors()) {
			List<ObjectError> list = result.getAllErrors();
			for(ObjectError error : list) {
				System.out.println(error);
			}
			System.out.println("들어왔다!!");
			model.addAllAttributes(result.getModel());
			return "/user/join";
		}
		userService.join(vo);
		return "redirect:/";
	}
	
		
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public String login() {
		return "user/login";
	}

	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(@AuthUser UserVo authUser, UserVo vo) {
		return "redirect:/";
	}
	
	@RequestMapping(value="/join-check", method=RequestMethod.GET)
	public String joinCheck() {
		return "user/join-check";
	}

	
	
	@RequestMapping(value="/auth", method = RequestMethod.POST)
	public void auth() {	
		System.out.println("컨트롤러 auth");
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public void logout() {	
	}
	
}
