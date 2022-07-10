package com.leen.leenclair.comments.model;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CommentsServiceImple implements CommentsService{
	private final CommentsDAO commentsDao;

	@Override
	public int insertComments(CommentsVO commentsVo) {
		return commentsDao.insertComments(commentsVo);
	}

	@Override
	public List<CommentsVO> selectCommentsAll(int btNo) {
		return commentsDao.selectCommentsAll(btNo);
	}

	@Override
	public int updateComment(CommentsVO vo) {
		return commentsDao.updateComment(vo);
	}

	@Override
	public int deleteReply(Map<String, String> map) {
		return commentsDao.deleteReply(map);
	}

	@Override
	public CommentsVO selectByCNo(int cNo) {
		return commentsDao.selectByCNo(cNo);
	}

	@Override
	public int updateCommentEdit(CommentsVO vo) {
		return commentsDao.updateCommentEdit(vo);
	}

	@Override
	public int insertreComment(CommentsVO vo) {
		return commentsDao.insertreComment(vo);
	}

	@Override
	public int updatereComment(CommentsVO vo) {
		return commentsDao.updatereComment(vo);
	}
}
