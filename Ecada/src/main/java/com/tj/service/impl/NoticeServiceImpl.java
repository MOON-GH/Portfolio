package com.tj.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.tj.dao.NoticeAttachDao;
import com.tj.dao.NoticeDao;
import com.tj.service.NoticeService;
import com.tj.util.FileUtil;

@Service
public class NoticeServiceImpl implements NoticeService{
	@Autowired private NoticeDao nDao;
	@Autowired private NoticeAttachDao nAttachDao;
	@Autowired private FileUtil fUtil;
	
	@Override
	public ArrayList<HashMap<String, Object>> list(HashMap<String, String> params) {
		return nDao.list(params);
	}
	
	@Override
	public int getTotalArticleCnt(HashMap<String, String> params) {
		return nDao.getTotalArticleCnt(params);
	}

	@Override
	public HashMap<String, Object> read(HashMap<String, Object> params) {
		if(!params.containsKey("update")) nDao.updateHits(params);
		return nDao.getBoard(params);
	}

	@Override
	public int write(HashMap<String, Object> params, List<MultipartFile> mFiles) {
		int result = 0;
		// 글 등록
		result = nDao.write(params);
		
		int hasFile = Integer.parseInt((params.get("hasFile").toString()));
		if(hasFile == 1) {
			// 첨부파일이 있으면 board_attach 테이블에 등록
			for(MultipartFile mf : mFiles) {
				if(!mf.getOriginalFilename().equals("")) {
					// 난수 생성 후 fakefileName 으로 사용
					String fakename = UUID.randomUUID().toString().replaceAll("-", "");
					params.put("mFile", mFiles);
					params.put("filename", mf.getOriginalFilename());
					params.put("fakeFilename", fakename);
					params.put("fileSize", mf.getSize());
					params.put("fileType", mf.getContentType());
					
					result = nAttachDao.insertAttachInfo(params);
					
					try {
						fUtil.copyFile(mf, fakename);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
		}
		
		return result;
	}

	@Override
	public int delete(HashMap<String, Object> getBoard) {
		int result = 0;
		
		if(getBoard.get("hasFile").equals("1")) {	// 첨부 파일이 있으면
			// 1. 삭제할 첨부파일 정보를 모두 가지고 온다.
			List<HashMap<String, Object>> files = nAttachDao.getFile(getBoard);
			// 글번호, 타입으로 첨부파일 정보를 삭제하는 DAO 메서드 호출
			result = nAttachDao.deleteAttachBoard(getBoard);

			// 글 삭제
			result = (result > 0) ? nDao.delete(getBoard) : 0;
			
			// 물리적 위치에서 삭제
			if(result == 1) {
				for(Map<String, Object> file : files) {
					// Map 은 interface고 HashMap 은 class 이다. -> 즉, Map은 HashMap으로 cast 가능하다.
					fUtil.deleteFile((HashMap<String, Object>) file);
				}	
			}
		} else {
			// 글 삭제
			result = nDao.delete(getBoard);
		}
		
		
		return result;
	}

	@Override
	public int update(HashMap<String, Object> params, List<MultipartFile> mFiles) {
		// 2. 첨부파일이 있으면 board_attach 테이블에 등록
		int hasFile = 0;
		for(MultipartFile mf : mFiles) {
			if(!mf.getOriginalFilename().equals("")) {
				// 난수를 만들어 가짜 이름으로 사용..
				String fakename = UUID.randomUUID().toString().replace("-", "");
				params.put("mFile", mFiles);
				params.put("filename", mf.getOriginalFilename());
				params.put("fakeFilename", fakename);
				params.put("fileSize", mf.getSize());
				params.put("fileType", mf.getContentType());
				
				hasFile = nAttachDao.insertAttachInfo(params);
				
				try {
					fUtil.copyFile(mf, fakename);
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		// 게시글 수정시 첨부파일 모두삭제 여부 체크
		hasFile = (nAttachDao.hasFileChk(params) > 0 ) ? 1 : 0;
		
		params.put("hasFile", hasFile);
		return nDao.update(params);
	}
	
	@Override
	public List<HashMap<String, Object>> fileRead(HashMap<String, Object> params) {
		return nAttachDao.getFile(params);
	}

	@Override
	public boolean deleteAttach(HashMap<String, Object> params) {
		boolean result = false;
		int fileIdx = Integer.parseInt((String) params.get("fileIdx"));
		
		// 첨부파일 정보를 가져온다.
		HashMap<String, Object> fileInfo = nAttachDao.getAttachFileInfo(fileIdx);
		// DB에서 삭제한다.
		result = (nAttachDao.deleteAttach(fileIdx) == 1);
		// 원 게시글과 첨부파일 정보의 관계를 확인한다. (첨부파일 전체 가져오기)
		List<HashMap<String, Object>> files = nAttachDao.getFile(params);
		// 가져온 첨부파일이 없으면 (더이상 첨부파일이 없으면)
		if(files == null || files.size() == 0) {
			// 게시글의 has_file을 0으로 바꾼다.
			result = (nDao.hasFileUpdate(params) == 1 && result);
		}
		// 물리 디스크에서 삭제한다.
		result = (fUtil.deleteFile(fileInfo) == result);
		
		return result;
	}
}
