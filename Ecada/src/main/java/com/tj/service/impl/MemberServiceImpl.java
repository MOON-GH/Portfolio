package com.tj.service.impl;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tj.dao.MemberDao;
import com.tj.exception.PasswordMissMatchException;
import com.tj.exception.UserNotFoundException;
import com.tj.service.MemberService;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired MemberDao mDao; 

	@Override
	public ArrayList<HashMap<String, Object>> memberList(HashMap<String, Object> params) {
		return null;
	}

	@Override
	public int join(HashMap<String, String> params) {
		return mDao.join(params);
	}

	@Override
	public int checkId(HashMap<String, String> params) {
		return mDao.checkId(params);
	}

	@Override
	public HashMap<String, Object> login(HashMap<String, String> params) throws UserNotFoundException, PasswordMissMatchException {
		HashMap<String, Object> member = mDao.getMemberById(params);
		if(member == null || member.size() == 0){
			throw new UserNotFoundException();
		}else {
			String dbPw = String.valueOf(member.get("memberPw"));
			String pw = mDao.makeCipherText(params);
			if(!dbPw.equals(pw)){
				throw new PasswordMissMatchException();
			}
			return member;
		}
	}

}
