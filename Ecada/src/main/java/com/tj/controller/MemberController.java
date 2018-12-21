package com.tj.controller;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.tj.exception.PasswordMissMatchException;
import com.tj.exception.UserNotFoundException;
import com.tj.service.MemberService;

@Controller
public class MemberController {
	@Autowired
	MemberService mService;
	
	@Value("#{config['site.context.path']}")
	private String ctx;
	
	Logger logger = Logger.getLogger(MemberController.class);
	
	@RequestMapping("/member/goLoginPage.do")
	public String goLogin() {
		return "member/login";
	}
	
	@RequestMapping("/member/goRegisterPage.do")
	public String goRegisterPage() {
		return "member/register";
	}
	
	@RequestMapping("/member/checkId.do")
	@ResponseBody
	public HashMap<String, Object> checkId(@RequestParam HashMap<String, String> params){
		logger.debug("/member/checkId.do params : " + params);
		
		int cnt = mService.checkId(params);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("cnt", cnt);
		map.put("msg", cnt==1?"중복된 ID 입니다.":"");
		
		return map;
	}
	
	@RequestMapping("/member/join.do")
	@ResponseBody
	public HashMap<String, Object> join(@RequestParam HashMap<String, String> params){
		logger.debug("/member/join.do params : " + params);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int cnt = mService.join(params);
		map.put("cnt", cnt);
		map.put("msg", cnt==1?"회원 가입 완료!":"회원 가입 실패!");
		map.put("nextPage", cnt==1?"/member/goLoginPage.do" : "/member/goRegisterPage.do");
		return map;
	}
	
	@RequestMapping("/member/logout.do")
	public ModelAndView logout(HttpSession session){
		session.invalidate();
		ModelAndView mv = new ModelAndView();
		RedirectView rv = new RedirectView(ctx+"/index.do");
		mv.setView(rv);
		
		return mv;
	}
	
	@RequestMapping("/member/login.do")
	@ResponseBody
	public HashMap<String, Object> login(@RequestParam HashMap<String, String> params, HttpSession session){
		logger.debug("/member/login.do params : " + params);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		try {
			HashMap<String, Object> member = mService.login(params);
			session.setAttribute("typeSeq", member.get("typeSeq"));
			session.setAttribute("memberIdx", member.get("memberIdx"));
			session.setAttribute("memberId", member.get("memberId"));
			session.setAttribute("memberNick", member.get("memberNick"));
			session.setAttribute("memberName", member.get("memberName"));
			
			map.put("nextPage", "/index.do");
		} catch (UserNotFoundException | PasswordMissMatchException e) {
			e.printStackTrace();
			logger.error(e);
			map.put("nextPage", "/index.do");
			map.put("msg", e.getMessage());
		}
		return map;
	}
	
}
