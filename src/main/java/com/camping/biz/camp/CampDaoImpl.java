package com.camping.biz.camp;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CampDaoImpl implements CampDao {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public void insertCamp(CampVO vo) {
		mybatis.insert("CAMP.insertCamp", vo);
	}
	
	@Override
	public void insertCampSub(CampVO vo) {
		mybatis.insert("CAMP.insertCampSub", vo);
	}

	@Override
	public void deleteCamp(CampVO vo) {
		mybatis.delete("CAMP.deleteCamp", vo);
	}

	@Override
	public void updateCamp(CampVO vo) {
		mybatis.update("CAMP.updateCamp", vo);
	}

	@Override
	public CampVO getCamp(CampVO vo) {
		return mybatis.selectOne("CAMP.getCamp", vo);
	}
	
	@Override
	public List<CampVO> getCampList(CampVO vo) {
		return mybatis.selectList("CAMP.getCampList", vo);
	}

	@Override
	public int totalCount(CampVO vo) {
		return mybatis.selectOne("CAMP.totalCount", vo);
	}

}
