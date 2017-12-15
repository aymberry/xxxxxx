package com.xxxxxx.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.xxxxxx.service.LoginService;
import com.xxxxxx.util.StringUtil;

@Controller
public class LoginController {
	@Autowired
	public LoginService lService;
	
	@RequestMapping("/Login/LoginProc")
	public ModelAndView loginForm(){
		return new ModelAndView("Login/LoginForm");
	}
	@RequestMapping("/Login/LoginProc")
	public ModelAndView loginProc(HttpServletRequest req, HttpServletResponse resp, HttpSession session){
		String id= req.getParameter("ID");
		String pw= req.getParameter("PW");
		String auto= req.getParameter("AUTO");
		
		int result= lService.loginProc(id, pw);
		if(result==1){
			session.setAttribute("UID", id);
			if(!StringUtil.isNull(auto)){
				Cookie ck= new Cookie("AUTO", id+":"+pw);
				ck.setMaxAge(60*60*24*1000);
				resp.addCookie(ck);
			}
		}
		RedirectView rv= new RedirectView("../Login/LoginForm.time");
		ModelAndView mv= new ModelAndView();
		mv.setView(rv);
		return mv;
	}
	@RequestMapping("Login/Logout")
	public ModelAndView logout(HttpSession session, RedirectView rv, ModelAndView mv){
		session.removeAttribute("UID");
		rv.setUrl("../Login/LoginForm.time");
		mv.setView(rv);
		return mv;
	}
}
