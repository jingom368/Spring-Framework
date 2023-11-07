<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link href="/resources/css/style.css" rel="stylesheet">
<title>Insert title here</title>
<style>
	.field {
         width: 90%;
         border:none;
         border-bottom: 2px solid gray;
         padding:10px;
         outline : none;
         color: #636e72;
         height: 25px;
         background: none;
     }
	.input_content{
	  width: 90%;
	  height: 300px;
	  padding: 10px;
	  box-sizing: border-box;
	  border: solid #adadad;
	  font-size: 16px;
	  resize: both;
	
	}
</style>
 <link href="/resources/css/style.css" rel="stylesheet">
 <script src="/resources/js/getCookie.js"></script>
</head>

<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	String role = (String)session.getAttribute("role");
	if(userid == null) response.sendRedirect("/");
%>

<script>
	const logout = () => {
		if(confirm('로그아웃하시겠습니까?')) {
			let authkey = getCookie('authkey');
			if(authkey != undefined)
				document.cookie = 'authkey=' + authkey + '; path=/; max-age=0'
				
			document.location.href='/member/logout';
		}
	}
</script>

<body>
	<div class="boardView">
		<div style="width:70%; height:auto; margin:auto; padding:20px; border:none;">
			<img src="/profile/${memberInfo.stored_filename}" style="display:block; width:80%; height:auto; margin:auto;" >
		</div>
		<div class="items">아이디 : ${memberInfo.userid}</div>
		<div class="items">이름 : ${memberInfo.username}</div>
		<div class="items">직업 : ${memberInfo.job}</div>
		<div class="items">성별 : ${memberInfo.gender}</div>
		<div class="items">취미 : ${memberInfo.hobby}</div>
		<div class="items">전화번호 : ${memberInfo.telno}</div>
		<div class="items">이메일 : ${memberInfo.email}</div>
		<div class="items">최종 로그인 날짜 : ${memberInfo.lastlogindate}</div>
		<div class="items">최종 로그아웃 날짜 : ${memberInfo.lastlogoutdate}</div>
		<div class="items">최종 패스워드 변경일 : ${memberInfo.lastpwdate}</div>
		
		<c:if test="${memberInfo.role == 'USER'}">
			<div class="items">회원 권한 : 일반 권한</div>
		</c:if>
		<c:if test="${memberInfo.role == 'MASTER'}">
			<div class="items">회원 권한 : 관리자</div>
		</c:if>
		<div class="input_content"><pre>내용 : ${memberInfo.description}</pre></div>
    </div>
    <div class="bottom_menu">
       <a href="/board/list?page=${page}">처음으로</a>&nbsp;&nbsp;
       <a href="/board/write">글쓰기</a>&nbsp;&nbsp;
       <a href="/member/memberPasswordModify">비밀번호 변경</a>&nbsp;&nbsp;
       <a href="javascript:logout()">로그아웃</a>&nbsp;&nbsp;
   </div>
</body>
</html>