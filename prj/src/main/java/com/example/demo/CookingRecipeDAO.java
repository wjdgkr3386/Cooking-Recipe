package com.example.demo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CookingRecipeDAO {

	int insertRecipe(CookingRecipeDTO cookingRecipeDTO);
	
	int insertRecipe_content(CookingRecipeDTO cookingRecipeDTO);
}
