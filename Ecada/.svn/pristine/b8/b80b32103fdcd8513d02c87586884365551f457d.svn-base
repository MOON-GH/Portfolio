package com.tj.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.tj.exception.PasswordMissMatchException;
import com.tj.exception.UserNotFoundException;

public interface MemberService {

	public ArrayList<HashMap<String, Object>> memberList(HashMap<String, Object> params);

	public int join(HashMap<String, String> params);
	
	public int checkId(HashMap<String, String> params);
	
	public HashMap<String, Object> login(HashMap<String, String> params) throws UserNotFoundException, PasswordMissMatchException;
}
