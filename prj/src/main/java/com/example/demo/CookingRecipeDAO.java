package com.example.demo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CookingRecipeDAO {

	int insertRecipe(CookingRecipeDTO cookingRecipeDTO);
	int insertRecipe_content(CookingRecipeDTO cookingRecipeDTO);
	int insertImg(CookingRecipeDTO cookingRecipeDTO);

	List<Map<String,Object>> getRecipeAll();
	List<Map<String,Object>> getTempRecipe(String mid);
	Map<String,Object> getPost(String r_code);
	
	int deleteTemp_recipe(CookingRecipeDTO cookingRecipeDTO);
	int deleteTemp_recipe_content(CookingRecipeDTO cookingRecipeDTO);
	int deleteTemp_recipe_img(CookingRecipeDTO cookingRecipeDTO);
	
	int insertTemp_recipe(CookingRecipeDTO cookingRecipeDTO);
	int insertTemp_recipe_content(CookingRecipeDTO cookingRecipeDTO);
	int insertTemp_recipe_img(CookingRecipeDTO cookingRecipeDTO);
	
	
}
