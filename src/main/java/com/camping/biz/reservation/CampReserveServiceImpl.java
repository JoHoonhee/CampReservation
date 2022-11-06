package com.camping.biz.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CampReserveServiceImpl implements CampReserveService {
	
	@Autowired
	private CampReserveDao dao;

	@Override
	public void insertCampReservation(CampReserveVO vo) {
		dao.insertCampReservation(vo);
	}

	@Override
	public void deleteCampReservation(CampReserveVO vo) {
		dao.deleteCampReservation(vo);
	}

	@Override
	public void updateWriteReview(CampReserveVO vo) {
		dao.updateWriteReview(vo);
	}

	@Override
	public CampReserveVO getReserveCheck(CampReserveVO vo) {
		return dao.getReserveCheck(vo);
	}

	@Override
	public List<CampReserveVO> getReserveCheckList(CampReserveVO vo) {
		return dao.getReserveCheckList(vo);
	}

	@Override
	public int totalCount(CampReserveVO vo) {
		return dao.totalCount(vo);
	}

	@Override
	public void insertReview(CampReserveVO vo) {
		dao.insertReview(vo);
	}

	@Override
	public void deleteReview(CampReserveVO vo) {
		dao.deleteReview(vo);
	}

	@Override
	public List<CampReserveVO> getReviewList(CampReserveVO vo) {
		return dao.getReviewList(vo);
	}

	@Override
	public int totalCountReview(CampReserveVO vo) {
		return dao.totalCountReview(vo);
	}

}
