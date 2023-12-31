<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>로그인</title>
    <link href="/resources/css/style.css" rel="stylesheet">
   	<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js"></script>
   	<script>
   		window.onload = async () => {
   			
   			// 쿠키 가져 오기 
   			const getCookie = (name) => {
   				
   				const cookies = document.cookie.split(`; `).map((el)=>el.split('='));
   				let getItem = [];
   				console.log('cookies = ' + cookies);
   				for(let i=0; i<cookies.length; i++) {
   					if(cookies[i][0] == name) { 
   						// name: userid, getItem = ['jingom368']
   						// name: password, getItem = ['V1RGa05HVkhSblZVV0doUFZrZHpPUT09']
						getItem.push(cookies[i][1]);
						break;
   					}	
   				}
   				console.log(getItem)
   					
   				if(getItem.length>0) { // 한글을 쿠키값으로 쓸 때 : %20%30
   					return decodeURIComponent(getItem[0]);
   				}
   			}
   			
   			let userid = getCookie('userid');
   			let password = getCookie('password');
   			let authkey = getCookie('authkey');
   			console.log(userid, password, authkey)
   			
   			// userid 쿠키가 존재하면...
   			if(userid !== undefined) {
   				document.querySelector('#rememberUserid').checked = true;
   				document.querySelector('#userid').value = userid;
   			} else {
   				document.querySelector('#rememberUserid').checked = false;
   			}
   			
   			// 패스워드 쿠기가 존재하면... 
   			if(password !== undefined) {
   				document.querySelector('#rememberPassword').checked = true;
   				// Base24로 인코딩 된 password를 디코딩
   				const decrypt = CryptoJS.enc.Base64.parse(password);
   				const hashData = decrypt.toString(CryptoJS.enc.Utf8);
   				password = hashData
   				document.querySelector('#password').value = password;
   			} else {
   				document.querySelector('#rememberPassword').checked = false;
   			} 
   			
   			// 자동 로그인 처리
   			if(authkey !== undefined) {
   				let formData = new FormData();
   				formData.append('authkey', authkey);
   				
   				await fetch('/member/login?autologin=PASS', {
   					method: 'POST',
   					body: formData
   				}).then((response) => response.json())
   					.then((data) => {
   						if(data.message === 'GOOD') {
   							document.location.href='/board/list?page=1';
   						} else {
   							alert('시스템 장애로 자동 로그인이 실패 했습니다.');
   						}
  					}).catch((error) => {
  						console.log('error = ' + error);
  					})
   			}
   			
   		}
		
   		// 로그인 처리
   		const loginCheck = async () => {
   			
   			// const userid = document.querySelector('#userid');
   			// const authkey = '12345';
   			
				if(userid.value == '') {
   					alert('아이디를 입력하세요');
   					userid.focus();
   					return false
 				}   				
				if(password.value == '') {
   					alert('암호를 입력하세요');
   					password.focus();
   					return false
   				}
				
			// let formData = new FormData(loginForm);
			let formData = new FormData();
			formData.append("userid", userid.value);
			formData.append("password", password.value);
			
			await fetch('/member/login?autologin=NEW',{ 
				method: "POST",
				body: formData
			}).then((response) => response.json())
				.then((data) => {
					if(data.message === 'GOOD') {
						cookieManage(userid.value, password.value, data.authkey);
						document.location.href='/board/list?page=1';
					}else if(data.message === 'ID_NOT_FOUND') {
						msg.innerHTML = '존재하지 않는 아이디입니다.';
					}else if(data.message === 'PASSWORD_NOT_FOUND') {
						msg.innerHTML = '잘못된 패스워드입니다.';
					}else {
						alert("시스템 장애로 로그인이 실패 했습니다.");
					}
				}).catch((error) => { 
					console.log("error = " + error);
				})
					
			}
			
		/* 				
   			document.loginForm.action = '/member/login';
   			document.loginForm.submit();
   		 */
   		
   		 // 이메일 체크 관리
   		 const checkRememberUserid = () => {
   			if(document.querySelector('#rememberUserid').checked)
   		 		document.querySelector('#rememberMe').checked = false;
   		 }
   		 
   		 // 패스워드 체크 관리
   		 const checkRememberPassword = () => {
   		 	if(document.querySelector('#rememberPassword').checked)
   		 		document.querySelector('#rememberMe').checked = false;
   		 }
   		 
   		 // 자동 로그인 체크 관리
   		 const checkRememberMe = () => {
   			if(document.querySelector('#rememberMe').checked) {
   		 		document.querySelector('#rememberUserid').checked = false;
   				document.querySelector('#rememberPassword').checked = false;
   			}
   		 }
   		 
   		 // 쿠키 관리
   		 const cookieManage = (userid, password, authkey) => {
   			 
   			 // userid가 체크되었을 경우
   			 if(rememberUserid.checked) {
   				 document.cookie = 'userid=' + userid + '; path=/; expires=Sun, 31, Dec 2023 23:59:59 GMT';
   			 } else {
   				 document.cookie = 'userid=' + userid + '; path=/; max-age=0'
   			 }
   			 
   			// password가 체크되었을 경우
   			 if(rememberPassword.checked) {
   				 
   				 // Base64(양방향 복호화 알고리즘)로 패스워드 인코딩
   				 const key = CryptoJS.enc.Utf8.parse(password);
   				 const base64 = CryptoJS.enc.Base64.stringify(key);
   				 password = base64;
   				 document.cookie = 'password=' + password + '; path=/; expires=Sun, 31, Dec 2023 23:59:59 GMT';
   			 } else {
   				 document.cookie = 'password=' + password + '; path=/; max-age=0'
   			 }
   			
   			// 자동 로그인 저장이 체크되었을 경우
   			if(rememberMe.checked) {
   				 document.cookie = 'authkey=' + authkey + '; path=/; expires=Sun, 31, Dec 2023 23:59:59 GMT';
   			 } else {
   				 document.cookie = 'authkey=' + authkey + '; path=/; max-age=0'
   			 }
   		 }
   		 
   		const press = () => {
    		if(event.keyCode == 13) loginCheck(); // 13 = enter
    	}
   	</script>
   	
