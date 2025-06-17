<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Ezon</title>	
</head>
<body>
	<!-- 레프트 메뉴 -->
	<nav id="nav" class="aside_custom hard_state">
		<a href="/admin">
			<h1 class="aside_logo">
				<span class="logo_img on_blind"><img src="/img/logo.svg" alt="LOTTEON"></span> 
				<span class="text on_blind">관리자 센터</span>
			</h1>
		</a>
		<ul class="lnb_custom ui_accordion">
			<li>
				<a href="#">
					공지사항
				</a>
			</li>
			<li>
				<a href="#">
					사용자 관리
				</a>
			</li>
			<li>
				<a href="#">
					상품 관리
				</a>
			</li>
			<li>
				<a href="#">
					거래 내역
				</a>
			</li>
			<li>
				<a href="#">
					정산 관리
				</a>
			</li>
			<li>
				<a href="#">
					문의 관리
				</a>
			</li>
		</ul>
	</nav>
	<!-- // 레프트 메뉴 -->
</body>
</html>