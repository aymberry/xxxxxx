package com.xxxxxx.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;

public class LoginDAO extends SqlSessionDaoSupport {
	@Autowired
	public SqlSessionTemplate sSession;

	public int loginProc(HashMap<String, String> map) {
		
		return sSession.selectOne("login.login", map);
	}

}
