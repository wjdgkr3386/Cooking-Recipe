package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Transactional
@Service
public class CookingRecipeServiceImpl implements CookingRecipeService {

	@Autowired
	CookingRecipeDAO cookingRecipeDAO;
	
	public int insertRecipe(CookingRecipeDTO cookingRecipeDTO) {
		int cnt=0;
		if(cookingRecipeDAO.insertRecipe(cookingRecipeDTO)>0) {
			cnt = cookingRecipeDAO.insertRecipe_content(cookingRecipeDTO);
		}
		return cnt;
	}
	
}
