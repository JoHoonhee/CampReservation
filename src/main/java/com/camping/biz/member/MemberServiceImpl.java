package com.camping.biz.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao dao;

	@Override
	public void insertMember(MemberVO vo) {
		dao.insertMember(vo);
	}

	@Override
	public void deleteMember(MemberVO vo) {
		dao.deleteMember(vo);
	}
	
	@Override
	public void updateMemberAuthority(MemberVO vo) {
		dao.updateMemberAuthority(vo);
	}

	@Override
	public void updateMember(MemberVO vo) {
		dao.updateMember(vo);
	}

	@Override
	public MemberVO getMember(MemberVO vo) {
		return dao.getMember(vo);
	}

	@Override
	public List<MemberVO> getMemberList(MemberVO vo) {
		return dao.getMemberList(vo);
	}

	@Override
	public int totalCount(MemberVO vo) {
		return dao.totalCount(vo);
	}

}
