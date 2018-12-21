package com.tj.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.tj.service.BoardAttachService;
import com.tj.service.BoardService;
import com.tj.util.FileUtil;

@Controller
public class BoardController {
	@Autowired private BoardService bService;
	@Autowired private BoardAttachService bAttachService;
	@Autowired private FileUtil fUtil;
	@Value("#{config['site.context.path']}")
	private String contextRoot;
	Logger logger = Logger.getLogger(BoardController.class);
	
	// 자유게시판 typeSeq = 2
	private String typeSeq = "2";
	
	private RedirectView refreshRv() {
		RedirectView rv = new RedirectView(contextRoot + "/index.do");
		return rv;
	}
	
	@RequestMapping("/board/list.do")
	public ModelAndView list(@RequestParam HashMap<String, String> params){
		ModelAndView mv = new ModelAndView();
		
		logger.debug("/board/list.do params : " + params);
		logger.debug("/board/list.do result : " + params.containsKey("page"));
		
		if(!params.containsKey("pageName") && !params.containsKey("moveBack")) {
			mv.setView(refreshRv());
		} else {
			if(!params.containsKey("typeSeq")) {
				params.put("typeSeq", this.typeSeq);
			}
			
			// 현재 페이지
			int currentPage = Integer.parseInt(params.containsKey("page") ? params.get("page") : "1");
			// 페이지에 보여줄 게시글 수
			int rows = Integer.parseInt(params.containsKey("rows")?params.get("rows"):"10");
			// 총 게시글 수 
			int total = bService.getTotalArticleCnt(params);
			// 총 페이지 수 계산
			int totalPage =  (int) Math.ceil((double) total / rows);
			
			// 시작 게시글 번호
			int start = ((currentPage - 1) * rows);
			
			params.put("start", String.valueOf(start));
			params.put("rows", String.valueOf(rows));
			params.put("sidx", "board_seq");
			params.put("sord", "desc");
			
			ArrayList<HashMap<String, Object>> list = bService.list(params);
			
			// 기본 블럭 수 10
			int blockSize = Integer.parseInt(params.containsKey("blockSize")?params.get("blockSize"):"10");
			int startBlockNo = (currentPage - 1) / blockSize * blockSize + 1;
			int endBlockNo = (currentPage - 1) / blockSize * blockSize + blockSize;
			endBlockNo = (endBlockNo >= totalPage) ? totalPage : endBlockNo;
			
			mv.addObject("totalPage", totalPage);
			mv.addObject("currentPage", currentPage);
			mv.addObject("blockSize", blockSize);
			mv.addObject("startBlockNo", startBlockNo);
			mv.addObject("endBlockNo", endBlockNo);
			mv.addObject("list", list);
			mv.addObject("searchType", params.get("searchType"));
			mv.addObject("searchText", params.get("searchText"));
			mv.setViewName("board/list");
			
		}
		
		return mv;
	}
	
	@RequestMapping("/board/read.do")
	public ModelAndView read(@RequestParam HashMap<String, Object> params) {
		ModelAndView mv = new ModelAndView();
		
		if(!params.containsKey("pageName") && !params.containsKey("moveBack")) {
			mv.setView(refreshRv());
		} else {
			if(!params.containsKey("typeSeq")) {
				params.put("typeSeq", this.typeSeq);
			}
			if(!params.containsKey("page")) {
				params.put("page", "1");
			}
			
			HashMap<String, Object> getBoard = bService.read(params);
			
			// 첨부파일이 있으면 (hasFile = 1)
			if(getBoard.get("hasFile").equals("1")) {
				List<HashMap<String, Object>> getFile = bService.fileRead(params);
				mv.addObject("files", getFile);
			}
	
			mv.addObject("getBoard", getBoard);
			mv.addObject("page", params.get("page"));
			mv.setViewName("/board/read");
		}
		
		return mv;
	}
	
	@RequestMapping("/board/goWrite.do")
	public ModelAndView goWrite(@RequestParam HashMap<String, Object> params, HttpSession session) {
		ModelAndView mv = new ModelAndView();
		
		if(!params.containsKey("pageName") && !params.containsKey("moveBack")) {
			mv.setView(refreshRv());
		} else {
			if(session.getAttribute("memberId") != null) {
				mv.setViewName("/board/write");
				mv.addObject("page", params.get("page"));
			} else {
				RedirectView rv = new RedirectView("/index.do");
				mv.setView(rv);
			}
		}
		
		return mv;
	}
		
