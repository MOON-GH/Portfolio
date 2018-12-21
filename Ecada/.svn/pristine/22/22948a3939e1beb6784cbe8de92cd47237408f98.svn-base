<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<br/>
	<!-- START - Contain Wrapp -->
        <div class="contain-wrapp">
            <div class="container">
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <div class="section-heading">
                            <h3>포트폴리오 개발노트</h3>
                            <p>
                            	<!-- 본 포트폴리오의 개발내용과 개발과정의 에러/특이사항 등을 개발노트로 작성하였습니다.<br/> -->
                         			각 항목별로 "자세히 보기"-"다운로드" 버튼을 통해 상세히 확인하실 수 있습니다. ^^
                            </p>
                            <i class="fa fa-cog"></i>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 col-sm-6">
                        <div class="icon-box icon-top selected">
                            <div class="icon-box-contain">
                                <i class="fa fa-file-image-o fa-primary"></i>
                                <h5>포트폴리오 DB 모델링(JPG)</h5>
                                <p>
                                	본 포트폴리오의 DataBase 구조를 JPG파일로 확인하실 수 있습니다.
                                </p>
                                <p><button type="button" class="btn-e btn-e-primary btn-sm" data-toggle="modal" data-target="#myModal1">자세히 보기</button></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="icon-box icon-top selected">
                            <div class="icon-box-contain">
                                <i class="fa fa-file-pdf-o fa-primary"></i>
                                <h5>포트폴리오 DB 모델링(MWB)</h5>
                                <p>
                                	본 포트폴리오의 DataBase 구조를 MWB파일로 확인하실 수 있습니다.
                                </p>
                                <p><a href="<c:url value='/file/downloadErd.do' />" ><button type="button" class="btn-e btn-e-primary btn-sm">다운로드</button></a></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="icon-box icon-top selected">
                            <div class="icon-box-contain">
                                <i class="fa fa-chain-broken fa-primary"></i>
                                <h5>포트폴리오 소개서<br/>(PowerPoint)</h5>
                                <p>
                                	본 포트폴리오를 만들기위한 교육과정, 화면 설계 및 구현 내역들을 확인하실 수 있습니다.
                                </p>
                                <p><a href="<c:url value='/file/downloadPowerPoint.do' />" ><button type="button" class="btn-e btn-e-primary btn-sm">다운로드</button></a></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3 col-sm-6">
                        <div class="icon-box icon-top selected">
                            <div class="icon-box-contain">
                                <i class="fa fa-gear fa-primary"></i>
                                <h5>구현에 사용한 사항들<br/>(JPG)</h5>
                                <p>
                                	본 포트폴리오 개발에 활용한 언어 및 툴 들을 JPG파일로 정리하였습니다.
                                </p>
                                <p><button type="button" class="btn-e btn-e-primary btn-sm" data-toggle="modal" data-target="#myModal4">자세히 보기</button></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- END - Contain Wrapp -->

	<br/>
	
	<!-- modal 내용 -->
	<div class="modal fade" id="myModal1" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" ><span aria-hidden="true">X</span></button>
                <h6 class="modal-title">포트폴리오  DB 모델링(JPG)</h6>
            </div>
            <div class="modal-body">
                <p>
                    <img id="erdImage" src="<c:url value='/resources/erd.jpg' />" style="width:100%;"/>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-e btn-e-default btn-sm" data-dismiss="modal">닫기</button>
            </div>
        </div>
  	</div>
	</div>
		<div class="modal fade" id="myModal2" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" ><span aria-hidden="true">X</span></button>
                <h6 class="modal-title">포트폴리오  DB 모델링(MWB)</h6>
            </div>
            <div class="modal-body">
                <p>
                    <img id="erdImage" src="<c:url value='/resources/erd.jpg' />" style="width:100%;"/>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-e btn-e-default btn-sm" data-dismiss="modal">닫기</button>
                <a href="javascript:movePage('/file/downloadErd.do', {pageName:'devNote'})" >
                	<button type="button" class="btn-e btn-e-primary btn-sm">다운로드</button>
                </a>
            </div>
        </div>
  	</div>
	</div>
		<div class="modal fade" id="myModal3" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" ><span aria-hidden="true">X</span></button>
                <h6 class="modal-title">자주 발생한 에러노트(에버노트)</h6>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-e btn-e-default btn-sm" data-dismiss="modal">닫기</button>
                <a href="<c:url value='/file/downloadNote.do' />" >
                <button type="button" class="btn-e btn-e-primary btn-sm">다운로드</button></a>
            </div>
        </div>
  	</div>
	</div>
		<div class="modal fade" id="myModal4" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" ><span aria-hidden="true">X</span></button>
                <h6 class="modal-title">포트폴리오 개발 언어 및 툴(JPG)</h6>
            </div>
            <div class="modal-body">
                <p>
                	<img id="erdImage" src="<c:url value='/resources/useTool.jpg' />" style="width:100%;"/>
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn-e btn-e-default btn-sm" data-dismiss="modal">닫기</button>
            </div>
        </div>
  	</div>
	</div>
</body>
</html>