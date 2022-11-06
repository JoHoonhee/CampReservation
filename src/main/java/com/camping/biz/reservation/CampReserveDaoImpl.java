package com.camping.biz.reservation;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CampReserveDaoImpl implements CampReserveDao {
	
	@Autowired
	private SqlSessionTemplate mybatis;

	@Override
	public void insertCampReservation(CampReserveVO vo) {
		mybatis.insert("REV.insertCampReservation", vo);
	}

	@Override
	public void deleteCampReservation(CampReserveVO vo) {
		mybatis.delete("REV.deleteCampReservation", vo);
	}

	@Override
	public void updateWriteReview(CampReserveVO vo) {
		mybatis.update("REV.updateWriteReview", vo);
	}

	@Override
	public CampReserveVO getReserveCheck(CampReserveVO vo) {
		return mybatis.selectOne("REV.getReserveCheck", vo);
	}

	@Override
	public List<CampReserveVO> getReserveCheckList(CampReserveVO vo) {
		return mybatis.selectList("REV.getReserveCheckList", vo);
	}

	@Override
	public int totalCount(CampReserveVO vo) {
		return mybatis.selectOne("REV.totalCount", vo);
	}

	@Override
	public void insertReview(CampReserveVO vo) {
		mybatis.insert("REV.insertReview", vo);
	}

	@Override
	public void deleteReview(CampReserveVO vo) {
		mybatis.delete("REV.deleteReview", vo);
	}

	@Override
	public List<CampReserveVO> getReviewList(CampReserveVO vo) {
		return mybatis.selectList("REV.getReviewList", vo);
	}

	@Override
	public int totalCountReview(CampReserveVO vo) {
		return mybatis.selectOne("REV.totalCountReview", vo);
	}

}
