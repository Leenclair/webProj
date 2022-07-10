package com.leen.leenclair.member.model;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface MemberDAO {
	public int insertMember(MemberVO vo);
	public String selectPwd(String userid);
	public MemberVO selectByUserid(String userid);
}
