<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<title>Ezon</title>
	<script src="${pageContext.request.contextPath}/js/seller/menu.js"></script>
</head>
<body>
	<!-- 레프트 메뉴 -->
	<nav id="nav" class="aside_custom hard_state">
		<a href="/seller">
			<h1 class="aside_logo">
				<span class="logo_img on_blind"><img src="/img/logo.svg" alt="LOTTEON"></span> 
				<span class="text on_blind">판매자 센터</span>
			</h1>
		</a>
		<ul class="lnb_custom ui_accordion">
			<li>
				<button type="button"class="on_blind">
					상품관리
				</button>
				<ul class="depth2">
					<li>
						<a href="#">
							상품등록
						</a>
					</li>
					<li>
						<a href="#">
							상품조회/수정
						</a>
					</li>
				</ul>
			</li>
			<li>
				<button type="button" class="on_blind">
					주문/배송관리
				</button>
				<ul class="depth2">
					<li>
						<a href="#">
							배송관리
						</a>
					</li>
					<li>
						<a href="#">
							반품관리
						</a>
					</li>
					<li>
						<a href="#">
							교환관리
						</a>
					</li>
					<li>
						<a href="#">
							주문취소 조회
						</a>
					</li>
				</ul>
			</li>
			<li>
				<button type="button" class="on_blind">
					정산관리
				</button>
				<ul class="depth2">
					<li>
						<a href="#">
							정산 예정금액 조회
						</a>
					</li>
					<li>
						<a href="#">
							정산 신청 내역
						</a>
					</li>
				</ul>
			</li>
			<li>
				<button type="button" class="on_blind">
					스토어관리
				</button>
				<ul class="depth2">
					<li>
						<a href="#">
							스토어 정보 관리
						</a>
					</li>
					<li>
						<a href="#">
							배송 정보 관리
						</a>
					</li>
				</ul>
			</li>
			<li>
				<button type="button"class="on_blind">
					고객관리
				</button>
				<ul class="depth2">
					<li>
						<a href="#">
							고객 문의
						</a>
					</li>
					<li>
						<a href="#">
							고객 리뷰
						</a>
					</li>
				</ul>
			</li>
		</ul>
	</nav>
	<!-- // 레프트 메뉴 -->
</body>
</html>