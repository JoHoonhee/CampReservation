package com.camping.view;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.camping.biz.camp.CampService;
import com.camping.biz.camp.CampVO;
import com.camping.biz.img.CampImgService;
import com.camping.biz.img.CampImgVO;

@Controller
public class CampController {

	@Autowired
	private CampService service;
	
	@Autowired
	private CampImgService imgService;
	
	@RequestMapping(value="/insertCampJson.do")
	public String insertCampJson(CampVO vo) throws Exception {
		  
		StringBuilder urlBuilder = new StringBuilder("http://api.odcloud.kr/api/15037499/v1/uddi:1fe51f51-e956-425b-a9e3-e4555cb57880"); /*URL*/
		urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=공공데이터 인증키 넣는 곳"); /*Service Key*/
		urlBuilder.append("&" + URLEncoder.encode("returnType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*JSON DATA*/
		urlBuilder.append("&" + URLEncoder.encode("page","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	    urlBuilder.append("&" + URLEncoder.encode("perPage","UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /*한 페이지 당 데이터 수*/
	    URL url = new URL(urlBuilder.toString());
	    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	    conn.setRequestMethod("GET");
	    conn.setRequestProperty("Content-type", "application/json");
	    
	    System.out.println("Response code: " + conn.getResponseCode());
	    
	    BufferedReader rd;
	    if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	    	rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	    } else {
	        rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	    }
	    StringBuilder sb = new StringBuilder();
	    String line;
	    while ((line = rd.readLine()) != null) {
	        sb.append(line);
	    }
	    rd.close();
	    conn.disconnect();
	   
	    System.out.println(sb);

	    try {
	    	JSONParser jsonParser = new JSONParser();
	        JSONObject jsonObject = (JSONObject) jsonParser.parse(sb.toString());
	        JSONArray data = (JSONArray) jsonObject.get("data");
	        for(int i=0; i< data.size(); i++){
	        	System.out.println("=data_"+i+" ===========================================");
	            JSONObject object = (JSONObject) data.get(i);
	            System.out.println("Info: 캠핑(야영)장명==>"+object.get("캠핑(야영)장명"));
	            vo.setCamp_name((String) object.get("캠핑(야영)장명"));
	            service.insertCampSub(vo);
	        } 

	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
	    return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="/formCamp.do")
	public String formCamp() {
		return "/camp/management/formCamp.jsp";
	}
	
	@RequestMapping(value="/insertCamp.do")
	public void insertCamp(CampVO vo, HttpServletResponse response) throws IOException {
		service.insertCamp(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	@RequestMapping(value="/deleteCamp.do")
	public void deleteCamp(CampVO vo, HttpServletResponse response) throws IOException {
		service.deleteCamp(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	@RequestMapping(value="/updateCamp.do")
	public void updateCamp(CampVO vo, HttpServletResponse response) throws IOException {
		service.updateCamp(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	@RequestMapping(value="/getManageCamp.do")
	public String getCamp(CampVO vo, CampImgVO ivo, Model model) {
		model.addAttribute("imgList", imgService.getCampImgList(ivo));
		model.addAttribute("vo", service.getCamp(vo));
		return "/camp/management/getManageCamp.jsp";
	}
	
	@RequestMapping(value="/getManageCampList.do")
	public String manageCampList(CampVO vo, Model model) {
		if (vo.getSearchCondition() == null) {
			vo.setSearchCondition("camp_name");
		}
		if (vo.getSearchKeyword() == null) {
			vo.setSearchKeyword("");
		}
		
		if (vo.getStart_idx() == 0) {
			vo.setStart_idx(1);
		} else {
			vo.setStart_idx(vo.getStart_idx());
		}
		vo.setEnd_idx(vo.getStart_idx() + 9);
		
		int totalCount = service.totalCount(vo);
		int pageSize = 10;
		int pageListSize = 10;
		int totalPage = (int) Math.ceil((double) totalCount / pageSize);
		int nowPage = vo.getStart_idx() / pageSize + 1;
		int endPage = (totalPage - 1) * pageSize + 1;
		int listStartPage = (nowPage - 1) / pageListSize * pageListSize + 1;
		int listEndPage = listStartPage + pageListSize - 1;
		
		model.addAttribute("start_idx", vo.getStart_idx());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("totalPage", totalPage);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("listStartPage", listStartPage);
		model.addAttribute("listEndPage", listEndPage);
		
		model.addAttribute("searchCondition", vo.getSearchCondition());
		model.addAttribute("searchKeyword", vo.getSearchKeyword());
		model.addAttribute("li", service.getCampList(vo));
		return "/camp/management/getManageCampList.jsp";
	}
	
}
