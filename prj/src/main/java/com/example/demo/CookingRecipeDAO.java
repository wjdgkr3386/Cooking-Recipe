package com.example.demo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CookingRecipeDAO {

	int insertRecipe(CookingRecipeDTO cookingRecipeDTO);
	int insertRecipe_content(CookingRecipeDTO cookingRecipeDTO);
	int insertImg(CookingRecipeDTO cookingRecipeDTO);
	int insertRecipe_ingredient(CookingRecipeDTO cookingRecipeDTO);
	
	int deleteRecipe_ingredient(CookingRecipeDTO cookingRecipeDTO);
	int deleteRecipe_content(CookingRecipeDTO cookingRecipeDTO);
	int deleteRecipe_img(CookingRecipeDTO cookingRecipeDTO);
	int deleteRecipe(CookingRecipeDTO cookingRecipeDTO);

	int updateTitle(CookingRecipeDTO cookingRecipeDTO);
	int updateContent(CookingRecipeDTO cookingRecipeDTO);
	int updateImg(CookingRecipeDTO cookingRecipeDTO);
	
	List<Map<String,Object>> getRecipeAll();
	List<Map<String,Object>> getTempRecipe(String mid);
	Map<String,Object> getPost(String r_code);
	List<Map<String,Object>> getIngredient(String mid);
	
	int deleteTemp_recipe_ingredient(CookingRecipeDTO cookingRecipeDTO);
	int deleteTemp_recipe(CookingRecipeDTO cookingRecipeDTO);
	int deleteTemp_recipe_content(CookingRecipeDTO cookingRecipeDTO);
	
	int insertTemp_recipe(CookingRecipeDTO cookingRecipeDTO);
	int insertTemp_recipe_content(CookingRecipeDTO cookingRecipeDTO);

	int checkHeart(Map<String,Object> map);
	int deleteHeart(Map<String,Object> map);
	int insertHeart(Map<String,Object> map);
	
	int checkJjim(Map<String, Object> map);
	int deleteJjim(Map<String,Object> map);
	int insertJjim(Map<String,Object> map);

	List<Map<String,Object>> getJjim(String mid);
	List<Map<String,Object>> search(CookingRecipeDTO cookingRecipeDTO);
	List<Map<String,Object>> getMyPost(String mid);
	
}
