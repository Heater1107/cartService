<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="mypage_wrap">
    <div class="lnbWrap">
        <h2 class="pageTitle">마이롯데</h2>
        <ul>
            <li>
                <div class="lnbTitle">주문/배송</div>
                <ul>
                    <li><a href="#">주문/배송 내역</a></li>
                </ul>
            </li>
            <li>
                <div class="lnbTitle">취소/교환/반품</div>
                <ul>
                    <li><a href="#">취소/교환/반품 내역</a></li>
                </ul>
            </li>
            <li>
                <div class="lnbTitle">나의 정보 관리</div>
                <ul>
                    <li><a href="#">나의 리뷰</a></li>
                    <li><a href="/buyer/wish">나의 찜</a></li>
                    <li><a href="#">회원정보 관리</a></li>
                </ul>
            </li>
            <li>
                <div class="lnbTitle">나의 문의 내역</div>
                <ul>
                    <li><a href="#">1:1 문의 내역</a></li>
                </ul>
            </li>
        </ul>
        <div class="customerInfo">
            <div class="title">
                롯데ON 고객센터
            </div>
            <div class="tell"><span class="number">1899-7000</span></div>
            <div class="workingTime">
                월~금요일 09:00 ~ 18:00<br>
                주말, 공휴일 휴무
            </div>
        </div>
        <div class="adWrap">
            <a href="#">고객센터</a>
            <a href="#">1:1 문의하기</a>
        </div>
    </div>
    <div class="rightWarp">
	    <div class="memberInner">
	        <div class="profileWrap">
	            <button>
	                <div class="faceWrap">
	                    <img src="${pageContext.request.contextPath}/img/img_profile_default.svg" alt="프로필 관리" class="loaded">
	                    <div class="btnEdit">
	                        프로필<br >수정<img src="#" alt="">
	                    </div>
	                </div>
	            </button>
	            <div class="nicknameWrap">
	                <p  class="infoWord">쇼핑하기 좋은 날 이에요!</p>
	                <div class="nickname">
	                    <a href="/mypage">
	                        <strong >홍길동</strong>님
	                    </a>
	                </div>
	            </div>
	        </div>
	    </div>
	    <div class="contentInner">
	    	<c:import url="${subContentPage}"></c:import>
    </div>
    </div>
</div>