<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
        <!-- START - Contain Wrapp -->
        <div class="contain-wrapp padding-bottom-50">
            <div class="container">
                <div class="error-page text-center">
                    <h2 class="error-title">4<span class="primary">0</span>4</h2>
                    <h3 class="error-subtitle">Page Not Found</h3>
                    <p class="error-text center-block">The requested URL was not found on this server. That is all we know.</p>
                    <div class="form-group">
                        <a class="btn-e btn-e-primary" href="<c:url value='/index.do'/>">Back to Home</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- END - Contain Wrapp -->
</body>
</html>