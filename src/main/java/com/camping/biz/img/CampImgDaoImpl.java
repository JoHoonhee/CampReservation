package com.camping.biz.img;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CampImgDaoImpl implements CampImgDao {

	@Autowired
	private SqlSessionTemplate mybatis;
	
	@Override
	public void insertCampImg(CampImgVO vo) {
		mybatis.insert("IMG.insertCampImg", vo);
	}

	@Override
	public void deleteCampImg(CampImgVO vo) {
		mybatis.delete("IMG.deleteCampImg", vo);
	}
	
	@Override
	public CampImgVO getCampImg(CampImgVO vo) {
		return mybatis.selectOne("IMG.getCampImg", vo);
	}

	@Override
	public List<CampImgVO> getCampImgList(CampImgVO vo) {
		return mybatis.selectList("IMG.getCampImgList", vo);
	}

}
