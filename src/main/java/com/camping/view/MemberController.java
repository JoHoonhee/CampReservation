package com.camping.view;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.camping.biz.member.BCrypt;
import com.camping.biz.member.MemberService;
import com.camping.biz.member.MemberVO;

@Controller
@SessionAttributes({"login_check", "login_id", "login_name", "login_role"})
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@RequestMapping(value="/formMember.do")
	public String formMember() {
		return "/camp/member/formMember.jsp";
	}
	
	@RequestMapping(value="/insertMember.do")
	public String insertMember(MemberVO vo) {
		String bcrypt = BCrypt.hashpw(vo.getPassword(), BCrypt.gensalt()); // 평문을 암호화
		vo.setBcrypt(bcrypt);
		service.insertMember(vo);
		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="/idCheck.do")
	public void idCheck(MemberVO vo, HttpServletResponse response) throws IOException {
		MemberVO check = service.getMember(vo);
		int num = 0;
		if (check == null) {
			num = 0;  // 아이디 사용가능
		} else {
			num = 1;  // 중복 아이디 존재
		}
		PrintWriter out = response.getWriter();
		out.println(num);
	}
	
	@RequestMapping(value="/deleteMemberAdmin.do")
	public void deleteMemberAdmin(MemberVO vo,  HttpServletResponse response) throws IOException {
		service.deleteMember(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	@RequestMapping(value="/deleteMember.do")
	public void deleteMember(MemberVO vo,  HttpServletResponse response, SessionStatus session) throws IOException {
		service.deleteMember(vo);
		session.setComplete();
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	// 관리자가 ROLE 변경
	@RequestMapping(value="/updateMemberAuthority.do")
	public void updateMemberAuthority(MemberVO vo,  HttpServletResponse response) throws IOException {
		vo.getRole();
		service.updateMemberAuthority(vo);
		PrintWriter out = response.getWriter();
		out.println("success");
	}
	
	// 회원이 정보 변경
	@RequestMapping(value="/updateMember.do")
	public String updateMember(MemberVO vo) {
		String bcrypt = BCrypt.hashpw(vo.getPassword(), BCrypt.gensalt()); // 평문을 암호화
		vo.setBcrypt(bcrypt); // 비밀번호 변경 시 암호화 변경
		service.updateMember(vo);
		return "redirect:/index.jsp";
	}
	
	@RequestMapping(value="/getMember.do")
	public String getMember(MemberVO vo, Model model) {
		model.addAttribute("vo", service.getMember(vo));
		return "/camp/member/getMember.jsp";
	}
	
	@RequestMapping(value="/getMemberList.do")
	public String getMemberList(MemberVO vo, Model model) {
		if (vo.getSearchCondition() == null) {
			vo.setSearchCondition("id");
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
		model.addAttribute("li", service.getMemberList(vo));
		return "/camp/member/getMemberList.jsp";
	}
	
	@RequestMapping(value="/login.do")
	public String login(MemberVO vo, Model model) {
		MemberVO m = service.getMember(vo);
		if (m == null) {
			model.addAttribute("login_check", "F");
			return "redirect:/index.jsp";
		} else {
			if (BCrypt.checkpw(vo.getPassword(), m.getBcrypt())) {
				model.addAttribute("login_check", "S");
				model.addAttribute("login_id", m.getId());
				model.addAttribute("login_name", m.getName());
				model.addAttribute("login_role", m.getRole());
				return "redirect:/index.jsp";
			} else {
				model.addAttribute("login_check", "F");
				return "redirect:/index.jsp";
			}
		}
	}
	
	@RequestMapping(value="/logout.do")
	public String logout(SessionStatus session) {
		session.setComplete();
		return "redirect:/index.jsp";
	}
	
}
