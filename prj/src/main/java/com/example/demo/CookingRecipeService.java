package com.example.demo;

public interface CookingRecipeService {

	int insertRecipe(CookingRecipeDTO cookingRecipeDTO) throws Exception;
	
	int tempSave(CookingRecipeDTO cookingRecipeDTO) throws Exception;
}
