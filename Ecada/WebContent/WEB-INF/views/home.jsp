<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<!-- START - Inner Head -->
	<div class="parallax inner-head">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<!-- <i class="fa fa-users"></i>  -->
					<h4>Welcome!!</h4>
				</div>
			</div>
		</div>
	</div>
	<!-- END - Inner Head -->
	<!-- START - Contain Wrapp -->
	<div class="contain-wrapp">
		<div class="container">
			<div class="row">
				<div class="col-xs-12">
					<div class="row">
						<div class="col-sm-6">
							<h5>공지사항</h5>
							<table class="table table-bordered">
								<colgroup>
									<col width="13%" />
									<col width="65%" />
									<col width="10%" />
									<col width="12%" />
								</colgroup>
								<thead>
									<tr>
										<th class="text-center">글번호</th>
										<th class="text-center">제목</th>
										<th class="hidden-sm text-center">글쓴이</th>
										<th class="text-center">조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${noticeList}" var="i">
										<tr>
											<td align="center">${i.boardSeq}</td>
											<td>
												<a href="javascript:movePage(null, '/notice/read.do', {boardSeq:'${ i.boardSeq }', pageName:'noticeRead'})">${i.title}</a>
											</td>
											<td>${i.memberNick }</td>
											<td align="center">${i.hits }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="text-right">
								<a href="javascript:movePage(null, '/notice/list.do', {page:'1', pageName:'list'})">[더보기]</a>
							</div>
						</div>
						<div class="col-sm-6">
							<h5>자유게시판</h5>
							<table class="table table-bordered">
								<colgroup>
									<col width="13%" />
									<col width="65%" />
									<col width="10%" />
									<col width="12%" />
								</colgroup>
								<thead>
									<tr>
										<th class="text-center">글번호</th>
										<th class="text-center">제목</th>
										<th class="hidden-sm text-center">글쓴이</th>
										<th class="text-center">조회수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${freeList}" var="i">
										<tr>
											<td align="center">${i.boardSeq}</td>
											<td>
												<a href="javascript:movePage(null, '/board/read.do', {boardSeq:'${i.boardSeq}', pageName:'boardRead'})">${i.title}</a>
											</td>
											<td>${i.memberNick }</td>
											<td align="center">${i.hits }</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<div class="text-right">
								<a
									href="javascript:movePage(null, '/board/list.do', {page:1, pageName:'board'})">[더보기]</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- END - Parallax -->
</body>
</html>