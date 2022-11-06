package com.camping.biz.img;

import java.util.List;

public interface CampImgDao {
	void insertCampImg(CampImgVO vo);
	void deleteCampImg(CampImgVO vo);
	CampImgVO getCampImg(CampImgVO vo);
	List<CampImgVO> getCampImgList(CampImgVO vo);
}
