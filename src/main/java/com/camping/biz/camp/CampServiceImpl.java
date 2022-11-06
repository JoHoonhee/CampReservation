package com.camping.biz.camp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CampServiceImpl implements CampService {
	
	@Autowired
	private CampDao dao;

	@Override
	public void insertCamp(CampVO vo) {
		dao.insertCamp(vo);
	}
	
	@Override
	public void insertCampSub(CampVO vo) {
		dao.insertCampSub(vo);
	}

	@Override
	public void deleteCamp(CampVO vo) {
		dao.deleteCamp(vo);
	}

	@Override
	public void updateCamp(CampVO vo) {
		dao.updateCamp(vo);
	}

	@Override
	public CampVO getCamp(CampVO vo) {
		return dao.getCamp(vo);
	}
	
	@Override
	public List<CampVO> getCampList(CampVO vo) {
		return dao.getCampList(vo);
	}

	@Override
	public int totalCount(CampVO vo) {
		return dao.totalCount(vo);
	}

}
