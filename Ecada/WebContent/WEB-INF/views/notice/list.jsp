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
		
		// Enter event 
		$('#searchText').keydown(function(e) {
			e.preventDefault();
			if(e.keyCode == 13) {
				search();
			}
		});

		
		// 검색버튼 클릭
		$('#btnSearch').click(function(){
			search();
		});
	});
	
	function search() {
		var searchType = $('#searchType option:selected').val();
		var searchText = $('#searchText').val();
		
		if(searchText == ''){
			alert("검색어를 입력하세요.");
			return;
		}
		if(searchText.length < 2){
			alert("두 글자 이상 입력하세요.");
			return;
		}
		
		var data = {searchType : searchType,
								searchText : searchText,
								pageName : "search"
		}
		
		movePage(null, "/notice/list.do", data);
	}
</script>
</head>
<body>
	<!-- START - Contain Wrapp -->
	<div class="contain-wrapp">
	    <div class="container">
	        <div class="row">
	            <div class="col-xs-12">
                <div style="float:left;">
                	<h4>공지사항</h4>
                </div>
                <div>
	                <form name="searchForm" method="get" align="right">
										<select id="searchType" name="searchType" title="선택메뉴">
											<option value="1" selected="selected">전체</option>
											<option value="2">제목</option>
											<option value="3">내용</option>
										</select>
										<input type="text" id="searchText" name="searchText" title="검색어 입력박스" class="input_100" /> 
										<input type="button" id="btnSearch" value="검색" title="검색버튼" class="btn-e btn-e-primary btn-sm" />
									</form>
								</div>
	                <table class="table table-bordered">
	                	<colgroup>
	                		<col width="10%"/>
	                		<col width="55%" />
	                		<col width="10%" />
	                		<col width="10%"/>
	                		<col width="15%" />
	                	</colgroup>
	                    <thead>
	                        <tr>
	                            <th class="text-center">글번호</th>
	                            <th class="text-center">제목</th>
	                            <th class="text-center">작성자</th>
	                            <th class="text-center">조회수</th>
	                            <th class="text-center">작성일</th>
	                        </tr>
	                    </thead>
	                    <tbody>
	                    	<c:forEach items="${list}" var="i">
                    			<tr>
		                        <td align="center">${i.boardSeq}</td>
		                        <td><a href="javascript:movePage(null, '/notice/read.do', {boardSeq:'${ i.boardSeq }', page:'${currentPage}', pageName:'noticeRead'})">${i.title}</a></td>
		                        <td align="center">${i.memberNick }</td>
		                        <td align="center">${i.hits }</td>
		                        <td align="center">${i.createDate }</td>
                     	 		</tr>
	                    	</c:forEach>
	                    </tbody>
	                </table>
	                <div class="row">
					    <div class="col-md-12">
						    <nav>
							    <ul class="pagination pagination-center">
								    <c:if test='${currentPage > blockSize}'>
							        <li>
							        	<a href="javascript:movePage(null, '/notice/list.do', {page:'${startBlockNo-blockSize}', searchText:'${searchText}', searchType:'${searchType}', pageName:'notice'})" aria-label="Previous"><span aria-hidden="true">«</span></a>
							        </li>
								   	</c:if>
							        
						        <c:forEach begin="${startBlockNo}" end="${endBlockNo}" step="1" var="p" >
						        	<c:choose>
						        		<c:when test="${currentPage eq p}">
							        		<li class="active"><a href="#">${p}</a></li>
						        		</c:when>
						        		<c:otherwise>
						        			<li><a href="javascript:movePage(null, '/notice/list.do', {page:'${p}', searchText:'${searchText}', searchType:'${searchType}', pageName:'notice'})">${p}</a></li>
						        		</c:otherwise>
						        	</c:choose>
						        </c:forEach>
						        
						        <c:if test='${totalPage != endBlockNo}'>
							        <li>
							        	<a href="javascript:movePage(null, '/notice/list.do', {page:'${endBlockNo+1}', searchText:'${searchText}', searchType:'${searchType}', pageName:'notice'})" aria-label="Next"><span aria-hidden="true">»</span></a>
							        </li>
						        </c:if>
							    </ul>
							</nav>
					    </div>
					</div>
					<c:if test='${sessionScope.memberId != null }'>
						<div class="row">
						    <div class="col-md-12 text-right">
						    	<a href="javascript:movePage(null, '/notice/goWrite.do', {page:'${currentPage}', pageName:'noticeWrite'})">
						        <button type="button" class="btn btn-default"><i class="fa fa-pencil"></i>&nbsp;글작성</button></a>
						    </div>
						</div>
					</c:if>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- END - Parallax -->
</body>
</html>