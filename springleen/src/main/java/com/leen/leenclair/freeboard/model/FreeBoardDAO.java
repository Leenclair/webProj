package com.leen.leenclair.freeboard.model;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.leen.leenclair.common.SearchVO;

@Mapper
public interface FreeBoardDAO {
	public int insertBoard(FreeBoardVO vo);
	public List<FreeBoardVO> selectAll(SearchVO searchVo);
	public FreeBoardVO selectByNo(int btNo);
	public int updateDownCount(int btNo);
	public int getTotalRecord(SearchVO searchVo);
	public int updateBoard(FreeBoardVO vo);
	public int deleteBoard(int btNo);
}
