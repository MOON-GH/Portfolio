<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
	$(document).ready(function(){
		var msg = '${ msg }';
		if(msg != '') {
			alert(msg);
		}
		
		// 게시글 수정페이지 이동 click 이벤트
		$('#btnUpdate').on('click', function(){
			if("${sessionScope.memberId}" != null) {	// 로그인 유무 체크
				if(("${sessionScope.memberId}" == "${getBoard.memberId}") || "${sessionScope.typeSeq}" == "9"){		// 작성자확인 및 관리자 체크
					
					if(confirm("수정하시겠습니까?")) movePage(this, "/notice/goUpdate.do", {boardSeq:'${getBoard.boardSeq}', pageName:'noticeUpdate'});
				} else {
					alert("작성자만 수정할 수 있습니다.");
				}
			} else {
				alert("다시 로그인해주세요.");
				movePage(this, "/home.do", {pageName:'home'});
			}
		});
		
		// 게시글 삭제 click 이벤트
		$('#btnDelete').on('click', function(){
			
			if("${sessionScope.memberId}" != null) {	// 로그인 유무 체크
				if(("${sessionScope.memberId}" == "${getBoard.memberId}") || "${sessionScope.typeSeq}" == "9"){		// 작성자확인 및 관리자 체크
					
			   	if(confirm("게시글을 삭제하시겠습니까?")) customAjax("<c:url value='/notice/delete.do' />", "/notice/list.do?page=${page}");
				} else {
					alert("작성자만 삭제할 수 있습니다.");
				}
			} else {
				alert("다시 로그인해주세요.");
				movePage(this, "/home.do", {pageName:'home'});
			}
		});
	});
	
	// 게시글 삭제 ajax function
	function customAjax(url, movePageUrl){
		if("${sessionScope.memberId}" != null) {
			// overlay 보이기
			$("#loading-div-background").css({'z-index' : '9999'}).show();
			var frm = document.readForm;
			var formData = new FormData(frm);
		
			$.ajax({
				url : url,
				data : formData,
				type : 'POST',
				dataType : "text",
				processData : false,
				contentType : false,
				success : function (result, textStatus, XMLHttpRequest) {
					    var data = $.parseJSON(result);
			        console.log("data : " + data);
			        alert(data.msg);
			        
					    if(data.result == 1){
				        movePage(this, movePageUrl, {pageName:'notice'});
					    }
					    
					    $("#loading-div-background").hide();	// overlay 숨기기
				},
				error : function (XMLHttpRequest, textStatus, errorThrown) {
			  	$("#loading-div-background").hide();	// overlay 숨기기
					alert(data.msg);
				}
			});
		} else {
			alert("다시 로그인해주세요.");
			movePage(this, "/home.do", {pageName:'home'});
		}
	}
</script>
</head>
<body>
	<!-- START - Contain Wrapp -->
	<div class="contain-wrapp">
	    <div class="container">
	        <div class="row">
	            <div class="col-xs-12">
               	<h3>공지사항</h3><br/>
	               <form name="readForm" method="post" enctype="multipart/form-data">
	               	<table class="table table-bordered">
		                	<colgroup>
		                		<col width="20%"/>
		                		<col width="80%"/>
		                	</colgroup>
                    <thead>
                    </thead>
                    <tbody>
                    <div class="tab-default">
                    	<ul class="nav nav-tabs">
                    		<div class="col-sm-1">
						        			<i class="glyphicon glyphicon-pencil"></i>&nbsp;<label for="exampleInputName2">글번호</label>
		                    	<textarea class="form-control" name="boardSeq" rows="1" cols="3" readonly="readonly" style="background-color:#fff">${getBoard.boardSeq}</textarea>
		                    </div>
		                    <div class="col-sm-4">
						      			  <i class="glyphicon glyphicon-pencil"></i>&nbsp;<label for="exampleInputName2">제 목</label>
		                    	<textarea class="form-control" rows="1" cols="3" readonly="readonly" style="background-color:#fff">${getBoard.title}</textarea>
		                    </div>
		                    <div class="col-sm-3">
						        			<i class="glyphicon glyphicon-user"></i>&nbsp;<label for="exampleInputName2">작성자</label>
		                    	<textarea class="form-control" rows="1" cols="3" readonly="readonly" style="background-color:#fff">${getBoard.memberNick}</textarea>
		                    </div>
		                    <div class="col-sm-1">
						        			<i class="glyphicon glyphicon-check"></i>&nbsp;<label for="exampleInputName2">조회수</label>
		                    	<textarea class="form-control" rows="1" cols="3" readonly="readonly" style="background-color:#fff">${getBoard.hits}</textarea>
		                    </div>
		                    <div class="col-sm-3">
		                    	<i class="glyphicon glyphicon-calendar"></i>&nbsp;<label for="exampleInputName2">작성일자</label>
	                    		<c:choose>
			                    	<c:when test="${getBoard.updateDate != ''}">
				                    	<textarea class="form-control" rows="1" cols="3" readonly="readonly" style="background-color:#fff">${getBoard.createDate}</textarea>
			                    	</c:when>
		                    		<c:otherwise>
		                    			<textarea class="form-control" rows="1" cols="3" readonly="readonly" style="background-color:#fff">${getBoard.updateDate}</textarea>
		                    		</c:otherwise>
		                    	</c:choose>
		                    </div>
	                      <i class="glyphicon glyphicon-file" style="margin-left: 15px;margin-top: 20px;"></i>&nbsp;<label for="exampleInputName2">내 용</label>
		                    <div class="contentBox">
	                      	${getBoard.content}
	                      </div>
                      </ul>
                     
	                    <c:if test="${!empty files}">
		                    <div class="col-sm-12" style="margin-top: 10px;">
		                    	<i class="glyphicon glyphicon-link"></i>&nbsp;<label for="exampleInputName2">첨부파일</label><br/>
	  	                  		<c:forEach items="${files}" var="file" varStatus="vs">
	    	                			${vs.count}.
			  	                  	<c:choose>
																<c:when test="${file.linked == 0}">
																	${file.filename} (서버에 파일을 찾을 수 없습니다.)<br/>
																</c:when>
																<c:otherwise>
																	<a href="<c:url value='/notice/download.do?fileIdx=${file.file_idx}'/>">
																		${file.filename} (${file.file_size} bytes)
																	</a><br/>
																</c:otherwise>
															</c:choose>
														</c:forEach>
		                    </div>
											</c:if>
	                   </div>
                    </tbody>
	                </table>
               	</form>
               	
								<c:if test='${sessionScope.memberId != null }'>
									<div class="row">
								    <div class="col-md-12 text-right">
							        <button type="button" id="btnUpdate" class="btn btn-default"><i class="fa fa-pencil"></i>&nbsp;수정</button>
							        <button type="button" id="btnDelete" class="btn btn-default"><i class="glyphicon glyphicon-trash"></i>&nbsp;삭제</button>
							        <a href="javascript:movePage(null, '/notice/list.do', {page:'${page}', pageName:'list'})">
							        	<button type="button" class="btn btn-default">
							        	<i class="glyphicon glyphicon-th-list"></i>&nbsp;목록</button>
							        </a>
								    </div>
									</div>
								</c:if>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- END - Parallax -->
	
	<!-- overlay html start -->
	<div id="loading-div-background">
	      <div id="loading-div" class="ui-corner-all">
	           <img style="height:32px;width:32px;margin:30px;" src="<c:url value='/resources/img/please_wait.gif'/>" alt="Loading.."/>
	           <br>
	           	처리중. 잠시만 기다려주세요...
	      </div>
	</div>
	<!-- overlay html end -->
</body>
</html>