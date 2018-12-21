package com.tj.controller;

import java.util.HashMap;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.tj.service.BoardService;
import com.tj.service.NoticeService;

@Controller
public class IndexController {
	@Autowired BoardService bService;
	@Autowired NoticeService nService;
	@Value("#{config['site.context.path']}")
	private String contextRoot;
	Logger logger = Logger.getLogger(IndexController.class);
	
	private RedirectView refreshRv() {
		RedirectView rv = new RedirectView(contextRoot + "/index.do");
		return rv;
	}

	@RequestMapping("/index.do")
	public ModelAndView index(@RequestParam HashMap<String, String> params) {
		ModelAndView mv = new ModelAndView();
		
		mv.setViewName("index2");
		return mv;
	}
	
	@RequestMapping("/home.do")
	public ModelAndView home(@RequestParam HashMap<String, String> params) {
		ModelAndView mv = new ModelAndView();
		if(!params.containsKey("pageName") && !params.containsKey("moveBack")) {
			mv.setView(refreshRv());
		} else {
			params.put("start", "0");
			params.put("rows", "10");
			params.put("sidx", "board_seq");
			params.put("sord", "desc");
			mv.setViewName("home");
			// 공지사항 최신글 10개
			params.put("typeSeq", "1");
			mv.addObject("noticeList", nService.list(params));
			// 자유게시판 최신글 10개 
			params.put("typeSeq", "2");
			mv.addObject("freeList", bService.list(params));
		}
			
		return mv;
	}
	
	@RequestMapping("/tables.do")
	public ModelAndView tables(@RequestParam HashMap<String, String> params) {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("index2");
		return mv;
	}
	
	@RequestMapping("pageDevNote.do")
	public ModelAndView pageDevNote(@RequestParam HashMap<String, Object> params) {
		ModelAndView mv = new ModelAndView();
		if(!params.containsKey("pageName") && !params.containsKey("moveBack")) {
			mv.setView(refreshRv());
		} else {
			mv.setViewName("devNote");
		}
		
		return mv;
	}
	
	@RequestMapping("/pageContact.do")
	public ModelAndView pageContact(@RequestParam HashMap<String, Object> params) {
		ModelAndView mv = new ModelAndView();
		if(!params.containsKey("pageName") && !params.containsKey("moveBack")) {
			mv.setView(refreshRv());
		} else {
			mv.setViewName("contact");
		}
		return mv;
	}
}
