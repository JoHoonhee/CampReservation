package com.camping.biz.reservation;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CampReserveVO {
	// 예약 관련 컬럼
	private int idx;
	private String id;
	private String name;
	private String tel;
	private String camp_name;
	private String camp_div;
	private Date start_date;
	private Date end_date;
	private String write_review;
	
	// 예약 목록 페이지 관련
	private int totalCount;
	private int start_idx;
	private int end_idx;
	
	// 리뷰 작성 관련 컬럼
	private int idx_review;
	private String review;
	private Date review_date;
}
