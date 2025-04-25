package com.example.demo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class LoginController {

	@Autowired
	LoginService loginService;
	@Autowired
	LoginDAO loginDAO;
	
	@RequestMapping(value="/login.do")
	public ModelAndView login(
		HttpSession session
	) {
		//세션 삭제
		session.removeAttribute("mid");
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("login.jsp");
		return mav;
	}
	
	@RequestMapping(value="/loginProc.do")
	public int loginProc(
		HttpSession session,
		LoginDTO loginDTO
	) {
		int cnt = loginDAO.login(loginDTO);
		if(cnt==1) {
			session.setAttribute("mid", loginDTO.getMid());
		}
		return cnt;
	}
	
	@RequestMapping(value="/signUp.do")
	public ModelAndView signUp(
	) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("signUp.jsp");
		return mav;
	}
	
	@RequestMapping(value="/signUpProc.do")
	public int signUpProc(
		LoginDTO loginDTO
	) {
		int cnt = 0;
		
		//계정이 이미 있는지 체크
		if(loginDAO.checkMid(loginDTO)>0) {
			return -13;
		}
		
		try {
			cnt = loginService.insertUserInfo(loginDTO);
		}catch(Exception e) {
			System.out.println(e);
		}
		
		return cnt;
	}
	
	
}
