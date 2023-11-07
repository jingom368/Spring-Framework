<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%-- 23.10.20(금) JSP --%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시물 내용 보기</title>
    <link href="/resources/css/style.css" rel="stylesheet">

    <script>

		var myLikeCheck;
		var myDislikeCheck;
		
		window.onload = () => {
			console.log('123')
			var likeCnt = ${view.likecnt};
		 	var dislikeCnt = ${view.dislikecnt};
			myLikeCheck = '${myLikeCheck}'
			myDislikeCheck = '${myDislikeCheck}'
			
			like.innerHTML = likeCnt;
			dislike.innerHTML = dislikeCnt;
			
			if(myLikeCheck == 'Y') document.querySelector('.likeClick').style.backgroundColor = '#0009FF'
			else if(myDislikeCheck == 'Y') document.querySelector('.dislikeClick').style.backgroundColor = '#0009FF'
			
			if(myLikeCheck == 'Y') myChoice.innerHTML = '${username}님의 선택은 좋아요입니다.';
			else if(myDislikeCheck == "Y") myChoice.innerHTML = '${username}님의 선택은 싫어요입니다.';
			else if(myLikeCheck == 'N' && myDislikeCheck == 'N') myChoice.innerHTML = '${username}님은 아직 선택을 안 했네요.'
			}
		
		// 좋아요 처리
		const likeView = () => {
			if(myLikeCheck == 'Y' && myDislikeCheck == 'N') { // 과거에 사용자가 좋아요를 선택한 상황에서 좋아요를 클릭하면 좋아요 취소로 변환
				alert('좋아요를 취소합니다.');
					const checkCnt = 1; // likeCnt --; --> 6개의 조건 중 1번 조건
					myLikeCheck = 'N';
					sendDataToTransfer(myLikeCheck, myDislikeCheck, checkCnt);
					document.querySelector('.likeClick').style.backgroundColor = '#d2d2d2';
			}else if(myLikeCheck == 'N' && myDislikeCheck == 'Y') { // 과거에 사용자가 싫어요를 선택한 상황에서 좋아요를 클릭하면 싫어요가 취소되고 좋아요를 선택
				alert('싫어요가 취소되고 좋아요가 등록됩니다.');
				const checkCnt = 2; // likeCnt ++, dislikeCnt --;
				myLikeCheck = 'Y';
				myDislikeCheck = 'N';
				sendDataToTransfer(myLikeCheck, myDislikeCheck, checkCnt);
				document.querySelector('.likeClick').style.backgroundColor = '#0099FF';
				document.querySelector('.dislikeClick').style.backgroundColor = '#d2d2d2';
			}else if(myLikeCheck == 'N' && myDislikeCheck == 'N') {
				alert('좋아요를 선택했습니다.');
				const checkCnt = 3; // likeCnt ++
				myLikeCheck = 'Y';
				sendDataToTransfer(myLikeCheck, myDislikeCheck, checkCnt);
				document.querySelector('.likeClick').style.backgroundColor = '#0099FF';
			}
			if(myLikeCheck == 'Y') myChoice.innerHTML = '${username}님의 선택은 좋아요입니다.';
			else if(myDislikeCheck == "Y") myChoice.innerHTML = '${username}님의 선택은 싫어요입니다.';
			else if(myLikeCheck == 'N' && myDislikeCheck == 'N') myChoice.innerHTML = '${username}님은 아직 선택을 안 했네요.'
		}	
		
		// 싫어요 처리
		const dislikeView = () => {
			if(myDislikeCheck == 'Y' && myLikeCheck == 'N') { // 과거에 사용자가 싫어요를 선택한 상황에서 싫어요를 클릭하면 좋아요 취소로 변환
				alert('싫어요를 취소합니다.');
					const checkCnt = 4; // dislikeCnt --; --> 6개의 조건 중 1번 조건
					myDislikeCheck = 'N';
					sendDataToTransfer(myLikeCheck, myDislikeCheck, checkCnt);
					document.querySelector('.dislikeClick').style.backgroundColor = '#d2d2d2';
			}else if(myDislikeCheck == 'N' && myLikeCheck == 'Y') { // 과거에 사용자가 좋아요를 선택한 상황에서 싫어요를 클릭하면 좋아요가 취소되고 싫어요를 선택
				alert('좋아요가 취소되고 싫어요가 등록됩니다.');
				const checkCnt = 5; // dislikeCnt ++, likeCnt --;
				myLikeCheck = 'N';
				myDislikeCheck = 'Y';
				sendDataToTransfer(myLikeCheck, myDislikeCheck, checkCnt);
				document.querySelector('.likeClick').style.backgroundColor = '#d2d2d2';
				document.querySelector('.dislikeClick').style.backgroundColor = '#0099FF';
			}else if(myDislikeCheck == 'N' && myLikeCheck == 'N') {
				alert('싫어요를 선택했습니다.');
				const checkCnt = 6; // dislikeCnt ++
				myDislikeCheck = 'Y';
				sendDataToTransfer(myLikeCheck, myDislikeCheck, checkCnt);
				document.querySelector('.dislikeClick').style.backgroundColor = '#0099FF';
			}
			if(myLikeCheck == 'Y') myChoice.innerHTML = '${username}님의 선택은 좋아요입니다.';
			else if(myDislikeCheck == "Y") myChoice.innerHTML = '${username}님의 선택은 싫어요입니다.';
			else if(myLikeCheck == 'N' && myDislikeCheck == 'N') myChoice.innerHTML = '${username}님은 아직 선택을 안 했네요.'
		}
		
		// 좋아요/싫어요 값 서버 전송
		const sendDataToTransfer = async (myLike, myDislike, checkCount) => {
			console.log('hello')
		const myLikeCheck = myLike;
		const myDislikeCheck = myDislike;
		const checkCnt = checkCount;
		
		const queryString = {
			seqno: ${view.seqno},
			userid: '${userid}',
			mylikecheck: myLikeCheck,
			mydislikecheck: myDislikeCheck,
			checkCnt: checkCnt
		};
		
		await fetch('/board/likeCheck', {
			method: 'POST',
			headers: {
				"content-type":"application/json"
			},
			body: JSON.stringify(queryString)
		}).then((response) => response.json())
			.then((data) => {
				like.innerHTML = data.likeCnt;
				dislike.innerHTML = data.dislikeCnt;
			}).catch((error) => {
				console.log("error : " + error);
			})
		}
		
		
        // 게시물 삭제
    	const boardDelete = () => {
            if(confirm("정말 삭제 하시겠습니까?") == true) document.location.href = '/board/delete?seqno=${view.seqno}';  
        }
    	
    	// 댓글 등록
    	const replyRegister = async () => {
    		
    		const replycontent = document.querySelector('#replycontent');
    		
    		if(replycontent.value === '') {
    			alert('댓글을 입력하세요');
				replycontent.focus();
				return false; 
    		}
    		
    		const data = {
   				replywriter: replywriter.value,
   				replycontent: replycontent.value,
   				userid: userid.value,
   				seqno: seqno.value
    		}
    		
    		await fetch('/board/reply?option=I', {
    			method: 'POST',
    			headers: {"content-type":"application/json"},
    			body: JSON.stringify(data) // JSON 으로 변환
    		}).then((response) => response.json())
    			.then((data) => replyList(data))
    			.catch((error) => {
    				console.log("error = " + error);
    				alert("시스템 장애로 댓글 등록이 실패했습니다.");
    			});
    		
    		replycontent.value = '';	
    	}
    	
    	// 댓글 목록 가져 오기
    	const replyList = (data) => {
    	
    		var session_userid = '${userid}';
    		const jsonInfo = data;
    		
    		let replyList = document.querySelector('#replyList');
    		replyList.innerHTML = '';
    		
    		var result = '';
    		for(const i in jsonInfo) {
    			let elm = document.createElement('div'); // <div id='s3' style='font-size:0.8em'></div>
    			elm.setAttribute('id', 's' + jsonInfo[i].replyseqno)
    			elm.setAttribute('style', 'font-size:0.8em');
    			
    			let result = "";
    			result += "작성자 : " + jsonInfo[i].replywriter
    			
    			if(jsonInfo[i].userid === session_userid) {
    				result += "[<a href=" + "'javascript:replyModify(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer'>수정</a> | ";
    				result += "<a href=" + "'javascript:replyDelete(" + jsonInfo[i].replyseqno + ")' style='cursor:pointer'>삭제</a>]";
    			}
    			
    			let date = new Date(jsonInfo[i].replyregdate);
    			let year = date.getFullYear();
    			let month = date.getMonth() + 1;
    			let day = date.getDate();
    			let hour = date.getHours();
    			let minute = date.getMinutes();
    			let second = date.getSeconds();

    			//2023-03-5 14:05:26
    			month = month >= 10? month: '0' + month;
    			day = day >= 10? day: '0' + day;
    			hour = hour >= 10? hour: '0' + hour;
    			minute = minute >= 10? minute: '0' + minute;
    			second = second >= 10? second: '0' + second;

    			let regdate = year + "-" + month + "-" + day + "-" + " " + hour + ":" + minute + ":" + second;
    			
    			result += "&nbsp&nbsp;" + jsonInfo[i].replyregdate;
    			result += "<div style='width:90%; height:auto; border-top:solid 1px gray; overflow:auto;'>";
    			result += "<pre id='c" + jsonInfo[i].replyseqno + "'>" + jsonInfo[i].replycontent + "</pre>";
    			result += "</div><br>"
    			
    			elm.innerHTML = result;
    			replyList.appendChild(elm);
    			
    		}
    	}
    	
    	const startupPage = async () => {

    		const data = {seqno: ${view.seqno}};

    		await fetch('/board/reply?option=L', {
      			method: 'POST',
      			headers: {
      				"content-type":"application/json"
   				},
      			body: JSON.stringify(data)
    		}).then((response) => response.json())
    			.then((data) => replyList(data))
    			.catch((error) => {
    				console.log("error = " + error);
    				alert("시스템 장애로 댓글 가져오기가 실패했습니다.")
    			});
    	}
    	
    	const replyDelete = async (replyseqno) => {
			if(confirm("정말로 삭제하시겠습니까?")) {
	    		const data = {replyseqno:replyseqno, seqno:${view.seqno}};
	
	    		await fetch('/board/reply?option=D', {
	      			method: 'POST',
	      			headers: {
	      				"content-type":"application/json"
      				},
	      			body: JSON.stringify(data)
	    		}).then((response) => response.json())
	    			.then((data) => replyList(data))
	    			.catch((error) => {
	    				console.log("error = " + error);
	    				alert("서버 장애로 댓글 삭제가 실패했습니다.")
	    			});
			}
    	}
    	
    	const replyModify = async (replyseqno) => {
			
    		// 댓글 내용 임시 저장
    		const modifyReplyContent = document.querySelector('#c' + replyseqno);
    		
    		var strReplyList = "작성자 :${username}&nbsp;"
    							+ "<input type='button' id='btn_replyModify' value='수정'>"
    							+ "<input type='button' id='btn_replyModifyCancel' value='취소'>"
    							+ "<input type='hidden' name='replyseqno' value='" + replyseqno + "'>"
    							+ "<input type='hidden' name='seqno' value='" + ${view.seqno} + "'>"
    							+ "<input type='hidden' id='replywriter' name='replywriter' value='${username}'>"
    							+ "<input type='hidden' id='userid' name='userid' value='${userid}'><br>"
    							+ "<textarea id='modify_replycontent' name='replycontent' cols='80' rows='5' maxlength='150' placeholder='글자수 150자 이내'>" 
    							+ modifyReplyContent.innerHTML + "</textarea><br>"
    							
    		let elm = document.createElement('div');
    		elm.innerHTML = strReplyList;
    		
    		// 개별 댓글 목록을 둘러 싸고 있는 div
    		let parentDiv = document.querySelector('#s' + replyseqno).parentNode;
    		parentDiv.insertBefore(elm,document.querySelector('#s' + replyseqno));
    		document.querySelector('#s' + replyseqno).style.display = 'none';
    		
    		const btnReplyModify = document.querySelector('#btn_replyModify');
    		const btnReplyModifyCancel = document.querySelector('#btn_replyModifyCancel');
    		
    		btnReplyModify.addEventListener('click', async () => {
    			
    			const data = {
    					replyseqno: replyseqno,
    					replycontent: modify_replycontent.value
    			};
    			
    			await fetch('/board/reply?option=U', {
          			method: 'POST',
          			headers: {
          				"content-type":"application/json"
          			},
          			body: JSON.stringify(data)
        		}).catch((error) => {
        				console.log("error = " + error);
        				alert("서버 장애로 댓글 수정이 실패했습니다.")
        			});
    			
    			document.querySelector('#replyList').innerHTML = '';
    			startupPage();
        	
    		}); // btnReplyModify 이벤트 처리 완료
    		
    		
    		btnReplyModifyCancel.addEventListener('click', () => {
    			if(confirm('정말로 취소하시겠습니까?') == true) {
        			document.querySelector('#replyList').innerHTML = '';
        			startupPage();
    			}
    		})
    	}
    	
    	const replyCancle = () => {
    		if(confirm('정말로 취소하시겠습니까?') == true) {
    			replycontent.value = '';
    			replycontent.focus();
    		}
    	}
    </script>
