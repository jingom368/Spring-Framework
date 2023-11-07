<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%-- 23.10.20(금) JSP --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 목록 보기</title>

    <link href="/resources/css/style.css" rel="stylesheet">
    <script src="/resources/js/getCookie.js"></script>
    <script>
    	
    	const search = () => {
    		const keyword = document.querySelector('#keyword');
    		document.location.href='/board/list?page=1&keyword=' + keyword.value;
    	}   
    
    	const press = () => {
    		if(event.keyCode == 13) search(); // 13 = enter
    	}
    	
    	const logout = () => {
    		if(confirm('로그아웃하시겠습니까?')) {
    			let authkey = getCookie('authkey');
    			if(authkey != undefined)
    				document.cookie = 'authkey=' + authkey + '; path=/; max-age=0'
    				
    			document.location.href='/member/logout';
    		}
    	}
    </script>
</head>

<body>

<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	String role = (String)session.getAttribute("role");
	if(userid == null) response.sendRedirect("/");
%>

    <div class="main">

        <img src="/resources/images/logo.jpg" id="topBanner"><br>
        <h1 style="text-align:center;">게시물 목록</h1>	
        <input type="text" name="keyword" id="keyword"
        		style="width:25%; height:30px; border:2px solid #168; font-size:16px"
        		placeholder="검색할 제목, 작성자 이름 및 내용을 입력하세요." onkeydown="press()">
        <input type="button" value="검색"
        		style="width:5%; height:30px; background:#158; color:white; font-weight:bold; cursor:pointer;"
        		onclick="search()">
        <br><br>
        <table class="InfoTable">
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>

			 <c:forEach items="${list}" var="list">
            <tr onmouseover="this.style.background='#46D2D2'" onmouseout="this.style.background='white'">
                <td>${list.seq}</td>
                <td style="text-align: left"><a href="/board/view?seqno=${list.seqno}&page=${page}&keyword=${keyword}" 
									                onmouseover="this.style.textDecoration='underline'" 
									                onmouseout="this.style.textDecoration='none'">${list.title}</a></td>
                <td>${list.writer}</td>
                <!-- <td>${list.regdate}</td> -->
                <td><fmt:formatDate value="${list.regdate}" type="both" pattern="yyyy-MM-dd [E] a hh:mm:ss" /></td>
                <td>${list.hitno}</td>
            </tr>
            </c:forEach>
        </table>
        
        <br>
        <div>${pageList}</div>
         <br>
        
        <div class="bottom_menu">
            <a href="/board/list?page=${page}">처음으로</a>&nbsp;&nbsp;
            <a href="/board/write">글쓰기</a>&nbsp;&nbsp;
            <a href="/member/memberInfo">사용자관리</a>&nbsp;&nbsp;
            <a href="javascript:logout()">로그아웃</a>&nbsp;&nbsp;
        </div>
    </div>
</body>
</html>