</head>
<body>

<%
	String userid = (String)session.getAttribute("userid");
	if(userid != null) response.sendRedirect("/board/list?page=1");
%>

	<div class="main">
	
		<div class="topBanner">
			<img class="topBanner" src="/resources/images/logo.jpg" title="서울기술교육센터">
		</div>
		
		<div class="login">
			<h1>로그인</h1>
			<form name="loginForm" id="loginForm" method="POST">
				<input type="text" name="userid" class="userid" id="userid" placeholder="아이디를 입력하세요">
				<input type="password" name="password" class="password" id="password" placeholder="패스워드를 입력하세요" onkeydown="press()">
				<p id="msg" style="color:red; text-align:center"></p>
				<br>
				<input type="checkbox" id="rememberUserid" onclick="checkRememberUserid()">아이디 기억
				<input type="checkbox" id="rememberPassword" onclick="checkRememberPassword()">패스워드 기억
				<input type="checkbox" id="rememberMe" onclick="checkRememberMe()">자동 로그인
				<br><br>
				<input type="button" id="btn_login" class="btn_login" value="로그인" onclick="loginCheck()">
			</form>
			
			<div class="bottomText">사용자가 아니면 ▶<a href="/member/signup">여기</a>를 눌러 등록을 해주세요.<br><br>
	        [<a href = "/member/searchID" oneMouseover="this.style.backgroound='pink'; this.style.textDecoration='underline';"
	            onmouseout="this.style.background='white'; this.style.textDecoration='none';">아이디</a> |
	        <a href = "/member/searchPassword" oneMouseover="this.style.backgroound='pink'; 
                    this.style.textDecoration='underline';"
            onmouseout="this.style.background='white'; this.style.textDecoration='none';">비밀번호</a> 찾기] <br><br>
			 </div>
		</div>
		
	</div>
</body>
</html>