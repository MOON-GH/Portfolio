<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
	<meta name="keywords" content="corporate html template - agency theme - business html template - creative theme - portfolio html template - gallery theme - restaurant theme - ecommerce template - app template - landing page - real estate theme">
	<meta name="description" content="Bootstrap HTML5 template for agency, corporate, business, app and creative portfolio, it is suitable for any kind of websites, like ecommerce, restaurant, photography, gallery and retail website.">
	<meta name="author" content="encodeslife">
	<link rel="icon" href="<c:url value="/resources/img/favicon.png" />">
	
	<title>MO_ON</title>
	
	<!-- BOOTSTRAP -->
	<link href="<c:url value="/resources/js/bootstrap/css/bootstrap.min.css" />" rel="stylesheet">
	
	<!-- CUSTOM STYLES -->
	<link href="<c:url value="/resources/css/style.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/common.css" />" rel="stylesheet">
	
	<!-- THEME SKINS -->
	<link id="skin" href="<c:url value="/resources/css/theme-colors/dark-blue.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/js/style-switcher/css/style-switcher.css" />" rel="stylesheet">
	<link href="<c:url value="/resources/css/line-icons/line-icons.css" />" rel="stylesheet">
	
	<!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	    <script src="<c:url value="/resources/js/html5shiv.min.js" />"></script>
	    <script src="<c:url value="/resources/js/respond.min.js" />"></script>
	<![endif]-->
	
	<!--[if IE 9]>
	    <link href="<c:url value="/resources/css/ie.css" />" rel="stylesheet">
	<![endif]-->
	
	<!-- jQuery -->
	<script src="<c:url value="/resources/js/jquery.min.js" />"></script>
	
	<!-- BOOTSTRAP -->
	<script src="<c:url value="/resources/js/bootstrap/js/bootstrap.min.js" />"></script>
	
	<!-- jQuery Easing -->
	<script src="<c:url value="/resources/js/jquery.easing-1.3.min.js" />"></script>
	
	<script src="<c:url value="/resources/js/common.js" />"></script>
	
	<!-- ckEditor -->
	<script src="<c:url value="/resources/js/ckeditor/ckeditor.js" />"></script>
	
	<script type="text/javascript" >
		var ctx = '<%= request.getContextPath() %>';
		
    $(document).ready(function() {
    	movePage(null, "/home.do", {pageName:'home'});
    	
    	$('#home').attr("class", "active");
    	
	    $(window).bind("popstate", function(event) {
	      var data = event.originalEvent.state;  // 이부분으로 뒤로가기 할때마다 아까 저장한 히스토리 스택에 쌓인 URL을 불러 온다
	      console.log('params : ' + data.params);
	      if(data){ // 데이터가 있으면 해당 데이터를 ajax로 다시 요청해 화면에 뿌려준다
	    	  data.params.moveBack='back';
	      	movePageBack(null, data.url, data.params);
	      } else {	// 히스토리에 정보가 없을경우 메인화면으로 보내준다.
	      	$(location).attr('href', "<c:url value='/index.do' />");
	      }
	   	});
    });
	</script>
	
	<!-- Parallax -->
	<script src="<c:url value="/resources/js/parallax/jquery.parallax-1.1.3.js" />"></script>
	<script src="<c:url value="/resources/js/parallax/setting.js" />"></script>
	
	<!-- Custom javaScript for this theme -->
	<script src="<c:url value="/resources/js/custom.js" />"></script>
	
	<!-- Nicescroll -->
	<script src="<c:url value="/resources/js/nicescroll/jquery.nicescroll.min.js" />"></script>
	<script src="<c:url value="/resources/js/nicescroll/settings.js" />"></script>
	
	<!-- Theme option-->
	<script src="<c:url value="/resources/js/style-switcher/js/style-switcher.js" />"></script>
