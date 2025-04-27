package com.example.demo;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

	int checkUuid(LoginDTO loginDTO);
	
	int checkMid(LoginDTO loginDTO);
	
	int insertUserInfo(LoginDTO loginDTO);
	
	int login(LoginDTO loginDTO);
}
