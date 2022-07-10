package com.leen.leenclair.comments.model;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentsDAO {
	public int insertComments(CommentsVO commentsVo);
	public List<CommentsVO> selectCommentsAll(int btNo);
	int updateComment(CommentsVO vo);
	int deleteReply(Map<String, String> map);
	CommentsVO selectByCNo(int cNo);
	int updateCommentEdit(CommentsVO vo);
	int insertreComment(CommentsVO vo);
	int updatereComment(CommentsVO vo);
}
