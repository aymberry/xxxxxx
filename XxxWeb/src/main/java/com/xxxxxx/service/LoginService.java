package com.xxxxxx.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import com.xxxxxx.dao.LoginDAO;

public class LoginService {
	@Autowired
	public LoginDAO lDAO;

	public int loginProc(String id, String pw) {
		HashMap<String, String> map= new HashMap();
		map.put("ID", id);
		map.put("PW", pw);
		return lDAO.loginProc(map);
	}

}
