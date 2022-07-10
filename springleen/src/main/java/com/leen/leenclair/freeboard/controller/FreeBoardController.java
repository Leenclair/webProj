package com.leen.leenclair.freeboard.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.leen.leenclair.comments.model.CommentsService;
import com.leen.leenclair.comments.model.CommentsVO;
import com.leen.leenclair.common.ConstUtil;
import com.leen.leenclair.common.DateSearchVO;
import com.leen.leenclair.common.FileUploadUtil;
import com.leen.leenclair.common.PaginationInfo;
import com.leen.leenclair.common.SearchVO;
import com.leen.leenclair.freeboard.model.FreeBoardService;
import com.leen.leenclair.freeboard.model.FreeBoardVO;
import com.leen.leenclair.member.model.MemberService;
import com.leen.leenclair.member.model.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/portal/board")
@RequiredArgsConstructor
public class FreeBoardController {
	private static final Logger logger
	=LoggerFactory.getLogger(FreeBoardController.class);

	//Service setting
	private final FreeBoardService freeboardService;
	private final MemberService memberService;
	private final CommentsService commentsService;
	private final FileUploadUtil fileUploadUtil;

	@RequestMapping("/list")
	public void list(@ModelAttribute SearchVO searchVo,Model model) {
		logger.info("자유게시판 리스트 화면, 파라미터 searchVo={}", searchVo);
		
		//[1] PaginationInfo 생성
		PaginationInfo pagingInfo = new PaginationInfo();
		pagingInfo.setBlockSize(ConstUtil.BLOCKSIZE);
		pagingInfo.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
		pagingInfo.setCurrentPage(searchVo.getCurrentPage());

		//[2] searchVo에 페이징 처리 관련 변수의 값 셋팅
		searchVo.setFirstRecordIndex(pagingInfo.getFirstRecordIndex());
		searchVo.setRecordCountPerPage(ConstUtil.RECORD_COUNT);
		
		List<FreeBoardVO> list=freeboardService.selectAll(searchVo);
		logger.info("글목록 조회결과 list.size()={}", list.size());
		
		//totalRecord개수 구하기
		int totalRecord=freeboardService.getTotalRecord(searchVo);
		logger.info("글목록 totalRecord={}", totalRecord);

		pagingInfo.setTotalRecord(totalRecord);
		
		model.addAttribute("list", list);
		model.addAttribute("pagingInfo", pagingInfo);
	}

	@GetMapping("/write")
	public void write_get() {
		logger.info("자유게시판 글쓰기 화면");
	}

	@PostMapping("/write")
	public String write_post(@ModelAttribute FreeBoardVO vo, HttpServletRequest request,
			HttpSession session) {
		logger.info("자유게시판 글쓰기 처리, 파라미터 vo={}",vo);

		String userid=(String)session.getAttribute("userid");
		MemberVO memVo=memberService.selectByUserid(userid);
		logger.info("유저 정보 조회, 파라미터 memVo={}",memVo);

		vo.setNo(memVo.getNo()); // 유저번호 세팅
		logger.info("no 세팅 후, 파라미터 vo={}",vo);

		//파일 업로드 처리
		String fName="", fOrigine="";
		long fSize=0;
		try {
			List<Map<String, Object>> fileList
			=fileUploadUtil.fileUpload(request, 
					ConstUtil.UPLOAD_FILE_FLAG);
			logger.info("fileList.size()={}",fileList.size());
			
			for(Map<String, Object> fileMap : fileList) {
				//다중 파일 업로드 처리필요

				fOrigine=(String) fileMap.get("fOrigine");
				fName=(String) fileMap.get("fName");
				fSize= (long) fileMap.get("fSize");				
			}//for

			logger.info("파일 업로드 성공, fName={}, fSize={}, fOrigine={}", fName,
					fSize, fOrigine);
		} catch (Exception e) {
			e.printStackTrace();
		}

		vo.setFName(fName);
		vo.setFOrigine(fOrigine);
		vo.setFSize(fSize);
		
		logger.info("파일 업로드 처리후 vo={}",vo);

		int cnt=freeboardService.insertBoard(vo);
		logger.info("자유게시판 글쓰기 처리 결과, cnt={}", cnt);

		return "redirect:/portal/board/list";
	}

