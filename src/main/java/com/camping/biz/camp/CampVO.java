package com.camping.biz.camp;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class CampVO {
	private String camp_name; // 캠프장 명
	private String camp_div;  // 캠프장 구분
	private double lat;  // 위도
	private double lng;  // 경도
	private String addr; // 주소
	private int common_camp; // 일반야영장 수
	private int car_camp;    // 자동차야영장 수
	private int glamping;    // 글램핑장 수
	private int caravan;     // 카라반 수
	private int toilet;      // 화장실 수
	private int shower_room; // 샤워실 수
	private int sink;        // 개수대 수
	private String addtional_1;  // 기타부대시설1
	private String addtional_2;  // 기타부대시설2
	private Date reference_date; // 등록일 
	private Date approval_date;  // 허가일
	
	// 캠프장 목록 페이지 관련
	private int totalCount;
	private int start_idx;
	private int end_idx;
	
	// 캠프장 목록 검색
	private String searchCondition;
	private String searchKeyword;
}
