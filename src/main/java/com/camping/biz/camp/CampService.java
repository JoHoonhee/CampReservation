package com.camping.biz.camp;

import java.util.List;

public interface CampService {
	void insertCamp(CampVO vo);
	void insertCampSub(CampVO vo);
	void deleteCamp(CampVO vo);
	void updateCamp(CampVO vo);
	CampVO getCamp(CampVO vo);
	List<CampVO> getCampList(CampVO vo);
	
	int totalCount(CampVO vo);
}