</head>
	<body>
        <!-- START - Top area -->
        <div class="top-container">
            <div class="container">
                <div class="top-column-left">
                    <ul class="contact-line">
                        <li><i class="fa fa-envelope"></i> dev.moongh@gmail.com</li>
                        <li><i class="fa fa-phone"></i> 010-4287-8584</li>
                    </ul>
                </div>
                <div class="top-column-right">
                	<%--
                    <div class="top-social-network">
                        <a href="#"><i class="fa fa-facebook"></i></a>
                        <a href="#"><i class="fa fa-twitter"></i></a>
                        <a href="#"><i class="fa fa-google-plus"></i></a>
                        <a href="#"><i class="fa fa-linkedin"></i></a>
                        <a href="#"><i class="fa fa-instagram"></i></a>
                    </div>
                	 --%>
                	 	<c:if test="${sessionScope.memberId != null}">
		                	<ul class="register">
		                		<li>${sessionScope.memberNick} 님 환영합니다.</li>
		                	</ul>
	                	</c:if>
                    <ul class="register">
                    	<%--
                        <li class="dropdown language" style="display: block;">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-globe"></i> Languages</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">English <i class="fa fa-check"></i></a></li>
                                <li><a href="#">Spanish</a></li>
                                <li><a href="#">Russian</a></li>
                                <li><a href="#">German</a></li>
                            </ul>
                        </li>
                        <li><a href="page_faq.html">Help</a></li>
                       --%>
	                    <li>
	                    <c:choose>
	                    	<c:when test='${sessionScope.memberId != null}'>
	                    		<a href="<c:url value='/member/logout.do'/>">로그아웃</a>
	                    	</c:when>
	                    	<c:otherwise>
	                    		<a href="javascript:movePage(this, '/member/goRegisterPage.do', {pageName:'register'})">회원가입</a> | 
		                    	<a href="javascript:movePage(this, '/member/goLoginPage.do', {pageName:'login'})">로그인</a>
	                    	</c:otherwise>
	                    </c:choose>
	                    </li>
                    </ul>
                </div>
            </div>
        </div>
        <!-- END - Top area -->

        <div class="clearfix"></div>
        
		<!-- START - Navbar -->
		<nav class="navbar navbar-default navbar-white megamenu">
		    <div class="container">
		
		        <!-- Brand and toggle get grouped for better mobile display -->
		        <div class="navbar-header">
		            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
		                <i class="fa fa-bars"></i>
		            </button>
		            <a class="navbar-brand logo" href="<c:url value='/index.do'/>">
		                <img src="<c:url value="/resources/img/themes/logo_full_moon.png" />" alt="Logo" />
		            </a>
		        </div>
		
		        <!-- Collect the nav links, forms, and other content for toggling -->
		        <div class="collapse navbar-collapse" id="navbar-menu">
		            <ul class="nav navbar-nav navbar-right">
		                <li id="home">
		                    <a href="javascript:movePage(this, '/home.do', {pageName:'home'});" class="dropdown-toggle" data-toggle="dropdown">Home</a>
		                </li>
		                <li>
		                    <a href="javascript:movePage(this, '/notice/list.do', {pageName:'notice'});" class="dropdown-toggle" data-toggle="dropdown">공지사항</a>
		                </li>
		                <li>
		                    <a href="javascript:movePage(this, '/board/list.do', {pageName:'board'});" class="dropdown-toggle" data-toggle="dropdown">자유게시판</a>
		                </li>
		                <li>
		                    <a href="javascript:movePage(this, '/pageDevNote.do', {pageName:'devNote'});" class="dropdown-toggle" data-toggle="dropdown">개발노트</a>
		                </li>
		                <c:if test='${sessionScope.memberId != null}'>
			                <li>
			                	<a href="javascript:movePage(this, '/pageContact.do', {pageName:'contact'});">Contact</a>
			                </li>
		                </c:if>
		            </ul>
		        </div>
		    </div>
		</nav>
		<!-- END - Navbar -->
        
        <div id="contentDiv"></div>

        <div class="clearfix"></div>

        <!-- START - Footer -->
        <footer>
            <div class="container">
                        <div class="footer-description">
                            <img class="footer-logo" src="<c:url value="/resources/img/themes/logo_half_moon.png" />" alt="Footer logo" />
                            <span>Info</span>
                            <div class="widget" id="text-footer">
                                <p>이 페이지는 아래 항목을 이용하여 구현하였습니다.</p>
                            </div>
                        </div>
                        <div class="footer-details">
                            <ul class="list-unstyled footer-list">
                                <li><i class="fa fa-angle-double-right"></i>OS : Windows 10 64bit</li>
                                <li><i class="fa fa-angle-double-right"></i>SDK : 1.8.4</li>
                                <li><i class="fa fa-angle-double-right"></i>IDE : Eclipse Oxygen</li>
                            </ul>
                            <ul class="list-unstyled footer-list">
                                <li><i class="fa fa-angle-double-right"></i>Test/Build : jUnit / Maven</li>
                                <li><i class="fa fa-angle-double-right"></i>형상관리도구 : SVN</li>
                                <li><i class="fa fa-angle-double-right"></i>DBMS : MYSQL 8.0.11</li>
                            </ul>
                            <ul class="list-unstyled footer-list">
                                <li><i class="fa fa-angle-double-right"></i>WAS : Tomcat 8.5</li>
                                <li><i class="fa fa-angle-double-right"></i>Framework : Spring 4.3.14.RELEASE</li>
                                <li><i class="fa fa-angle-double-right"></i>MyBatis 3.4.1</li>
                            </ul>
                            <ul class="list-unstyled footer-list">
                                <li><i class="fa fa-angle-double-right"></i>AWS t2.micro free tier</li>
                                <li><i class="fa fa-angle-double-right"></i>OS : Ubuntu 16.04.5 LTS</li>
                                <li><i class="fa fa-angle-double-right"></i>MYSQL 5.7 Server</li>
                            </ul>
                        </div>
                <div class="row">
                    <div class="col-md-8">
                    </div>
                    <%-- 
                    <div class="col-md-4">
                        <h5>Newsletter</h5>
                        <p>Subscribe to our newsletter to get important news, amazing offers & inside scoops:</p>
                        <!-- START - Subscribe -->
                        <div class="input-group margin-bottom-20">
                            <input type="text" class="form-control" placeholder="Enter your email address...">
                            <span class="input-group-btn">
                                <button class="btn-e btn-e-primary" type="button"><i class="fa fa-send-o"></i></button>
                            </span>
                        </div>
                        <!-- END - Subscribe -->
                        <div class="footer-social-networks">
                            <a href="#"><i class="fa fa-facebook fa-2x icon-square"></i></a>
                            <a href="#"><i class="fa fa-twitter fa-2x icon-square"></i></a>
                            <a href="#"><i class="fa fa-google-plus fa-2x icon-square"></i></a>
                            <a href="#"><i class="fa fa-instagram fa-2x icon-square"></i></a>
                            <a href="#"><i class="fa fa-linkedin fa-2x icon-square"></i></a>
                        </div>
                    </div>
                    --%>
                </div>
            </div>
            <div class="subfooter">
                <div class="container">
                    <div class="row" style="text-align:center;">
                       <p><a href="#">Ecada</a> &copy; 2018 - All rights reserved. | last update. 2018. 12. 10</p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- END - Footer -->

        <!-- START - to top -->
        <a href="#" class="toTop">
            <i class="fa fa-chevron-up"></i>
        </a>
        <!-- END - to top -->
    </body>
</html>