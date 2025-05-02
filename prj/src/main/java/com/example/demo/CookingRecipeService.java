package com.example.demo;

public interface CookingRecipeService {

	int insertRecipe(CookingRecipeDTO cookingRecipeDTO) throws Exception;
	
	int tempSave(CookingRecipeDTO cookingRecipeDTO) throws Exception;
	
	int deleteTemp(CookingRecipeDTO cookingRecipeDTO) throws Exception;
	
	int deletePost(CookingRecipeDTO cookingRecipeDTO) throws Exception;
	
	int updatePost(CookingRecipeDTO cookingRecipeDTO) throws Exception;
	
}
