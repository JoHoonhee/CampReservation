package com.camping.biz.member;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {
	private int idx;
	private String id;
	private String password;
	private String bcrypt;   // 암호화된 비밀번호
	private String name;
	private String tel;
	private String email;
	private String regDate;
	private Role role;
	
	// Member 목록 페이지 관련
	private int totalCount;
	private int start_idx;
	private int end_idx;
	
	// Member 목록 검색
	private String searchCondition;
	private String searchKeyword;
}
