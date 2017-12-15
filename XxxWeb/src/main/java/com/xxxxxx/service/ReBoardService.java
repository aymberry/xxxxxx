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
		// ��񿡼� ������ ���� ���ؼ� �˷��ش�.
		return rDAO.getTotal();
	}

	public ArrayList getBoardList(int nowPage, PageUtil pInfo) {
		//�ο�� ��ŸƮ�� ���带 ��������ƿ���� �����ͼ� ����Ʈ�� ��´�.
		pInfo.setNowPage(nowPage);
		HashMap map= new HashMap();
		map.put("START", pInfo.start);
		map.put("END", pInfo.end);

		return rDAO.getBoardList(map);
	}

	
	
	public boolean isHitNow(String id, int oriNo) {
		// ��ȯ�� : �����ؾ��ϸ� true, �ƴϸ�  false
		// �Ű�����  : ����, ������� ���� �˾ƾ��Ѵ�. 
		// �̻���� �̹� �� �۹�ȣ�� �˾Ƴ���.
		HashMap map= rDAO.getHitNo(id);
		if(map==null||map.size()==0){
			// �ѹ��� �ۺ��� ����. ���� �� �۹�ȣ�� �ؽøʿ� ��� �μ�Ʈ.
			HashMap temp= new HashMap();
			temp.put("USER", id);
			temp.put("ORINO", "#"+oriNo+"#");
			rDAO.updateHitNo("reBoard.insertHitNo", temp);
			// ��ȸ�� ������Ŵ.
			return true;
		}
		else {
			// ������ �����ִ� �����. �̹� �ô� �۹�ȣ�� �˾Ƴ���.
			String  ono= (String)map.get("oriNo");
			// #1#2#3#	���߿��� #oriNo#�� �ִ����� Ȯ���ؾ� ��.
			int test= ono.indexOf("#"+oriNo+"#");
			if(test==-1){
				// �� �� ���� ����. �������� �����ϰ� ������Ű��.
				HashMap temp= new HashMap();
				temp.put("USER", id);
				temp.put("ORINO", "#"+oriNo+"#");
				rDAO.updateHitNo("reBoard.updateHitNo", temp);
				return true;
			}
			else{ return false;}
		}
	}
	// ���� ��ȸ�� ������ ó���� �Լ�. ���� ����� ���� ȣ�⿩�ΰ� �Ǵܵ�.
	public void updateHit(int oriNo) {
		rDAO.updateHit(oriNo);
	}
	
	
	
	// �󼼺���ó��
	public HashMap boardView(int oriNo) {
		// �󼼺����� ���� ������ ��۸�� ������.
		ReBoardVO rvo= rDAO.getBoardView(oriNo);
		ArrayList list= rDAO.getReList(oriNo);
		
		HashMap map= new HashMap();
		map.put("VIEW", rvo);
		map.put("LIST", list);
		return map;
	}

	// ���۵��
	public void oriInsert(ReBoardVO rVO) {
		rDAO.oriInsert(rVO);
		
	}



}
