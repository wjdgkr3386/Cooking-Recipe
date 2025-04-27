package com.example.demo;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class CookingRecipeController {

	@Autowired
	CookingRecipeService cookingRecipeService;
	@Autowired
	CookingRecipeDAO cookingRecipeDAO;
	
	
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
	
	@RequestMapping(value="/writeInsertProc.do")
	public int writeInsertProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		if(mid==null) {
			return -11;
		}
		cookingRecipeDTO.setMid(mid);
		
		int cnt=0;
		try {
			cnt = cookingRecipeService.insertRecipe(cookingRecipeDTO);
		}catch(Exception e) {
			System.out.println(e);
		}
		return cnt;
	}
	
	
}
