package com.tj.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public interface BoardService {

	/**
	 * 게시글 조회
	 * home 일 경우 공지사항과 자유게시판 둘다 가져온다.
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
	 * 특정 게시글 정보 조회
	 * @param params
	 * @return
	 */
	public HashMap<String, Object> read(HashMap<String, Object> params);
	
	/**
	 * 글 내용 insert
	 * @param params
	 * @param mFiles
	 * @return
	 */
	public int write(HashMap<String, Object> params, List<MultipartFile> mFiles);
	
	/**
	 * 글 삭제 delete
	 * @param getBoard
	 * @return
	 */
	public int delete(HashMap<String, Object> getBoard);
	
	/**
	 * 글 수정 update
	 * @param params
	 * @param mFiles
	 * @return
	 */
	public int update(HashMap<String, Object> params, List<MultipartFile> mFiles);
	
	/**
	 * has_file 이 1 이면 파일 정보 조회
	 * @param params
	 * @return 실행된 쿼리결과 여러건
	 */
	public List<HashMap<String, Object>> fileRead(HashMap<String, Object> params);
	
	/**
	 * 파일 정보 삭제
	 * @param params
	 * @return 실행된 쿼리결과
	 */
	public boolean deleteAttach(HashMap<String, Object> params);
}
