package com.xxxxxx.service;


import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import com.xxxxxx.dao.ReBoardDAO;
import com.xxxxxx.util.PageUtil;
import com.xxxxxx.vo.ReBoardVO;

public class ReBoardService {
	@Autowired
	public ReBoardDAO rDAO;

	public int getTotal() {
		// 디비에서 데이터 갯수 구해서 알려준다.
		return rDAO.getTotal();
	}

	public ArrayList getBoardList(int nowPage, PageUtil pInfo) {
		//로우넘 스타트와 엔드를 페이지유틸에서 가져와서 리스트에 담는다.
		pInfo.setNowPage(nowPage);
		HashMap map= new HashMap();
		map.put("START", pInfo.start);
		map.put("END", pInfo.end);

		return rDAO.getBoardList(map);
	}

	
	
	public boolean isHitNow(String id, int oriNo) {
		// 반환값 : 증가해야하면 true, 아니면  false
		// 매개변수  : 누가, 몇번글을 볼지 알아야한다. 
		// 이사람이 이미 본 글번호를 알아낸다.
		HashMap map= rDAO.getHitNo(id);
		if(map==null||map.size()==0){
			// 한번도 글본적 없음. 지금 본 글번호를 해시맵에 담아 인서트.
			HashMap temp= new HashMap();
			temp.put("USER", id);
			temp.put("ORINO", "#"+oriNo+"#");
			rDAO.updateHitNo("reBoard.insertHitNo", temp);
			// 조회수 증가시킴.
			return true;
		}
		else {
			// 뭔가를 본적있는 사람임. 이미 봤던 글번호를 알아낸다.
			String  ono= (String)map.get("oriNo");
			// #1#2#3#	이중에서 #oriNo#가 있는지를 확인해야 함.
			int test= ono.indexOf("#"+oriNo+"#");
			if(test==-1){
				// 이 글 본적 없음. 본것으로 수정하고 증가시키기.
				HashMap temp= new HashMap();
				temp.put("USER", id);
				temp.put("ORINO", "#"+oriNo+"#");
				rDAO.updateHitNo("reBoard.updateHitNo", temp);
				return true;
			}
			else{ return false;}
		}
	}
	// 실제 조회수 증가를 처리할 함수. 앞의 결과에 따라 호출여부가 판단됨.
	public void updateHit(int oriNo) {
		rDAO.updateHit(oriNo);
	}
	
	
	
	// 상세보기처리
	public HashMap boardView(int oriNo) {
		// 상세보기할 내용 꺼내고 답글목록 꺼낸다.
		ReBoardVO rvo= rDAO.getBoardView(oriNo);
		ArrayList list= rDAO.getReList(oriNo);
		
		HashMap map= new HashMap();
		map.put("VIEW", rvo);
		map.put("LIST", list);
		return map;
	}

	// 원글등록
	public void oriInsert(ReBoardVO rVO) {
		rDAO.oriInsert(rVO);
		
	}



}
