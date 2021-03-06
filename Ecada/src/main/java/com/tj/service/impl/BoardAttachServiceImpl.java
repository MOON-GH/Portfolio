package com.tj.service.impl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tj.dao.BoardAttachDao;
import com.tj.service.BoardAttachService;

@Service
public class BoardAttachServiceImpl implements BoardAttachService{
	@Autowired private BoardAttachDao bAttachDao;

	@Override
	public HashMap<String, Object> getAttachFileInfo(int fileIdx) {
		return bAttachDao.getAttachFileInfo(fileIdx);
	}
}
