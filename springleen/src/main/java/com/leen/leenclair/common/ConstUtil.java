package com.leen.leenclair.common;

public interface ConstUtil {
	//게시판 페이징 관련 상수
	public static final int RECORD_COUNT=5;
	int BLOCKSIZE=10;

	//파일 업로드 관련 상수
	String FILE_UPLOAD_TYPE="test";   //테스트시
	//String FILE_UPLOAD_TYPE="deploy"; //배포시
	
	//자료실 - 파일 저장 경로
	String FILE_UPLOAD_PATH="board_upload";
	String FILE_UPLOAD_PATH_TEST="C:\\lecture\\workspace_list\\spboot_ws\\springleen\\src\\main\\resources\\static\\board_upload";
	
	//관리자 페이지 - 관리자 파일 저장 경로
	String IMAGE_FILE_UPLOAD_PATH="";
	String IMAGE_FILE_UPLOAD_PATH_TEST="";
	
	//관리자 업로드인지, 게시판 업로드인지 구분값
	int UPLOAD_FILE_FLAG=1;  //관리자 업로드
	int UPLOAD_IMAGE_FLAG=2; //관리자 업로드	
}
