package com.example.demo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class CookingRecipeDTO {

	int choiceMenu;
	String title;
	String content;
	String r_code;
	String mid;
	String uuid;
	MultipartFile foodImg;
	String foodImgName;
	String foodImgBase64;
	List<Integer> ingredient;
	int ingredientSize;
	
	
	
	public int getChoiceMenu() {
		return choiceMenu;
	}
	public void setChoiceMenu(int choiceMenu) {
		this.choiceMenu = choiceMenu;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getR_code() {
		return r_code;
	}
	public void setR_code(String r_code) {
		this.r_code = r_code;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getUuid() {
		return uuid;
	}
	public void setUuid(String uuid) {
		this.uuid = uuid;
	}
	public MultipartFile getFoodImg() {
		return foodImg;
	}
	public void setFoodImg(MultipartFile foodImg) {
		this.foodImg = foodImg;
	}
	public String getFoodImgName() {
		return foodImgName;
	}
	public void setFoodImgName(String foodImgName) {
		this.foodImgName = foodImgName;
	}
	public String getFoodImgBase64() {
		return foodImgBase64;
	}
	public void setFoodImgBase64(String foodImgBase64) {
		this.foodImgBase64 = foodImgBase64;
	}
	public List<Integer> getIngredient() {
		return ingredient;
	}
	public void setIngredient(List<Integer> ingredient) {
		this.ingredient = ingredient;
	}
	public int getIngredientSize() {
		return ingredientSize;
	}
	public void setIngredientSize(int ingredientSize) {
		this.ingredientSize = ingredientSize;
	}
	
	
	
}
