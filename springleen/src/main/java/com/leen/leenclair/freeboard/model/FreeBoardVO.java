package com.leen.leenclair.freeboard.model;

import java.sql.Timestamp;

import com.leen.leenclair.member.model.MemberVO;

import lombok.Data;

@Data
public class FreeBoardVO extends MemberVO{
	private int btNo;/* 게시글번호 */
	private int no; /* 회원번호 */
	private int divBdNo; /* 게시판구분 */
	private String title; /* 제목 */
	private String content; /* 내용 */
	private Timestamp regdate; /* 등록날짜 */
	private int hit; /* 조회수 */
	private int groupno; /* 그룹번호 */
	private int step; /* 글의단계 */
	private int sortno; /* 정렬순서 */
	private String delflag; /* 삭제 */
	private String fName; /* 파일명 */
	private int fCount; /* 다운로드수 */
	private long fSize; /* 파일사이즈 */
	private String fOrigine;
}
