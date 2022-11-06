package com.camping.view;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.camping.biz.camp.CampService;
import com.camping.biz.camp.CampVO;
import com.camping.biz.img.CampImgService;
import com.camping.biz.img.CampImgVO;
import com.camping.biz.reservation.CampReserveService;
import com.camping.biz.reservation.CampReserveVO;

@Controller
public class ReservationController {
	
	@Autowired
	private CampService service;
	
	@Autowired
	private CampReserveService reserveService;
	
	@Autowired
	private CampImgService imgService;

	@RequestMapping(value="/getReserveCampList.do")
	public String getCampList(CampVO vo, Model model) {
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
		return "/camp/reservation/getReserveCampList.jsp";
	}
	
	@RequestMapping(value="/getReserveCamp.do")
	public String getReserveCamp(CampVO vo, CampImgVO ivo, CampReserveVO rvo, Model model) {
		List<CampImgVO> li = imgService.getCampImgList(ivo);
		if (li.size() == 0) {
			ivo.setUpload_imgStr("no_image.png");
			li.add(ivo);
		}
		model.addAttribute("imgList", li);
		model.addAttribute("vo", service.getCamp(vo));
		model.addAttribute("review", reserveService.getReviewList(rvo));
		// 지도 API APP KEY
		model.addAttribute("KEY", "카카오 지도 script key를 넣는 곳");
		return "/camp/reservation/getReserveCamp.jsp";
	}
	
	@RequestMapping(value="/insertCampReservation.do")
	public String insertCampReservation(CampReserveVO vo) {
		reserveService.insertCampReservation(vo);
		return "redirect:/getReserveCampList.do";
	}
	
	@RequestMapping(value="/getReserveCheckList.do")
	public String getReserveCheckList(CampReserveVO vo, Model model) {
		if (vo.getStart_idx() == 0) {
			vo.setStart_idx(1);
		} else {
			vo.setStart_idx(vo.getStart_idx());
		}
		vo.setEnd_idx(vo.getStart_idx() + 9);
		
		int totalCount = reserveService.totalCount(vo);
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
		
		Date today = new Date();
		model.addAttribute("today", today);
		model.addAttribute("li", reserveService.getReserveCheckList(vo));
		return "/camp/reservation/getReserveCheckList.jsp";
	}
	
	@RequestMapping(value="/getReserveCheck.do")
	public String getReserveCheck(CampReserveVO vo, Model model) {
		model.addAttribute("vo", reserveService.getReserveCheck(vo));
		return "/camp/reservation/getReserveCheck.jsp";
	}
	
	@RequestMapping(value="/deleteCampReservation.do")
	public void deleteCampReservation(CampReserveVO vo, HttpServletResponse response) throws IOException {
		reserveService.deleteCampReservation(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	@RequestMapping(value="/insertReview.do")
	public String insertReview(CampReserveVO vo) {
		vo.setWrite_review("Y");
		reserveService.updateWriteReview(vo);
		reserveService.insertReview(vo);
		return "redirect:/index.jsp";
	}
	
}