	@RequestMapping("/detail")
	public void detail(@RequestParam(defaultValue = "0")int btNo,HttpSession session,Model model) {
		logger.info("자유게시판 글 상세보기, 파라미터 btNo={}", btNo);
		
		FreeBoardVO vo = freeboardService.selectByNo(btNo);
		logger.info("자유게시판 글 상세보기 번호로 검색결과, vo={}", vo);
		
		String userid=(String)session.getAttribute("userid");
		MemberVO memVo=memberService.selectByUserid(userid);
		logger.info("유저정보 조회 결과, memVo={}", memVo);
		
		//댓글 리스트 처리
		List<CommentsVO> commentsList = commentsService.selectCommentsAll(btNo);
		logger.info("댓글목록 처리, 결과 commentsList={}", commentsList);
		
		model.addAttribute("vo", vo);
		model.addAttribute("memVo", memVo);
		model.addAttribute("commentsList", commentsList);
	}

	@RequestMapping("/download")
	public ModelAndView download(@RequestParam(defaultValue = "0") int btNo,
			@RequestParam String fName, HttpServletRequest request){
		logger.info("다운로드 처리, 파라미터 btNo={}, fName={}", btNo, fName);
		
		int cnt=freeboardService.updateDownCount(btNo);
		logger.info("다운로드 수 증가 결과 cnt={}", cnt);
		
		Map<String, Object> map = new HashMap<>();
		String uploadPath = fileUploadUtil.getUploadPath(request, ConstUtil.UPLOAD_FILE_FLAG);
		File file = new File(uploadPath,fName);
		map.put("file", file);
		
		ModelAndView mav = new ModelAndView("freeboardDownloadView", map);
		
		return mav;
	}
	
	@GetMapping("/edit")
	public void edit_get(@RequestParam(defaultValue = "0") int btNo, Model model) {
		logger.info("글 수정화면, 파라미터 btNo={}", btNo);
		
		FreeBoardVO vo=freeboardService.selectByNo(btNo);
		logger.info("글 번호로 검색결과, vo={}", vo);
		
		model.addAttribute("vo", vo);
	}
	
	@PostMapping("/edit")
	public String edit_post(@ModelAttribute FreeBoardVO vo, HttpServletRequest request, Model model) {
		logger.info("글 수정처리, 파라미터 vo={}", vo);
		
		//파일 업로드 처리
		String fName="", fOrigine="";
		long fSize=0;
		List<Map<String, Object>> fileList=null;
		try {
			fileList=fileUploadUtil.fileUpload(request,	ConstUtil.UPLOAD_FILE_FLAG);
			logger.info("fileList.size()={}",fileList.size());

			for(Map<String, Object> fileMap : fileList) {
				//다중 파일 업로드 처리필요

				fOrigine=(String) fileMap.get("fOrigine");
				fName=(String) fileMap.get("fName");
				fSize= (long) fileMap.get("fSize");				
			}//for

			logger.info("글 수정 처리-파일 업로드 성공, fName={}, fSize={}, fOrigine={}", 
					fName, fSize, fOrigine);
		} catch (Exception e) {
			e.printStackTrace();
		}

		vo.setFName(fName);
		vo.setFOrigine(fOrigine);
		vo.setFSize(fSize);
		
		int cnt=freeboardService.updateBoard(vo);
		logger.info("글 수정 처리 결과, cnt={}", cnt);
		
		String msg="",url="";
		if(cnt>0) {
			msg="글 수정되었습니다";
			url="/portal/board/detail?btNo="+vo.getBtNo();
			
			if(!fileList.isEmpty()) {
				if(vo.getFName()!=null && !vo.getFName().isEmpty()) {
					String uploadPath = fileUploadUtil.getUploadPath(request, ConstUtil.UPLOAD_FILE_FLAG);
					File oldFile = new File(uploadPath, vo.getFName());
					if(oldFile.exists()) {
						boolean bool=oldFile.delete();
						logger.info("글수정-파일삭제 확인 : {}", bool);
					}
				}
			}
		}else {
			msg="글 수정 실패";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}

	@RequestMapping("/delete")
	public String delete(@RequestParam(defaultValue = "0")int btNo) {
		logger.info("삭제할 글 게시글 번호 btNo={}", btNo);
		
		int cnt=freeboardService.deleteBoard(btNo);
		logger.info("글 삭제처리 결과, cnt={}", cnt);
		
		return "redirect:/portal/board/list";
	}
}
