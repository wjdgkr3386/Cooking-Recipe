package com.example.demo;

import static org.assertj.core.api.Assertions.entry;

import java.io.FileOutputStream;
import java.io.Reader;
import java.io.StringWriter;
import java.sql.Clob;
import java.util.Arrays;
import java.util.Base64;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public class Util {
	
    //검색 페이지 제어
    public static void searchUtil(int searchResultCount, NoticeDTO noticeDTO){
        if(searchResultCount==0) {
            return;
        }
        
        try {
            int rowCnt = 10; //한 페이지 안에 행의 개수
            int selectPageNo = 0; //선택한 페이지 번호
            int begin_rowNo = 0; //시작할 행의 번호
            int end_rowNo = 0;     //끝날 행의 번호
            
            int last_pageNo = 0; //마지막 페이지 번호
            int remainder = 0;   //last_pageNo를 구하기 위한 변수
            int pageNoCntPerPage= 10; //한번에 보여줄 페이지의 갯수
            
            last_pageNo = searchResultCount/rowCnt;
            remainder = searchResultCount%rowCnt;
            if(remainder>0) {
                last_pageNo++;
            }
            
            selectPageNo = noticeDTO.getSelectPageNo();
            if(selectPageNo<=0) {
                selectPageNo=1;
            }
            
            begin_rowNo = ((selectPageNo-1)*rowCnt)+1;
            end_rowNo = selectPageNo*rowCnt;
            if( end_rowNo>searchResultCount ) {
                end_rowNo = searchResultCount;
            }
            
            int begin_pageNo = selectPageNo-(pageNoCntPerPage/2);
            if(begin_pageNo<1) {
                begin_pageNo = 1;
            }

            int end_pageNo = begin_pageNo + pageNoCntPerPage - 1;
            if(end_pageNo>last_pageNo) {
                end_pageNo=last_pageNo;
            }
            
            if(selectPageNo+(pageNoCntPerPage/2)>last_pageNo) {
                begin_pageNo = begin_pageNo - (selectPageNo+(pageNoCntPerPage/2)-last_pageNo)+1;
                if(begin_pageNo<1) {
                    begin_pageNo = 1;
                }
            }

            noticeDTO.setLast_pageNo(last_pageNo);
            noticeDTO.setRowCnt(rowCnt);
            noticeDTO.setSelectPageNo(selectPageNo);
            noticeDTO.setBegin_pageNo(begin_pageNo);
            noticeDTO.setEnd_pageNo(end_pageNo);
            noticeDTO.setBegin_rowNo(begin_rowNo);
            noticeDTO.setEnd_rowNo(end_rowNo);
        }catch(Exception e) {
            System.out.println(e);
        }
    }
	
	//맵을 받아서 안에 있는 내용 중에 < , > , <br> 을 html에서 사용할 수 있게 변환하여 저장하고 반환
	public static Map<String, Object> convertAngleBracketsMap(Map<String, Object> convertMap, String keyword){
		if(keyword.equals("<br>")) {
	        for (Map.Entry<String, Object> entry : convertMap.entrySet()) {
	            Object value = entry.getValue();
	            if (value != null) {
	                String sanitizedValue = value.toString()
	                    .replaceAll("<", "&lt;")
	                    .replaceAll(">", "&gt;")
	                    .replaceAll("\n", "<br>");
	                entry.setValue(sanitizedValue);
	            }
	        }
		}else if(keyword.equals("\n")) {
	        for (Map.Entry<String, Object> entry : convertMap.entrySet()) {
	            Object value = entry.getValue();
	            if (value != null) {
	                String sanitizedValue = value.toString()
	                    .replaceAll("<", "&lt;")
	                    .replaceAll(">", "&gt;")
	                    .replaceAll("<br>", "\n");
	                entry.setValue(sanitizedValue);
	            }
	        }
		}
		return convertMap;
	}
	
	
	//파일 불러와 파일이름을 DTO에 저장
	public static void file_nameInput( CookingRecipeDTO cookingRecipeDTO ) {
		MultipartFile img = cookingRecipeDTO.getFoodImg();
		String img_name;
		if( img != null && !img.isEmpty() ) {
			String originalfileName = img.getOriginalFilename();
			img_name = originalfileName;
			cookingRecipeDTO.setFoodImgName(img_name);
		}
	}

	//확장자 확인 메서드
	public static int extensionCheck( String originalFileName) {

		String[] allowedExtensions = {"jpg", "jpeg", "jfif", "png"};
		String extension = "";

        //확장자 확인
        if (originalFileName != null && originalFileName.lastIndexOf(".") != -1) {
        	extension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
        }
        //지정한 확장자가 아닐경우 -18 리턴
		boolean checkExtension = Arrays.asList(allowedExtensions).contains(extension.toLowerCase());
        if(!checkExtension) {
        	return -18;
        }
		return 1;
	}

	public static int convertImgToBase64(CookingRecipeDTO cookingRecipeDTO) {
		MultipartFile foodImg = cookingRecipeDTO.getFoodImg();
		int cnt=1;
		if (foodImg != null && !foodImg.isEmpty()) {
			try {
				byte[] bytes = foodImg.getBytes();
				String base64String = Base64.getEncoder().encodeToString(bytes);
				cookingRecipeDTO.setFoodImgBase64(base64String);
			}catch(Exception e) {
				System.out.println(e);
				cnt = -20;
			}
		}
		return cnt;
	}
	
    public static void saveBase64Image(String base64Data, String outputPath) throws Exception {
        // "data:image/png;base64,...” 같은 접두사 제거
        String[] parts = base64Data.split(",");
        String imageString = parts.length > 1 ? parts[1] : parts[0];

        byte[] imageBytes = Base64.getDecoder().decode(imageString);
        try (FileOutputStream fos = new FileOutputStream(outputPath)) {
            fos.write(imageBytes);
        }
    }
    
	
    // CLOB에서 String으로 변환하는 메소드
    public static String convertClobToString(Clob clob) throws Exception {
        if (clob == null) return null;
        Reader reader = clob.getCharacterStream();
        StringWriter writer = new StringWriter();
        char[] buffer = new char[1024];
        int length;
        while ((length = reader.read(buffer)) != -1) {
            writer.write(buffer, 0, length);
        }
        return writer.toString();
    }
}
