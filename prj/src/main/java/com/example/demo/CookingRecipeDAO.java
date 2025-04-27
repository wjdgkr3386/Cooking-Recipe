package com.example.demo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CookingRecipeDAO {

	int insertRecipe(CookingRecipeDTO cookingRecipeDTO);
	
	int insertRecipe_content(CookingRecipeDTO cookingRecipeDTO);
	
	List<Map<String,Object>> getRecipe();
}
