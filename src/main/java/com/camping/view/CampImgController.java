package com.camping.view;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.camping.biz.img.CampImgService;
import com.camping.biz.img.CampImgVO;

@Controller
public class CampImgController {

	private String path = "";
	private String timeStr = "";
	
	public CampImgController() {
		long time = System.currentTimeMillis();
		SimpleDateFormat daytime = new SimpleDateFormat("HHmmss");
		timeStr = daytime.format(time);
	}
	
	@Autowired
	private CampImgService service;
	
	@Autowired
	private HttpServletRequest request;
	
	@RequestMapping(value="/insertCampImg.do")
	public String insertCampImg(CampImgVO vo) throws IllegalStateException, IOException {
		path = request.getSession().getServletContext().getRealPath("/camp/management/files/");
		System.out.println("path: " + path);
		// 파일 업로드 처리
		MultipartFile getUpload_img = vo.getUpload_img();  // 실제 파일, 바이너리 값이 들어온다.
		String fileName = "";
		if (!getUpload_img.isEmpty()) {
			fileName = getUpload_img.getOriginalFilename();  // 넘어온 파일명
			File f = new File(path+fileName);
			if (f.exists()) {  // 중복 파일이 있으면 처리
				String onlyFileName = fileName.substring(0, fileName.lastIndexOf("."));
				String extension = fileName.substring(fileName.lastIndexOf("."));
				fileName = onlyFileName + "_" +timeStr + extension;
			} 
			getUpload_img.transferTo(new File(path + fileName));
		}
		
		vo.setUpload_imgStr(fileName);
		service.insertCampImg(vo);
		return "getManageCamp.do";
	}
	
	@RequestMapping(value="/deleteCampImg.do")
	public void deleteCampImg(CampImgVO vo, HttpServletResponse response) throws IOException {
		path = request.getSession().getServletContext().getRealPath("/camp/management/files/");
		
		vo = service.getCampImg(vo);
		String delFile = vo.getUpload_imgStr();
		File f = new File(path + delFile);
		if (f.exists() && !delFile.equals("no_image.png")) {
			f.delete();
		}
		
		service.deleteCampImg(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
}
