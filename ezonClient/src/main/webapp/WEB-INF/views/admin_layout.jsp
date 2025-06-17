<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<title>Ezon</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link href="${pageContext.request.contextPath}/css/common/base.css" rel="stylesheet" type="text/css">
	<link href="${pageContext.request.contextPath}/css/admin/layout.css" rel="stylesheet" type="text/css">
	<script src="${pageContext.request.contextPath}/js/common.js"></script>
</head>
<body>
	<div id="layout">
		<div class="layoutWrap">
			<!-- 레프트 메뉴 -->
			<jsp:include page="include/admin_menu.jsp"></jsp:include>
			<div class="content_wrap">
				<div class="content_inner">
					<!-- 헤더-->
					<jsp:include page="include/admin_header.jsp"></jsp:include>
					<!-- 컨텐츠 -->
					<div class="contents_box">
						<c:import url="${contentPage}" />
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>