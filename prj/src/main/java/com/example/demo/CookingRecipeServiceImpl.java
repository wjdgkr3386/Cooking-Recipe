package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Transactional
@Service
public class CookingRecipeServiceImpl implements CookingRecipeService {

	@Autowired
	CookingRecipeDAO cookingRecipeDAO;
	
	public int insertRecipe(CookingRecipeDTO cookingRecipeDTO) {
		int cnt=0;
		if(cookingRecipeDAO.insertRecipe(cookingRecipeDTO)>0) {
			if(cookingRecipeDAO.insertRecipe_content(cookingRecipeDTO)>0) {
				//DTO에서 이미지를 꺼내서 이름을 저장, 확장자 체크, 이미지를 Base64로 변환 및 저장
				Util.file_nameInput(cookingRecipeDTO);
				
				if(Util.extensionCheck(cookingRecipeDTO.getFoodImgName())==-18) {
					throw new RuntimeException("-18"); 
				}
				
				cnt = Util.convertImgToBase64(cookingRecipeDTO);
				if(cnt== -20) { throw new RuntimeException("-20"); }
				
				cnt = cookingRecipeDAO.insertImg(cookingRecipeDTO);
			}
		}
		return cnt;
	}
	
	public int tempSave(CookingRecipeDTO cookingRecipeDTO) {
		cookingRecipeDAO.deleteTemp_recipe_content(cookingRecipeDTO);
		cookingRecipeDAO.deleteTemp_recipe_img(cookingRecipeDTO);
		cookingRecipeDAO.deleteTemp_recipe(cookingRecipeDTO);
		
		if(cookingRecipeDAO.insertTemp_recipe(cookingRecipeDTO)>0) {
			if(cookingRecipeDAO.insertTemp_recipe_content(cookingRecipeDTO)>0) {
				Util.file_nameInput(cookingRecipeDTO);
				MultipartFile img = cookingRecipeDTO.getFoodImg();
				if(img != null && !img.isEmpty()) {
					if(Util.extensionCheck(cookingRecipeDTO.getFoodImgName())==-18) {
						System.out.println(3);
						throw new RuntimeException("-18");
					}
					Util.convertImgToBase64(cookingRecipeDTO);
					cookingRecipeDAO.insertTemp_recipe_img(cookingRecipeDTO);
				}
			}
		}
		
		return 1;
	}
}
