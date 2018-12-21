package com.tj.dao;

import java.util.HashMap;
import java.util.List;

public interface NoticeAttachDao {
	/**
	 * 첨부파일 정보 등록 insert
	 * @param params
	 * @return
	 */
	public int insertAttachInfo(HashMap<String, Object> params);
	
	/**
	 * 파일 정보 조회
	 * @param params
	 * @return 실행된 쿼리결과 여러건
	 */
	public List<HashMap<String, Object>> getFile(HashMap<String, Object> params);
	
	/**
	 * 파일정보 조회
	 * @param fileIdx
	 * @return 조회된 파일 정보
	 */
	public HashMap<String, Object> getAttachFileInfo(int fileIdx);
	
	/**
	 * 파일정보 삭제
	 * @param fileIdx
	 * @return 실행된 쿼리결과
	 */
	public int deleteAttach(int fileIdx);
	
	/**
	 * 글번호로 파일 삭제하는 메서드
	 * @param typeSeq
	 * @param boardSeq
	 * @return 실행된 쿼리결과
	 */
	public int deleteAttachBoard(HashMap<String, Object> getBoard);
	
	/**
	 * 업데이트시 첨부파일 남아있는지 확인하여 has_file 여부에 반영
	 * @param params
	 * @return
	 */
	public int hasFileChk(HashMap<String, Object> params);
}
