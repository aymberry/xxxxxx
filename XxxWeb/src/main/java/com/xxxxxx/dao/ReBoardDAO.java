package com.xxxxxx.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;

import com.xxxxxx.vo.ReBoardVO;

public class ReBoardDAO extends SqlSessionDaoSupport {
	@Autowired
	public SqlSessionTemplate sSession;

	public int getTotal() {
		return sSession.selectOne("reBoard.getTotal");
	}

	public ArrayList getBoardList(HashMap map) {
		return (ArrayList)sSession.selectList("reBoard.getBoardList", map);
		
	}

	public HashMap getHitNo(String id) {
		return sSession.selectOne("reBoard.getHitNo", id);
		//	주의
		//		1.	파라메터가 Map이면 #{내용}이 Map의 키값이 되어야 한다.
		//		2.	파라메터가 VO이면 #{내용}이 setXxx 함수의 이름이 되어야 한다.
		//		3.	파라메터가 일반 데이터이면 #{내용}이 데이터의 변수이름이 되어야 한다.
	}
	
	public void updateHitNo(String code, HashMap map) {
		if(code.equals("reBoard.insertHitNo")) {
			sSession.insert(code, map);
		}
		else{
			sSession.update(code, map);
			}
	}

	public void updateHit(int oriNo) {
		sSession.update("reBoard.updateHit", oriNo);	
	}

	public ReBoardVO getBoardView(int oriNo) {
		return sSession.selectOne("reBoard.boardView", oriNo);
	}

	public ArrayList getReList(int oriNo) {
		return (ArrayList)sSession.selectList("reBoard.getReList", oriNo);
	}

	public void oriInsert(ReBoardVO rVO) {
		sSession.insert("reBoard.oriInsert", rVO);
	}



}
