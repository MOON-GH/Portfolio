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
		
		$('#btnUpdate').on('click', function(){
			if("${sessionScope.memberId}" != null) {	// 로그인 유무 체크
				if(("${sessionScope.memberId}" == "${getBoard.memberId}") || "${sessionScope.typeSeq}" == "9"){		// 작성자확인 및 관리자 체크
					var frm = document.writeForm;
					var title = $('#title').val();
					
					if(title.length == 0){
						alert("제목을 입력하세요.");
						$('#title').focus();
						return;
					}
					
					frm.contents.value = ckEditor.getData();
					var contents = ckEditor.getData();
					if(contents == '<p>&nbsp;</p>') {
						alert("내용을 입력해주세요.");
						$('#contents').focus();
						return;
					}
					
					var attachedFile = frm.attachedFile.value;
		      var fileType = attachedFile.substring(attachedFile.lastIndexOf("."), attachedFile.length);
		      if(attachedFile != ""){
		          if(fileType.match(/.exe/i) || fileType.match(/.sh/i) || fileType.match(/.bat/i)){
		              alert(".exe / .sh / .bat 형식의 파일은 첨부하실 수 없습니다.");
		              return;
		          }else if(!fileType.match(/.doc/i) && !fileType.match(/.txt/i) && !fileType.match(/.xlsx/i) &&
		                  !fileType.match(/.jpg/i) && !fileType.match(/.png/i) && !fileType.match(/.pdf/i)
		                   && !fileType.match(/.docx/i) && !fileType.match(/.xls/i)){
		              alert("사용할 수 없는 확장자 입니다.");
		              console.log(fileType);
		              return;
		          }
		      }
	
		   		// overlay 보이기
					$("#loading-div-background").css({'z-index' : '9999'}).show();
		      var formData = new FormData(frm);
					$.ajax({
						url : "<c:url value='/board/update.do' />",
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
					        movePage(this, "/board/read.do", {boardSeq:'${getBoard.boardSeq}', update:'update', pageName:'boardRead'});
						    } else {
				          window.location.href="<c:url value='/index.do'/>";
						    }
				        
				        $("#loading-div-background").hide();	// overlay 숨기기
						},error : function (XMLHttpRequest, textStatus, errorThrown) {
								$("#loading-div-background").hide();	// overlay 숨기기
								alert(data.msg);
						}
					});
				} else {
					alert("작성자만 삭제할 수 있습니다.");
				}
			} else {
				alert("다시 로그인해주세요.");
				movePage(this, "/home.do", {pageName:'home'});
			}
		});
	});
	
	function deleteAttach(fileIdx, boardSeq) {
		$.ajax({
			url : "<c:url value='/board/deleteAttach.do' />",
			data : {fileIdx: fileIdx, boardSeq: boardSeq},
			type : 'POST',
			success : function (data, textStatus, XMLHttpRequest) {
		        console.log("data : " + data);
		        alert(data.msg);

		        if(data.result){
			        movePage(this, "/board/goUpdate.do", {boardSeq:'${getBoard.boardSeq}', pageName:'boardUpdate'});
				    } else {
		          window.location.href="<c:url value='/index.do'/>";
				    }
			},
			error : function (XMLHttpRequest, textStatus, errorThrown) {
				alert(data.msg);
			}
		});
	}
</script>
</head>
<body>
	<!-- START - Contain Wrapp -->
	<div class="contain-wrapp">
	    <div class="container">
	        <div class="row">
	            <div class="col-xs-12">
	                <h3>자유게시판</h3></br>
                    <form name="writeForm" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="hasFile" value="${getBoard.hasFile}" />
		                <table class="table table-bordered">
		                	<colgroup>
		                		<col width="20%"/>
		                		<col width="80%" />
		                	</colgroup>
	                    <thead>
	                    </thead>
	                    <tbody>
	                    <div class="col-sm-1">
					        		<i class="glyphicon glyphicon-pencil"></i>&nbsp;<label for="exampleInputName2">글번호</label>
	                    	<textarea class="form-control" name="boardSeq" rows="1" cols="3" readonly="readonly">${getBoard.boardSeq}</textarea>
	                    </div>
	                    <div class="col-sm-5">
					        		<i class="glyphicon glyphicon-pencil"></i>&nbsp;<label for="exampleInputName2">제 목</label>
	                    	<textarea class="form-control" id="title" name="title" rows="1" cols="3">${getBoard.title}</textarea>
	                    </div>
	                    <div class="col-sm-3">
					        		<i class="glyphicon glyphicon-user"></i>&nbsp;<label for="exampleInputName2">작성자</label>
	                    	<textarea class="form-control" name="memberNick" rows="1" cols="3" readonly="readonly">${getBoard.memberNick}</textarea>
	                    </div>
	                    <div class="col-sm-3">
	                    	<i class="glyphicon glyphicon-calendar"></i>&nbsp;<label for="exampleInputName2">작성일자</label>
	                    	<c:choose>
			                    	<c:when test="${getBoard.updateDate != ''}">
				                    	<textarea class="form-control" rows="1" cols="3" readonly="readonly">${getBoard.createDate}</textarea>
			                    	</c:when>
		                    		<c:otherwise>
		                    			<textarea class="form-control" rows="1" cols="3" readonly="readonly">${getBoard.updateDate}</textarea>
		                    		</c:otherwise>
		                    	</c:choose>
	                    </div>
	                    <div class="col-sm-12">
	                    	<i class="glyphicon glyphicon-file"></i>&nbsp;<label for="exampleInputName2">내 용</label>
	                    	<div class="editer">
		                    	<textarea class="form-control" id="contents" name="contents">${getBoard.content}</textarea><br/>
		                    	<script>
																var chkEditor;
														    ClassicEditor
														    .create( document.querySelector( '#contents' ) )
														    .then( editor => {
														    	ckEditor = editor;
														    })
														    .catch( error => {
														    	console.error( error );
														    });
													</script>
												</div>
	                    </div>
	                    <div class="col-sm-12">
	                    	<i class="glyphicon glyphicon-link"></i>&nbsp;<label for="exampleInputName2">첨부파일</label><br/>
	                    	<c:forEach items="${files}" var="file" varStatus="vs">
	                    		${vs.count}.
													<a href="<c:url value='/board/download.do?fileIdx=${file.file_idx}'/>">
														${file.filename} (${file.file_size} bytes)
													</a>
													<a href="javascript:deleteAttach('${file.file_idx}','${getBoard.boardSeq}')">
														<input type="button" id="deleteAttach" value="삭제"/><br/>
													</a>
												</c:forEach>
												<c:forEach begin="1" end="${3 - files.size()}" step="1" var="cnt">
														${files.size() + cnt}.
														<input type="file" name="attachedFile" id="attachedFile"/><br/>
												</c:forEach>
	                    </div>
	                    </tbody>
	              	  </table>
	                </form>
								<c:if test='${sessionScope.memberId != null }'>
									<div class="row">
									    <div class="col-md-12 text-right">
								        <button type="button" id="btnUpdate" class="btn btn-default"><i class="fa fa-pencil"></i>&nbsp;수정완료</button>
								        <a href="javascript:movePage(this, '/board/list.do', {pageName:'board'})">
								        	<button type="button" class="btn btn-default"><i class="glyphicon glyphicon-th-list"></i>&nbsp;취소</button>
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