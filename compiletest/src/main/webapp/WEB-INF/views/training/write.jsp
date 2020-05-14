<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./problem-write.css">
    <link href="${pageContext.servletContext.contextPath }/assets/css/training/problem-write.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.servletContext.contextPath }/assets/css/main.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript" src="${pageContext.servletContext.contextPath }/assets/js/jquery/jquery-3.4.1.js"></script>
    <title>Code Forest</title>
</head>
<body>
    <c:import url="/WEB-INF/views/include/main-header.jsp" />
    
    <form method="post" action="${pageContext.servletContext.contextPath }/training/write">
	    <div class="regist">
	        <div class="privateAndPassword">
	            <div class="private">코딩테스트 <input type="checkbox"></div>
	            <div class="password">비밀번호 <input type="password"></div>
	        </div>
	        <div class="date">
	            <div class="start-date">시작일자 <input type="datetime-local"></div>
	            <div class="end-date">마감일자 <input type="datetime-local"></div>
	        </div>
	
	        <div class="divisionAndLanguage">
	            <div class="division">분류 
	                <select name="category">
	                    <option value="" selected="selected">기타</option>
	                    <option value="">기업</option>
	                    <option value="">개인</option>
	                    <option value="">학원</option>
	                    <option value="">학교</option>
	                </select>
	            </div>
	            <div class="language-select">
	                <div class="language"><input type="checkbox">C</div>
	                <div class="language"><input type="checkbox">C++</div>
	                <div class="language"><input type="checkbox">Java </div>
	                <div class="language"><input type="checkbox">JS </div>
	                <div class="language"><input type="checkbox">Python </div>
	            </div>
	        </div>
	        <br />
	        <div class="title">
	            제목
	            <textarea class="title-text"></textarea>
	        </div>
	        
	        <br />
	
	        <div class="prob-content">
	            <div class="prob-content-title">내용</div>
	            <textarea id="prob-content-text"></textarea>
	        </div>
	
	        <br />
	
	        <div class="ex-input">
	            <div class="ex-input-title">예제 입력</div>
	            <textarea id="ex-input-text">
	            </textarea>
	        </div>
	
	        <div class="ex-output">
	            <div class="ex-input-title">예제 출력</div>
	            <textarea id="ex-output-text"></textarea>
	        </div>
	
	        <div class="answer-code">
	            <div class="ex-input-title">정답 코드</div>
	            <textarea id="answer-code-text"></textarea>
	        </div>
	        
	        <a href="${pageContext.servletContext.contextPath }/training"><button>취소</button></a>
	        <input type="submit" value="등록">
	        
	        <br />
	        <br />
	        <br />
	    </div>
    </form>
</body>
</html>