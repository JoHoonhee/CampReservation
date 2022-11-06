package com.camping.biz.img;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CampImgServiceImpl implements CampImgService {
	
	@Autowired
	private CampImgDao dao;

	@Override
	public void insertCampImg(CampImgVO vo) {
		dao.insertCampImg(vo);
	}

	@Override
	public void deleteCampImg(CampImgVO vo) {
		dao.deleteCampImg(vo);
	}
	
	@Override
	public CampImgVO getCampImg(CampImgVO vo) {
		return dao.getCampImg(vo);
	}

	@Override
	public List<CampImgVO> getCampImgList(CampImgVO vo) {
		return dao.getCampImgList(vo);
	}

}
