package com.example.demo;

import java.io.FileOutputStream;
import java.io.Reader;
import java.io.StringWriter;
import java.sql.Clob;
import java.util.Arrays;
import java.util.Base64;

import org.springframework.web.multipart.MultipartFile;

public class Util {

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
