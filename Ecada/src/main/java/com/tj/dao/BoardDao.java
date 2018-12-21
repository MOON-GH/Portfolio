package com.tj.dao;

import java.util.ArrayList;
import java.util.HashMap;

public interface BoardDao {
	
	/**
	 * 공지사항 게시글 조회
	 * @param params
	 * @return
	 */
	public ArrayList<HashMap<String, Object>> list(HashMap<String, String> params);
	
	/**
	 * 총 게시글 수
	 * @param params
	 * @return
	 */
	public int getTotalArticleCnt(HashMap<String, String> params);
	
	/**
	 * 조회수 업데이트
	 * @param params
	 * @return 실행된 쿼리결과
	 */
	public int updateHits(HashMap<String, Object> params);
	
	/**
	 * 특정 게시글 정보 조회
	 * @param params
	 * @return
	 */
	public HashMap<String, Object> getBoard(HashMap<String, Object> params);
	
	/**
	 * 글 내용 insert
	 * @param params
	 * @return
	 */
	public int write(HashMap<String, Object> params);
	
	/**
	 * 글 삭제 delete
	 * @param params
	 * @return
	 */
	public int delete(HashMap<String, Object> params);
	
	/**
	 * 글 수정 update
	 * @param params
	 * @return
	 */
	public int update(HashMap<String, Object> params);
	
	/**
	 * 게시글 수정시 첨부파일여부 업데이트(has_file)
	 * @param params
	 * @return 실행된 쿼리결과
	 */
	public int hasFileUpdate(HashMap<String, Object> params);
}
