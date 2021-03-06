package com.leen.leenclair.member.model;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{
	private final MemberDAO memberDao;

	@Override
	public int insertMember(MemberVO vo) {
		return memberDao.insertMember(vo);
	}

	@Override
	public int checkLogin(String userid, String pwd) {
		String dbPwd=memberDao.selectPwd(userid);
		
		int result=0;
		if(dbPwd !=null && !dbPwd.isEmpty()) {
			if(dbPwd.equals(pwd)) {
				result=MemberService.LOGIN_OK;
			}else {
				result=MemberService.DISAGREE_PWD;				
			}
		}else {
			result=MemberService.NONE_USERID;
		}
		
		return result;
	}

	@Override
	public MemberVO selectByUserid(String userid) {
		return memberDao.selectByUserid(userid);
	}
}
