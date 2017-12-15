package com.xxxxxx.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.xxxxxx.service.ReBoardService;
import com.xxxxxx.util.PageUtil;
import com.xxxxxx.vo.ReBoardVO;

@Controller
@RequestMapping("/ReBoard")
public class reBoardController {
	@Autowired
	public ReBoardService rService;

	//목록보기
	@RequestMapping("/BoardList")
	public ModelAndView boardList(@RequestParam(value="nowPage", defaultValue="1") int nowPage){
		int total= rService.getTotal();
		PageUtil pInfo= new PageUtil(nowPage, total);
		
		ArrayList list= rService.getBoardList(nowPage, pInfo);
		ModelAndView mv= new ModelAndView();
		mv.addObject("PINFO", pInfo);
		mv.addObject("LIST", list);
		mv.setViewName("ReBoard/ReBoardList");
		return mv;
	}

	//글쓰기폼
	@RequestMapping("/WriteForm")
	public ModelAndView WriteForm(){
		return new ModelAndView("/WriteForms");
	}
	//글쓰기처리
	@RequestMapping("/WriteProc")
	public ModelAndView WriteProc(ReBoardVO rVO, HttpSession session){
		//글쓴이도 등록해야햔다.
		String id= (String)session.getAttribute("UID");
		rVO.writer= id;
		rService.oriInsert(rVO);
		RedirectView rv= new RedirectView("../ReBoard/BoardList.time");
		ModelAndView mv= new ModelAndView();
		mv.addObject("RVO", rVO);
		mv.setView(rv);
		return mv; 
		
	}
	//상세보기
	@RequestMapping("/BoardView")
	public ModelAndView boardView(ReBoardVO rVO, HttpSession session){
		//조회수 증가처리
		String id= (String)session.getAttribute("UID");
		boolean isHit= rService.isHitNow(id, rVO.oriNo);
		if(isHit== true){
			rService.updateHit(rVO.oriNo);
		}
		//상세보기
		HashMap map= rService.boardView(rVO.oriNo);
		ModelAndView mv= new ModelAndView();
		mv.addObject("NOWPAGE", rVO.nowPage);
		mv.addObject("ORINO", rVO.oriNo);
		mv.addObject("MAP", map);
		mv.setViewName("ReBoard/BoardView");
		return mv;
		
	}

	//원글 수정폼
	//원글 수정처리
	//원글 삭제처리
	//댓글 쓰기폼
	//댓글 쓰기처리
	//댓글 수정처리(수정버튼 누리면 그자체가 수정폼으로 바뀌게 함)
	//댓글 삭제처리
	//댓글 추천처리
	//검색하기
}
