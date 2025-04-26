package com.example.demo;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class cookingRecipeController {

	@RequestMapping(value="/cookingRecipe.do")
	public ModelAndView cookingRecipe(
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		
		mav.addObject("mid", mid);
		mav.setViewName("main.jsp");
		return mav;
	}
	
	@RequestMapping(value="/test.do")
	public ModelAndView test(
			
	) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("test.jsp");
		return mav;
	}
	
	@RequestMapping(value="/write.do")
	public ModelAndView write(
			
	) {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("write.jsp");
		return mav;
	}
	
	@RequestMapping(value="/writeProc.do")
	public int writeInsertProc(
		String content,
		String r_code
	) {
		
		System.out.println(content);
		
		
		return 0;
	}
	
	
}
