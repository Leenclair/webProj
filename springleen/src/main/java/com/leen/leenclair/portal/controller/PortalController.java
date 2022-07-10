package com.leen.leenclair.portal.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("/portal")
public class PortalController {
	private static final Logger logger
		=LoggerFactory.getLogger(PortalController.class);
	
	@RequestMapping("/index")
	public void main() {
		logger.info("메인화면");
	}
}
