package com.example.demo;

public class NoticeDTO {
	String title;
	String content;
	

	private int last_pageNo;		//마지막 페이지번호
	private int selectPageNo;		//선택한 페이지번호
	private int begin_pageNo;		//화면의 표시할 처음 페이지번호
	private int end_pageNo;			//화면의 표시할 마지막 페이지번호
	private int rowCnt;				//행보기
	private int begin_rowNo;		//테이블 검색 시 시작행 번호
	private int end_rowNo;			//테이블 검색 시 끝행 번호
	
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
	public int getLast_pageNo() {
		return last_pageNo;
	}
	public void setLast_pageNo(int last_pageNo) {
		this.last_pageNo = last_pageNo;
	}
	public int getSelectPageNo() {
		return selectPageNo;
	}
	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}
	public int getBegin_pageNo() {
		return begin_pageNo;
	}
	public void setBegin_pageNo(int begin_pageNo) {
		this.begin_pageNo = begin_pageNo;
	}
	public int getEnd_pageNo() {
		return end_pageNo;
	}
	public void setEnd_pageNo(int end_pageNo) {
		this.end_pageNo = end_pageNo;
	}
	public int getRowCnt() {
		return rowCnt;
	}
	public void setRowCnt(int rowCnt) {
		this.rowCnt = rowCnt;
	}
	public int getBegin_rowNo() {
		return begin_rowNo;
	}
	public void setBegin_rowNo(int begin_rowNo) {
		this.begin_rowNo = begin_rowNo;
	}
	public int getEnd_rowNo() {
		return end_rowNo;
	}
	public void setEnd_rowNo(int end_rowNo) {
		this.end_rowNo = end_rowNo;
	}
	
	
}
