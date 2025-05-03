package com.example.demo;

import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class CookingRecipeController {

	@Autowired
	CookingRecipeService cookingRecipeService;
	@Autowired
	CookingRecipeDAO cookingRecipeDAO;

	@RequestMapping(value = "/cookingRecipe.do")
	public ModelAndView cookingRecipe(
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> recipeList = cookingRecipeDAO.getRecipeAll();

		for(Map<String, Object> map : recipeList) {
			Clob clobImg = (Clob) map.get("FOODIMG");
			String foodImg="";
			try {
				if(clobImg!=null) {
					foodImg = Util.convertClobToString(clobImg);
					if(foodImg==null) {
						foodImg="";
					}
				}
			}catch(Exception e) {
				System.out.println(e);
			}
			map.put("FOODIMG", foodImg);
		}
		
		mav.addObject("recipeList", recipeList);
		mav.addObject("recipeListSize", recipeList.size());
		mav.addObject("mid", mid);
		mav.setViewName("main.jsp");
		return mav;
	}

	@RequestMapping(value = "/search.do")
	public ModelAndView search(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		ModelAndView mav = new ModelAndView();
		List<Map<String,Object>> recipeList = cookingRecipeDAO.search(cookingRecipeDTO);
		
		for(Map<String, Object> map : recipeList) {
			Clob clobImg = (Clob) map.get("FOODIMG");
			String foodImg="";
			try {
				if(clobImg!=null) {
					foodImg = Util.convertClobToString(clobImg);
					if(foodImg==null) {
						foodImg="";
					}
				}
			}catch(Exception e) {
				System.out.println(e);
			}
			map.put("FOODIMG", foodImg);
		}
		
		mav.addObject("recipeList", recipeList);
		mav.addObject("recipeListSize", recipeList.size());
		mav.setViewName("main.jsp");
		return mav;
	}
	
	@RequestMapping(value = "/write.do")
	public ModelAndView write(
	) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("write.jsp");
		return mav;
	}

	@RequestMapping(value = "/loadWrite.do")
	public ModelAndView updateWrite(
		@RequestParam(value = "content", required = false) String content,
		@RequestParam(value = "foodImgBase64", required = false) String foodImgBase64,
		@RequestParam(value = "r_code", required = false) String r_code,
		@RequestParam(value = "title", required = false) String title,
		@RequestParam(value = "uuid", required = false) String uuid
	) {
		ModelAndView mav = new ModelAndView();

		mav.addObject("content", content);
		mav.addObject("foodImgBase64", foodImgBase64);
		mav.addObject("r_code", r_code);
		mav.addObject("title", title);
		mav.addObject("uuid", uuid);
		mav.setViewName("write.jsp");
		return mav;
	}

	@RequestMapping(value = "/writeInsertProc.do")
	public int writeInsertProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		if (mid == null) {
			return -11;
		}
		cookingRecipeDTO.setMid(mid);

		int cnt = 0;
		try {
			cnt = cookingRecipeService.insertRecipe(cookingRecipeDTO);
		} catch (RuntimeException r) {
			cnt = Integer.parseInt(r.getMessage());
		} catch (Exception e) {
			System.out.println(e);
		}

		return cnt;
	}

	@RequestMapping(value = "/writeTemporarySaveProc.do")
	public int writeTemporarySaveProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		if (mid == null) {
			return -11;
		}
		cookingRecipeDTO.setMid(mid);

		int cnt = 0;
		try {
			cnt = cookingRecipeService.tempSave(cookingRecipeDTO);
		} catch (Exception e) {
			System.out.println(e);
		}
		return cnt;
	}

	@RequestMapping(value = "/write/saved.do")
	public ModelAndView saved(
			HttpSession session,
			CookingRecipeDTO cookingRecipeDTO
	) {
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
		if (mid == null) {
			mav.setViewName("redirect:/login.do");
			return mav;
		}

		List<Map<String, Object>> tempRecipe = cookingRecipeDAO.getTempRecipe(mid);
		for(Map<String,Object> map: tempRecipe) {
			
			Clob clobContent = (Clob) map.get("CONTENT");
			
			String content="";
			
			try {
				if(clobContent!=null) {
					content = Util.convertClobToString(clobContent);
					if(content==null) {
						content="";
					}
				}
			}catch(Exception e) {
				System.out.println(e);
			}

			map.put("CONTENT", content);
		}

		mav.addObject("tempRecipe", tempRecipe);
		mav.setViewName("saved.jsp");
		return mav;
	}

	@RequestMapping(value = "/tempDeleteProc.do")
	public int tempDeleteProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		if (mid == null) {
			return -11;
		}

		int cnt = 0;
		try {
			cnt = cookingRecipeService.deleteTemp(cookingRecipeDTO);
		} catch (Exception e) {
			System.out.println(e);
		}

		return cnt;
	}
	
	@RequestMapping("/post/{r_code}")
	public ModelAndView post(
			@PathVariable("r_code") String r_code,
			HttpSession session
	) {
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
		Map<String,Object> postMap = cookingRecipeDAO.getPost(r_code);
		List<Map<String,Object>> postIngredientMap = cookingRecipeDAO.getIngredient(r_code);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("mid", mid);
		map.put("r_code", r_code);
		int heartCnt = cookingRecipeDAO.checkHeart(map);
		int jjimCnt = cookingRecipeDAO.checkJjim(map);
		try {
			String content = Util.convertClobToString((Clob) postMap.get("CONTENT"));
			String foodImg = Util.convertClobToString((Clob) postMap.get("FOODIMG"));
			postMap.put("CONTENT", content);
			postMap.put("FOODIMG", foodImg);
		}catch(Exception e) {
			System.out.println(e);
		}
		mav.addObject("mid", mid);
		mav.addObject("heartCnt", heartCnt);
		mav.addObject("jjimCnt", jjimCnt);
		mav.addObject("postMap", postMap);
		mav.addObject("postIngredientMap", postIngredientMap);
		mav.addObject("postIngredientMapSize", postIngredientMap.size());
		mav.setViewName("post.jsp");
		return mav;
	}
	
	@RequestMapping("/post/{r_code}/modify")
	public ModelAndView modify(
			@PathVariable("r_code") String r_code,
			HttpSession session
	) {
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
		Map<String,Object> postMap = cookingRecipeDAO.getPost(r_code);
		List<Map<String,Object>> postIngredientMap = cookingRecipeDAO.getIngredient(r_code);
		List<String> ingredientList = new ArrayList<String>();
		for(Map<String,Object> map : postIngredientMap) {
			ingredientList.add((String)map.get("INGREDIENT"));
		}
		try {
			String content = Util.convertClobToString((Clob) postMap.get("CONTENT"));
			String foodImg = Util.convertClobToString((Clob) postMap.get("FOODIMG"));
			postMap.put("CONTENT", content);
			postMap.put("FOODIMG", foodImg);
		}catch(Exception e) {
			System.out.println(e);
		}
		mav.addObject("mid", mid);
		mav.addObject("postMap", postMap);
		mav.addObject("ingredientList", ingredientList);
		mav.addObject("ingredientListSize", ingredientList.size());
		mav.setViewName("modify.jsp");
		return mav;
	}

	@RequestMapping(value = "/deletePostProc.do")
	public int deletePostProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		if (mid == null) {
			return -11;
		}

		int cnt = 0;
		try {
			cnt = cookingRecipeService.deletePost(cookingRecipeDTO);
		} catch (RuntimeException r) {
			cnt = Integer.parseInt(r.getMessage());
		} catch (Exception e) {
			System.out.println(e);
		}

		return cnt;
	}

	@RequestMapping(value = "/writeUpdateProc.do")
	public int writeUpdateProc(
		CookingRecipeDTO cookingRecipeDTO,
		HttpSession session
	) {
		String mid = (String) session.getAttribute("mid");
		if (mid == null) {
			return -11;
		}

		int cnt = 0;
		try {
			cnt = cookingRecipeService.updatePost(cookingRecipeDTO);
		} catch (RuntimeException r) {
			cnt = Integer.parseInt(r.getMessage());
		} catch (Exception e) {
			System.out.println(e);
		}
		return cnt;
	}

	@RequestMapping(value = "/changeHeart.do")
	public Map<String,Object> changeHeart(
		HttpSession session,
		@RequestParam("r_code") String r_code
	) {
		Map<String,Object> response = new HashMap<String,Object>();
		String mid = (String) session.getAttribute("mid");
		if (mid == null) {
			response.put("cnt", -11);
			return response;
		}
		
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("mid", mid);
		map.put("r_code", r_code);
		
		int cnt = 0;
		try {
			cnt = cookingRecipeService.changeHeart(map);
		}catch (Exception e) {
			System.out.println(e);
		}
		response.put("cnt", cnt);
		
		return response;
	}

	@RequestMapping(value = "/jjim")
	public Map<String,Object> jjim(
		HttpSession session,
		@RequestParam("r_code") String r_code
	) {
		Map<String,Object> response = new HashMap<String,Object>();
		Map<String, Object> map = new HashMap<String,Object>();
		int cnt = 0;
		String mid = (String) session.getAttribute("mid");
		
		if (mid == null) {
			response.put("cnt", -11);
			return response;
		}
		
		map.put("mid", mid);
		map.put("r_code", r_code);
		
		try {
			cnt = cookingRecipeService.jjim(map);
		}catch (Exception e) {
			System.out.println(e);
		}
		response.put("cnt", cnt);
		return response;
	}

	@RequestMapping(value = "/jjimList")
	public ModelAndView jjimList(
		HttpSession session
	) {
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
		List<Map<String, Object>> recipeList = new ArrayList<Map<String,Object>>();
		try {
			recipeList = cookingRecipeDAO.getJjim(mid);
			for(Map<String,Object> map : recipeList) {
				map.put("FOODIMG", Util.convertClobToString((Clob) map.get("FOODIMG")));
			}
		}catch (Exception e) {
			System.out.println(e);
		}
		mav.addObject("recipeList", recipeList);
		mav.addObject("recipeListSize", recipeList.size());
		mav.setViewName("main.jsp");
		return mav;
	}

	@RequestMapping(value = "/myPage.do")
	public ModelAndView myPage(
		HttpSession session
	) {
		ModelAndView mav = new ModelAndView();
		String mid = (String) session.getAttribute("mid");
		List<Map<String, Object>> recipeList = new ArrayList<Map<String,Object>>();
		try {
			recipeList = cookingRecipeDAO.getMyPost(mid);
			for(Map<String,Object> map : recipeList) {
				map.put("FOODIMG", Util.convertClobToString((Clob) map.get("FOODIMG")));
			}
		}catch (Exception e) {
			System.out.println(e);
		}
		mav.addObject("recipeList", recipeList);
		mav.addObject("recipeListSize", recipeList.size());
		mav.setViewName("myPage.jsp");
		return mav;
	}
	
	
}
