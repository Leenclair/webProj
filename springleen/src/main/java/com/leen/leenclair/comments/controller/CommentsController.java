package com.leen.leenclair.comments.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.leen.leenclair.comments.model.CommentsService;
import com.leen.leenclair.comments.model.CommentsVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/portal/comments")
@RequiredArgsConstructor
public class CommentsController {
	private static final Logger logger
	=LoggerFactory.getLogger(CommentsController.class);
	private final CommentsService commentsService;

	//댓글 등록 처리
	@RequestMapping("/write")
	public String comments_write(@ModelAttribute CommentsVO vo) {
		logger.info("댓글 처리 파라미터, vo={}", vo);

		int cnt=commentsService.insertComments(vo);
		logger.info("댓글 처리 파라미터-결과, cnt={}", cnt);

		return "redirect:/portal/board/detail?btNo="+vo.getBtNo();
	}

	//댓글수정 위한 파라미터 바꾸기
	@RequestMapping("/ReplyEditFlag")
	public String replyUpdate_post(@RequestParam(defaultValue = "0")int cNo) {
		logger.info("댓글수정 텍스트 바뀌기 파라미터, cNo={}", cNo);
		CommentsVO vo=commentsService.selectByCNo(cNo);
		logger.info("댓글수정 vo{}", vo);
		
		commentsService.updateCommentEdit(vo);
		logger.info("댓글수정된 vo", vo);

		return "redirect:/portal/board/detail?btNo="+vo.getBtNo();
	}

	//댓글수정
	@RequestMapping("/replyEdit")
	public String replyEdit(@ModelAttribute CommentsVO vo, Model model) {
		logger.info("수정할 댓글 vo={}", vo);

		int cnt=commentsService.updateComment(vo);
		logger.info("댓글수정 결과 cnt={}",cnt);

		return "redirect:/portal/board/detail?btNo="+vo.getBtNo();
	}

	//댓글삭제
	@RequestMapping("/replyDelete")
	public String replyDelete(@RequestParam(defaultValue = "0") int cNo,
			@RequestParam(defaultValue = "0") int btNo,Model model) {
		logger.info("댓글 삭제처리, 파라미터 cNo={},btNo={}",cNo,btNo);
		
		CommentsVO vo=commentsService.selectByCNo(cNo);
		logger.info("삭제할 댓글 정보, vo={}", vo);
		
		Map<String, String> map = new HashMap<>();
		map.put("CNo", cNo+"");
		map.put("groupno", vo.getGroupno()+"");
		map.put("step", vo.getStep()+"");
		
		commentsService.deleteReply(map);
		
		String msg="댓글이 삭제되었습니다";
		String url="/portal/board/detail?btNo="+btNo;
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}

	//대댓글등록처리
	@RequestMapping("/comments_reply")
	public String comments_reply(HttpSession session,CommentsVO vo,Model model) {
		logger.info("대댓글등록 파라미터, vo={}", vo);

		//id 안받았으면 session에서 id 받아서 값 설정하기
		String userId=(String)session.getAttribute("userid");
		vo.setCId(userId);

		int update=commentsService.updatereComment(vo);
		logger.info("대댓글처리 전 댓글 로직 업데이트 결과, update={}", update);

		int cnt=commentsService.insertreComment(vo);
		logger.info("대댓글등록 처리결과 cnt={}", cnt);

		return "redirect:/portal/board/detail?btNo="+vo.getBtNo();
	}

}
