package com.camping.biz.reservation;

import java.util.List;

public interface CampReserveService {
	// 예약, 예약취소, 리뷰등록확인, 예약정보, 예약확인리스트
	void insertCampReservation(CampReserveVO vo);
	void deleteCampReservation(CampReserveVO vo);
	void updateWriteReview(CampReserveVO vo);
	CampReserveVO getReserveCheck(CampReserveVO vo);
	List<CampReserveVO> getReserveCheckList(CampReserveVO vo);
	// 예약 확인 페이지 관련 총 예약 수
	int totalCount(CampReserveVO vo);
	
	// 리뷰 등록, 삭제, 출력
	void insertReview(CampReserveVO vo);
	void deleteReview(CampReserveVO vo);
	List<CampReserveVO> getReviewList(CampReserveVO vo);
	// 리뷰 페이지 관련 총 리뷰 수
	int totalCountReview(CampReserveVO vo);
}
