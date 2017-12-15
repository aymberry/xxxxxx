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

	//��Ϻ���
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

	//�۾�����
	@RequestMapping("/WriteForm")
	public ModelAndView WriteForm(){
		return new ModelAndView("/WriteForms");
	}
	//�۾���ó��
	@RequestMapping("/WriteProc")
	public ModelAndView WriteProc(ReBoardVO rVO, HttpSession session){
		//�۾��̵� ����ؾ��h��.
		String id= (String)session.getAttribute("UID");
		rVO.writer= id;
		rService.oriInsert(rVO);
		RedirectView rv= new RedirectView("../ReBoard/BoardList.time");
		ModelAndView mv= new ModelAndView();
		mv.addObject("RVO", rVO);
		mv.setView(rv);
		return mv; 
		
	}
	//�󼼺���
	@RequestMapping("/BoardView")
	public ModelAndView boardView(ReBoardVO rVO, HttpSession session){
		//��ȸ�� ����ó��
		String id= (String)session.getAttribute("UID");
		boolean isHit= rService.isHitNow(id, rVO.oriNo);
		if(isHit== true){
			rService.updateHit(rVO.oriNo);
		}
		//�󼼺���
		HashMap map= rService.boardView(rVO.oriNo);
		ModelAndView mv= new ModelAndView();
		mv.addObject("NOWPAGE", rVO.nowPage);
		mv.addObject("ORINO", rVO.oriNo);
		mv.addObject("MAP", map);
		mv.setViewName("ReBoard/BoardView");
		return mv;
		
	}

	//���� ������
	//���� ����ó��
	//���� ����ó��
	//��� ������
	//��� ����ó��
	//��� ����ó��(������ư ������ ����ü�� ���������� �ٲ�� ��)
	//��� ����ó��
	//��� ��õó��
	//�˻��ϱ�
}
