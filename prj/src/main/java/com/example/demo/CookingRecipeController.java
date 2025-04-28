package com.example.demo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		List<Map<String,Object>> recipeList = cookingRecipeDAO.getRecipe();

		mav.addObject("recipeList", recipeList);
		mav.addObject("recipeListSize", recipeList.size());
		mav.addObject("mid", mid);
		mav.setViewName("main.jsp");
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
		}catch(RuntimeException r) {
			cnt = Integer.parseInt(r.getMessage());
		}catch(Exception e) {
			System.out.println(e);
		}
		return cnt;
	}
	
	@RequestMapping(value="/writeTemporarySaveProc.do")
	public int writeTemporarySaveProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		if(mid==null) {
			return -11;
		}
		cookingRecipeDTO.setMid(mid);

		int cnt = 0;
		try {
			cnt = cookingRecipeService.tempSave(cookingRecipeDTO);
		}catch(Exception e) {
			System.out.println(e);
		}
		return cnt;
	}
	
	@RequestMapping(value="/write/saved.do")
	public ModelAndView saved(
		HttpSession session
	){
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
	    if (mid == null) {
	        mav.setViewName("redirect:/login.do");
	        return mav;
	    }
		
	    List<Map<String,Object>> tempRecipe = cookingRecipeDAO.getTempRecipe(mid);
	    
	    mav.addObject("tempRecipe", tempRecipe);
		mav.setViewName("saved.jsp");
		return mav;
	}
	
	@RequestMapping(value="/tempDeleteProc.do")
	public int tempDeleteProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
	    if (mid == null) {
	        return -11;
	    }
	    
	    int cnt=0;
		try {
			cnt=cookingRecipeService.deleteTemp(cookingRecipeDTO);
		}catch(Exception e) {
			System.out.println(e);
		}
		
		return cnt;
	}
}
