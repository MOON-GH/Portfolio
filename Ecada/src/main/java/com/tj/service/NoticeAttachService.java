package com.tj.service;

import java.util.HashMap;

public interface NoticeAttachService {
	
	/**
	 * 파일정보 조회
	 * @param fileIdx
	 * @return 조회된 파일 정보
	 */
	public HashMap<String, Object> getAttachFileInfo(int fileIdx);
}
