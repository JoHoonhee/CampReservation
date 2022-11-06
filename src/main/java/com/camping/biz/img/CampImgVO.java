package com.camping.biz.img;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CampImgVO {
	private int idx_img;
	private String camp_name;
	private MultipartFile upload_img;  // 사진 업로드 파일
	private String upload_imgStr;      // 업로드 사진의 이름
}
