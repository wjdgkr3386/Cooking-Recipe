package com.example.demo;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface NoticeDAO {

	int insertNotice(NoticeDTO noticeDTO);

	List<Map<String, Object>> getNotice(NoticeDTO noticeDTO);
	
	Map<String, Object> getNoticePost(int id);
	
	int getNoticeCnt();
}
