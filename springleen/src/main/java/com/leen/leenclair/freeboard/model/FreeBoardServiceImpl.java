package com.leen.leenclair.freeboard.model;

import java.util.List;

import org.springframework.stereotype.Service;

import com.leen.leenclair.common.SearchVO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FreeBoardServiceImpl implements FreeBoardService {
	private final FreeBoardDAO freeboardDao;

	@Override
	public int insertBoard(FreeBoardVO vo) {
		return freeboardDao.insertBoard(vo);
	}

	@Override
	public List<FreeBoardVO> selectAll(SearchVO searchVo) {
		return freeboardDao.selectAll(searchVo);
	}

	@Override
	public FreeBoardVO selectByNo(int btNo) {
		return freeboardDao.selectByNo(btNo);
	}

	@Override
	public int updateDownCount(int btNo) {
		return freeboardDao.updateDownCount(btNo);
	}

	@Override
	public int getTotalRecord(SearchVO searchVo) {
		return freeboardDao.getTotalRecord(searchVo);
	}

	@Override
	public int updateBoard(FreeBoardVO vo) {
		return freeboardDao.updateBoard(vo);
	}

	@Override
	public int deleteBoard(int btNo) {
		return freeboardDao.deleteBoard(btNo);
	}
}
