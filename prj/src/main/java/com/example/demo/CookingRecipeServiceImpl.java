package com.example.demo;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Transactional
@Service
public class CookingRecipeServiceImpl implements CookingRecipeService {

	@Autowired
	CookingRecipeDAO cookingRecipeDAO;

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int insertRecipe(CookingRecipeDTO cookingRecipeDTO) {
		cookingRecipeDAO.deleteTemp_recipe_ingredient(cookingRecipeDTO);
		cookingRecipeDAO.deleteTemp_recipe_content(cookingRecipeDTO);
		cookingRecipeDAO.deleteTemp_recipe(cookingRecipeDTO);
		cookingRecipeDAO.deleteRecipe_ingredient(cookingRecipeDTO);
		cookingRecipeDAO.deleteRecipe_content(cookingRecipeDTO);
		cookingRecipeDAO.deleteRecipe_img(cookingRecipeDTO);
		cookingRecipeDAO.deleteRecipe(cookingRecipeDTO);
		
		int cnt=0;
		if(cookingRecipeDAO.insertRecipe(cookingRecipeDTO)>0) {
			if(cookingRecipeDAO.insertRecipe_content(cookingRecipeDTO)>0) {
				if(cookingRecipeDAO.insertRecipe_ingredient(cookingRecipeDTO)>0) {
					cnt=1;
					//DTO에서 이미지를 꺼내서 이름을 저장, 확장자 체크, 이미지를 Base64로 변환 및 저장
					Util.file_nameInput(cookingRecipeDTO);
					MultipartFile img = cookingRecipeDTO.getFoodImg();
					if(img != null && !img.isEmpty()) {
						if(Util.extensionCheck(cookingRecipeDTO.getFoodImgName())==-18) {
							throw new RuntimeException("-18"); 
						}

						cnt = Util.convertImgToBase64(cookingRecipeDTO);
						if(cnt== -20) { throw new RuntimeException("-20"); }

						cnt = cookingRecipeDAO.insertImg(cookingRecipeDTO);
					}
				}
			}
		}
		return cnt;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int tempSave(CookingRecipeDTO cookingRecipeDTO) {
		cookingRecipeDAO.deleteTemp_recipe_content(cookingRecipeDTO);
		cookingRecipeDAO.deleteTemp_recipe(cookingRecipeDTO);
		
		int cnt=0;
		if(cookingRecipeDAO.insertTemp_recipe(cookingRecipeDTO)>0) {
			cnt = cookingRecipeDAO.insertTemp_recipe_content(cookingRecipeDTO);
		}
		return cnt;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int deleteTemp(CookingRecipeDTO cookingRecipeDTO) {
		int cnt=0;
		cookingRecipeDAO.deleteTemp_recipe_content(cookingRecipeDTO);
		cnt = cookingRecipeDAO.deleteTemp_recipe(cookingRecipeDTO);
		
		return cnt;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int deletePost(CookingRecipeDTO cookingRecipeDTO) {
		int cnt=0;
		if(cookingRecipeDAO.deleteRecipe_content(cookingRecipeDTO)>0) {
			if(cookingRecipeDAO.deleteRecipe_img(cookingRecipeDTO)>0){
				if(cookingRecipeDAO.deleteRecipe_ingredient(cookingRecipeDTO)>0) {
					cnt=cookingRecipeDAO.deleteRecipe(cookingRecipeDTO);
				}
			}
		}
		if(cnt==0) { throw new RuntimeException("0"); }
		return cnt;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int updatePost(CookingRecipeDTO cookingRecipeDTO) {
		cookingRecipeDAO.deleteRecipe_ingredient(cookingRecipeDTO);
		cookingRecipeDAO.updateTitle(cookingRecipeDTO);
		cookingRecipeDAO.updateContent(cookingRecipeDTO);
		if(cookingRecipeDAO.insertRecipe_ingredient(cookingRecipeDTO)<1) {
			throw new RuntimeException("0");
		}
		
		MultipartFile img = cookingRecipeDTO.getFoodImg();
		if(img != null && !img.isEmpty()) {
			cookingRecipeDAO.updateImg(cookingRecipeDTO);
		}
		
		return 1;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int changeHeart(Map<String,Object> map) {
		int cnt = 0;
		cnt = cookingRecipeDAO.checkHeart(map);
		if(cnt>0) {
			cookingRecipeDAO.deleteHeart(map);
		}else {
			cookingRecipeDAO.insertHeart(map);
		}
		return cnt;
	}

	//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
	public int jjim(Map<String, Object> map) {
		int cnt = 0;
		cnt = cookingRecipeDAO.checkJjim(map);
		if(cnt>0) {
			cookingRecipeDAO.deleteJjim(map);
		}else {
			cookingRecipeDAO.insertJjim(map);
		}
		return cnt;
	}
}
