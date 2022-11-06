package com.camping.biz.member;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public void insertMember(MemberVO vo) {
		mybatis.insert("MEMBER.insertMember", vo);
	}

	@Override
	public void deleteMember(MemberVO vo) {
		mybatis.delete("MEMBER.deleteMember", vo);
	}
	
	@Override
	public void updateMemberAuthority(MemberVO vo) {
		mybatis.update("MEMBER.updateMemberAuthority", vo);
	}

	@Override
	public void updateMember(MemberVO vo) {
		mybatis.update("MEMBER.updateMember", vo);
	}

	@Override
	public MemberVO getMember(MemberVO vo) {
		return mybatis.selectOne("MEMBER.getMember", vo);
	}

	@Override
	public List<MemberVO> getMemberList(MemberVO vo) {
		return mybatis.selectList("MEMBER.getMemberList", vo);
	}

	@Override
	public int totalCount(MemberVO vo) {
		return mybatis.selectOne("MEMBER.totalCount", vo);
	}

}
