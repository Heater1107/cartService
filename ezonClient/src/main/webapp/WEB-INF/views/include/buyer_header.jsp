<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<head>
    <script src="${pageContext.request.contextPath}/js/buyer/header_category.js"></script>
</head>
<body>
	<div class="headerWrapper">
	    <div class="util innerContent">
	        <div class="accountArea">
	            <ul>
	                <c:choose>
					    <c:when test="${empty username}">
					        <li><a href="/login">로그인/회원가입</a></li>
					    </c:when>
					    <c:otherwise>
					        <li><a href="#">${username}님 환영합니다.</a></li>
					        <li><a href="#">로그아웃</a></li>
					        <c:choose>
					            <c:when test="${role == 'SELLER'}">
					                <li><a href="/seller">판매자 센터 바로가기</a></li>
					            </c:when>
					            <c:when test="${role == 'ADMIN'}">
					                <li><a href="/admin">관리자 센터 바로가기</a></li>
					            </c:when>
					        </c:choose>
					    </c:otherwise>
					</c:choose>
	                <li><a href="#">주문배송</a></li>
	                <li><a href="#">고객센터</a></li>
	                <li><a href="/seller">판매자 센터 바로가기</a></li>
					<li><a href="/admin">관리자 센터 바로가기</a></li>
	            </ul>
	        </div>
	    </div>
	    <div class="main innerContent">
	        <h1 class="logoArea"><a href="/"></a></h1>
	        <div class="searchAreaWrap">
	            <div class="searchArea">
	                <label for="headerSearchId" class="blind">검색어</label>
	                <input title="검색어 입력" id="headerSearchId" type="search" placeholder="검색어를 입력하세요">
	                <button class="btnSearchInner">
	                    <span class="blind">검색</span>
	                </button>
	            </div>
	        </div>
	        <div class="buttonArea">
	            <ul>
	                <li>
	                    <a href="/buyer/wish" class="heart">나의 찜</a>
	                </li>
	                <li>
	                    <a href="/buyer/myPage" class="my">마이롯데</a>
	                </li>
	                <li>
	                    <a href="/buyer/cart" class="cart">장바구니</a>
	                </li>
	            </ul>
	        </div>
	    </div>
	    <div class="sub">
	        <div class="innerContent">
	            <div class="category on">
	                <div class="menu">
	                    <ul class="menuInner">
	                        <li>
	                            <a><span>패션</span></a>
	                            <div class="depth2" style="display: none;">
	                                <ul>
	                                    <li>
	                                        <a href=""><span>의류</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>가방/지갑</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>신발</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>패션잡화</span></a>
	                                    </li>
	                                </ul>
	                            </div>
	                        </li>
	                        <li>
	                            <a><span>생활/건강</span></a>
	                            <div class="depth2" style="display: none;">
	                                <ul>
	                                    <li>
	                                        <a href=""><span>생활용품</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>의류</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>의류</span></a>
	                                    </li>
	                                </ul>
	                            </div>
	                        </li>
	                        <li>
	                            <a><span>가전</span></a>
	                            <div class="depth2" style="display: none;">
	                                <ul>
	                                    <li>
	                                        <a href=""><span>TV/영상가전</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>생활가전</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>주방가전</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>계절가전</span></a>
	                                    </li>
	                                </ul>
	                            </div>
	                        </li>
	                        <li>
	                            <a><span>반려동물</span></a>
	                            <div class="depth2" style="display: none;">
	                                <ul>
	                                    <li>
	                                        <a href=""><span>강아지용품</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>고양이용품</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>관상어용품</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>조류용품</span></a>
	                                    </li>
	                                </ul>
	                            </div>
	                        </li>
	                        <li>
	                            <a><span>취미/문구/도서</span></a>
	                            <div class="depth2" style="display: none;">
	                                <ul>
	                                    <li>
	                                        <a href=""><span>도서/음반</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>보드/칠판용품</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>사무기기</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>사무용지</span></a>
	                                    </li>
	                                    <li>
	                                        <a href=""><span>문구용품</span></a>
	                                    </li>
	                                </ul>
	                            </div>
	                        </li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</body>