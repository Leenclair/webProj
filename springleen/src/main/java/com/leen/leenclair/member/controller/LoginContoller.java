package com.leen.leenclair.member.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.leen.leenclair.member.model.MemberService;
import com.leen.leenclair.member.model.MemberVO;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/login")
public class LoginContoller {
	private static final Logger logger
		=LoggerFactory.getLogger(LoginContoller.class);
	private final MemberService memberService;
	
	@RequestMapping("/kakaoLoginTest")
	public void kakaoLogin() {
		logger.info("카카오 로그인 화면구현test");
	}
	
	@RequestMapping("/main")
	public void main() {
		logger.info("메인 화면");
	}
	
	@RequestMapping("/register")
	public String register(@ModelAttribute MemberVO vo) {
		logger.info("회원가입 처리, 파라미터 vo={}", vo);
		
		int cnt=memberService.insertMember(vo);
		logger.info("회원가입 성공, 파라미터 cnt={}", cnt);
		
		return "redirect:/login/main";
	}
	
	@RequestMapping("/login")
	public String login(@ModelAttribute MemberVO vo,HttpServletRequest request,HttpServletResponse response,
			@RequestParam(required = false) String chkSaveId,Model model) {
		logger.info("로그인 처리, 파라미터 vo={}", vo);
		
		int result=memberService.checkLogin(vo.getUserid(), vo.getPwd());
		logger.info("로그인 처리 결과 result={}", result);
		
		String msg="로그인이 실패했습니다", url="/login/main";
		if(result==MemberService.LOGIN_OK) {
			MemberVO memVo=memberService.selectByUserid(vo.getUserid());
			logger.info("회원 정보 조회 결과 memVo={}", memVo);
			
			//[1]session 처리
			HttpSession session=request.getSession();
			session.setAttribute("userid", memVo.getUserid());
			session.setAttribute("username", memVo.getName());
			
			//[2]cookie 처리
			Cookie ck = new Cookie("ckUserId", memVo.getUserid());
			ck.setPath("/");
			if(chkSaveId!=null) { //아이디 저장하기 체크의 경우 로직처리
				ck.setMaxAge(1000*24*60*60);
				response.addCookie(ck);
			}else {
				ck.setMaxAge(0);//쿠키제거
				response.addCookie(ck);
			}
			
			msg=memVo.getName()+"님, 안녕하세요";
			url="/";
		}else if(result==MemberService.DISAGREE_PWD) {
			msg="비밀번호가 틀렸습니다, 다시 입력해주세요";
		}else if(result==MemberService.NONE_USERID) {
			msg="존재하지 않는 아이디입니다";
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/common/message";
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		logger.info("로그아웃 처리");
		
		session.removeAttribute("userid");
		session.removeAttribute("username");
		
		return "redirect:/login/main";
	}
}