</head>


<%
	String userid = (String)session.getAttribute("userid");
	String username = (String)session.getAttribute("username");
	String role = (String)session.getAttribute("role");
	if(userid == null) response.sendRedirect("/");
%>

<body onload="startupPage()">

    <div class="main">
        <img src="/resources/images/logo.jpg" class="topBanner"><br>
        <h1 style="text-align:center;">게시물 내용 보기</h1>
        <br>
        
        <div class = "boardView">
            <div class="items_v">글쓴이 : ${view.writer}</div>
            <div class="items_v">제목 : ${view.title}</div>
            <!-- <div class="items_v">날짜 : ${view.regdate}</div> -->
            <div class="items_v">날짜 : <fmt:formatDate value="${view.regdate}" type="both" pattern="yyyy-MM-dd [E] a hh:mm:ss" /></div>
            <div class="textArea"><pre>내용 : ${view.content}</pre></div>
            
	        <c:forEach items="${fileInfoView}" var="file">
	        <div class="field">
	        	파일명 : <a href="/board/fileDownload?fileseqno=${file.fileseqno}">${file.org_filename}, ${file.filesize} Byte</a>
	        </div>
	        </c:forEach>
	        
	        
	        
	        <div class="likeForm" style="width:30%; height:auto; margin:auto">
		  		<span id="like"></span>&nbsp;
		  		<a href='javascript:likeView()' id='likeClick' class='likeClick'>좋아요</a>&nbsp;
		  		<a href='javascript:dislikeView()' id='dislikeClick' class='dislikeClick'>싫어요</a>&nbsp;
				<span id="dislike"></span>&nbsp;
				<br>
				<span id='myChoice' style='text-aling:center; color;red'></span>            		
			 </div>
        </div>
        <br>

        <div class="bottom_menu">
            
			 <c:if test="${pre_seqno != 0}">
           	 <a href="/board/view?seqno=${pre_seqno}&page=${page}&keyword=${keyword}">이전</a>&nbsp;&nbsp;
			 </c:if>
           	 <a href="/board/list?page=${page}&keyword=${keyword}">목록가기</a>&nbsp;&nbsp;
			 <c:if test="${next_seqno != 0}">
           	 <a href="/board/view?seqno=${next_seqno}&page=${page}&keyword=${keyword}">다음</a>&nbsp;&nbsp;
			 </c:if>
            	<a href="/board/write">글 작성</a>&nbsp;&nbsp;
            <c:if test="${userid == view.userid}">
	            <a href="/board/modify?seqno=${view.seqno}&page=${page}&keyword=${keyword}">글 수정</a>&nbsp;&nbsp;
	            <a href="javascript:boardDelete()">글 삭제</a>
            </c:if>
        </div>
        <br><br>
        
        <div class="replyDiv" style="width:60%; height:300px; margin:auto; text-align:left;">
        	<p id="replyNotice">댓글을 작성해 주세요.</p>
        	<form id="replyForm" name="replyForm" method="POST">
        		작성자 : <input type="text" id="replywriter" name="replywriter" value="${username}" readonly>
        		<textarea id="replycontent" name="replycontent" cols="80" rows="5" maxlength="150" placeholder="글자수: 150자 이내">
        		</textarea><br>
        		<input type="hidden" id="seqno" name="seqno" value="${view.seqno}">
        		<input type="hidden" id="userid" name="userid" value="${userid}">
        	</form>
        	<input type="button" id="btn_reply" value="댓글등록" onclick="replyRegister()">
        	<input type="button" id="btn_cancle" value="취소" onclick="replyCancle()">
        	<hr>
        	<div id="replyList" style="width:90%; heigth:600px; overflow:auto;"></div>
        </div>
    </div>
</body>
</html>