<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ezon</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link href="${pageContext.request.contextPath}/css/common/base.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/buyer/layout.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
	<div id="layout">
	    <!-- 구매자 헤더 -->
	    <%@ include file="include/buyer_header.jsp" %>
		
		<div class="content_wrap">
		    <div class="content">
		        <c:import url="${contentPage}" />
		    </div>
		</div>
	
	    <!-- 구매자 푸터 -->
	    <%@ include file="include/buyer_footer.jsp" %>
	</div>
</body>
</html>