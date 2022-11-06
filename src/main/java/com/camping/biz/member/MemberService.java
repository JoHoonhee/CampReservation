package com.camping.biz.member;

import java.util.List;

public interface MemberService {
	void insertMember(MemberVO vo);
	void deleteMember(MemberVO vo);
	void updateMember(MemberVO vo);
	void updateMemberAuthority(MemberVO vo);
	MemberVO getMember(MemberVO vo);
	List<MemberVO> getMemberList(MemberVO vo);
	
	int totalCount(MemberVO vo);
}