	@RequestMapping("/board/write.do")
	@ResponseBody
	public int wirte(@RequestParam HashMap<String, Object> params, HttpSession session, MultipartHttpServletRequest mReq) {
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		
		params.put("memberIdx", session.getAttribute("memberIdx"));
		params.put("memberId", session.getAttribute("memberId"));
		
		List<MultipartFile> mFiles = mReq.getFiles("attachedFile");
		
		for(MultipartFile mf : mFiles) {
			if(!mf.getOriginalFilename().equals("")) {
				params.put("hasFile", "1");
				break;
			} else {
				params.put("hasFile", "0");
			}
		}

		int result = bService.write(params, mFiles);

		return result;
	}
	
	@RequestMapping("/board/delete.do")
	@ResponseBody
	public HashMap<String, Object> delete(@RequestParam HashMap<String, Object> params) {
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		
		HashMap<String, Object> getBoard = bService.read(params);
		int result = bService.delete(getBoard);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String msg = (result == 1) ? "삭제 되었습니다." : "삭제 실패했습니다.";
		
		map.put("msg", msg);
		map.put("result", result);
		
		return map;
	}
	
	@RequestMapping("/board/goUpdate.do")
	public ModelAndView goUpdate(@RequestParam HashMap<String, Object> params) {
		ModelAndView mv = new ModelAndView();
		
		if(!params.containsKey("pageName") && !params.containsKey("moveBack")) {
			mv.setView(refreshRv());
		} else {
			if(!params.containsKey("typeSeq")) {
				params.put("typeSeq", this.typeSeq);
			}
			
			params.put("update", "update");
			
			HashMap<String, Object> getBoard = bService.read(params);
			
			// 첨부파일이 있으면 (hasFile = 1)
			if(getBoard.get("hasFile").equals("1")) {
				List<HashMap<String, Object>> getFile = bService.fileRead(params);
				mv.addObject("files", getFile);
			}
			
			mv.addObject("getBoard", getBoard);
			mv.setViewName("/board/update");
			if(!params.containsKey("page")) {
				params.put("page", "1");
			}
		}
		
		return mv;
	}
	
	@RequestMapping("/board/update.do")
	@ResponseBody
	public HashMap<String, Object> update(@RequestParam HashMap<String, Object> params, MultipartHttpServletRequest mReq) {
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		
		List<MultipartFile> mFiles = mReq.getFiles("attachedFile");
		
		if(params.get("hasFile").equals("0")) {
			for (MultipartFile mf : mFiles) {
				if(!mf.getOriginalFilename().equals("")) {
					params.put("hasFile", "1");
					break;
				} else {
					params.put("hasFile", "0");
				}
			}
		}
		
		int result = bService.update(params, mFiles);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		String msg = (result == 1) ? "게시글이 수정되었습니다." : "수정에 실패했습니다.";
		
		map.put("result", result);
		map.put("msg", msg);
		
		return map;
	}
	
	@RequestMapping("/board/download.do")
	@ResponseBody
	public byte[] download(@RequestParam int fileIdx, HttpServletResponse rep) {
		// pk를 이용해 첨부파일 정보를 가져온다.
		HashMap<String, Object> fileInfo = bAttachService.getAttachFileInfo(fileIdx);
		byte[] b = null;
		
		// 첨부파일 정보를 토대로 파일을 읽어온다.
		b = fUtil.readFile(fileInfo);
		
		String encodingName = null;

		try {
			encodingName = java.net.URLEncoder.encode(fileInfo.get("filename").toString(), "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		// 돌려보내기 위해 응당(HttpServletResponse)에 정보를 입력한다.
		// 파일 다운로드를 할 수 있는 정보들을 브라우저에 알려주는 역할(정보전달)
		rep.setHeader("Content-Disposition", "attachment; filename=\"" + encodingName + "\"");
		// 파일 타입에 맞춰서 다운로드 시켜준다.
		rep.setContentType(String.valueOf(fileInfo.get("file_type")));
		rep.setHeader("Pragma", "no-cache");
		rep.setHeader("Cache-Control", "no-cache");
		String tmp = String.valueOf(fileInfo.get("file_size"));
		rep.setContentLength(Integer.parseInt(tmp));
		
		return b;
	}
	
	@RequestMapping("/board/deleteAttach.do")
	@ResponseBody
	public HashMap<String, Object> deleteAttach(@RequestParam HashMap<String, Object> params) {
		if(!params.containsKey("typeSeq")) {
			params.put("typeSeq", this.typeSeq);
		}
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		boolean result = bService.deleteAttach(params);
		String msg = (result) ? "첨부파일이 삭제되었습니다." : "첨부파일 삭제 실패";
		map.put("msg", msg);
		map.put("result", result);

		return map;
	}
}
