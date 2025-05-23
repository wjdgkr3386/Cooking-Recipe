package com.example.demo;

import java.sql.Clob;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
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
	@Autowired
	NoticeService noticeService;
	@Autowired
	NoticeDAO noticeDAO;
	
	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping(value = "/write.do")
	public ModelAndView write(
	) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("write.jsp");
		return mav;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping(value = "/jjimList")
	public ModelAndView jjimList(
		String viewName,
		HttpSession session,
		HttpServletResponse response
	) {
		ModelAndView mav = new ModelAndView();
		if(viewName==null) {
			try {
				response.sendRedirect("/error.do");
				return null;
			}catch(Exception e) {
				System.out.println(e);
				return null;
			}
		}
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
		mav.setViewName(viewName);
		return mav;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
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
		mav.addObject("mid", mid);
		mav.addObject("recipeList", recipeList);
		mav.addObject("recipeListSize", recipeList.size());
		mav.setViewName("myPage.jsp");
		return mav;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping(value = "/notice.do")
	public ModelAndView notice(
		HttpSession session,
		NoticeDTO noticeDTO
	) {
		String mid = (String) session.getAttribute("mid");
		ModelAndView mav = new ModelAndView();
		List<Map<String, Object>> searchList = new ArrayList<Map<String, Object>>();

		//검색 결과의 갯수
		int searchResultCount = noticeDAO.getNoticeCnt();
		int searchCount=0;
		if(searchResultCount!=0) {
		    Util.searchUtil(searchResultCount, noticeDTO);
		    searchList = noticeDAO.getNotice(noticeDTO);
		    searchCount = searchList.size();
		}
		mav.addObject("searchList", searchList);
		mav.addObject("searchCount", searchCount);
		mav.addObject("searchResultCount", searchResultCount);
		mav.addObject("last_pageNo", noticeDTO.getLast_pageNo());
		mav.addObject("selectPageNo", noticeDTO.getSelectPageNo());
		mav.addObject("begin_pageNo", noticeDTO.getBegin_pageNo());
		mav.addObject("end_pageNo", noticeDTO.getEnd_pageNo());
		mav.addObject("rowCnt", noticeDTO.getRowCnt());
		mav.addObject("begin_rowNo", noticeDTO.getBegin_rowNo());
		mav.addObject("end_rowNo", noticeDTO.getEnd_rowNo());
		
		mav.addObject("mid", mid);
		mav.setViewName("notice.jsp");
		return mav;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping(value = "/noticeWrite.do")
	public ModelAndView noticeWrite(
			HttpSession session,
			HttpServletResponse response
	) {
		String mid = (String)session.getAttribute("mid");
		if(!mid.equals("xyz")) {
			try {
				response.sendRedirect("/error.do");
				return null;
			}catch(Exception e) {
				System.out.println("관리자가 아닙니다.");
				return null;
			}
		}
		ModelAndView mav = new ModelAndView();
		mav.setViewName("noticeWrite.jsp");
		return mav;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping(value = "/noticeSaveProc.do")
	public int noticeSaveProc(
		NoticeDTO noticeDTO,
		HttpSession session,
		HttpServletResponse response
	) {
		String mid = (String) session.getAttribute("mid");
		if(!mid.equals("xyz")) {
			try {
				response.sendRedirect("/error.do");
				return 0;
			}catch(Exception e) {
				System.out.println("관리자가 아닙니다.");
				return 0;
			}
		}
		int cnt=0;
		try {
			cnt = noticeService.insertNotice(noticeDTO);
		}catch(Exception e) {
			System.out.println(e);
		}
		return cnt;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping("/notice/{id}")
	public ModelAndView noticePost(
			@PathVariable("id") int id,
			HttpSession session
	) {
		ModelAndView mav = new ModelAndView();
		Map<String, Object> noticeMap = noticeDAO.getNoticePost(id);
		noticeMap = Util.convertAngleBracketsMap(noticeMap, "<br>");
		mav.addObject("noticeMap", noticeMap);
		mav.setViewName("noticePost.jsp");
		return mav;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	@RequestMapping(value = "/error.do")
	public ModelAndView error(
	) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("error.jsp");
		return mav;
	}
}
