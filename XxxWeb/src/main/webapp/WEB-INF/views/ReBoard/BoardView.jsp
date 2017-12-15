<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<title>Insert title here</title>
</head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	$(document).ready(function(){

		$("#lBtn").click(function(){
			//	목록보기 요청을 하면 된다.
			$(location).attr("href", "../ReBoard/BoardList.time?nowPage=${NOWPAGE}");
		});
		$("#wBtn").click(function() {
			//	무결성 검사하시고
			
			$("#rfrm").submit();
		});
		
		

	});
</script>
<body>
<%-- 	상세보기 보여주고	

		넘어온 데이터는 MAP 이라는 키값으로 Map 형태로 넘어왔고
		이중에서 상세보기 내용은 VIEW라는 키값으로 묶여 있다.
		
		${MAP.VIEW}		<==		묶인 ReBoardVO	가 나온다.
		
		이 중에서 번호는 getNo() 함수로 제공되고 있으므로...
		
		번호를 출력하려면		${MAP.VIEW.no}
--%>
	<table width="600" border="1" align="center">
		<tr>
			<td>글번호</td>
			<td>${MAP.VIEW.oriNo}</td>
			<td>조회수</td>
			<td>${MAP.VIEW.hit}</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>${MAP.VIEW.writer}</td>
			<td>작성일</td>
			<td>${MAP.VIEW.wday}</td>
		</tr>
		<tr>
			<td>제목</td>
			<td colspan="3">${MAP.VIEW.title}</td>
		</tr>
		<tr>
			<td>본문</td>
			<td colspan="3">${MAP.VIEW.body}</td>
		</tr>
		<tr>
			<td>태그</td>
			<td colspan="3">${MAP.VIEW.tags}</td>
		</tr>
	</table>
<%-- 	답글 목록 보여주고 --%>
	<table width="600" border="1" align="center">
		<tr>
			<th>글번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	<c:forEach var="data" items="${MAP.LIST}">
		<tr>
			<td>${data.oriNo}</td>

			<td>
	<c:if test="${data.bstep ne 0}">	<%-- 	답글인 경우에는 들여쓰기가 되어야 하겠다. --%>
		<c:forEach var="step" begin="1" end="${data.bstep}">
			&nbsp;&nbsp;&nbsp;
		</c:forEach>	
	</c:if>		
				<a href="../AnBoard/HitProc.sun?nowPage=${nowPage}&oriNo=${data.no}">${data.title}</a>
			</td>
			<td>${data.writer}</td>
			<td>${data.wday}</td>
			<td>${data.hit}</td>
		</tr>
	</c:forEach>		
	</table>
<%-- 	기타 기능 만들고 --%>
	<table width="700" border="1" align="center">
		<tr>
			<td align="center">
				<input type="button" id="lBtn" value="목록보기">
<%-- 	수정이나 삭제는 기본적으로 자신이 쓴 글에 한해서만
		작업이 이루어 져야 한다.
		이 두 단추는 이 글을 쓴 사람에게만 보여주도록 하고자 한다.
--%>
		<c:if test="${sessionScope.USER.id eq VIEW.writer}">		
				<input type="button" id="mBtn" value="수정하기">
				<input type="button" id="dBtn" value="삭제하기">
		</c:if>		
			</td>
		</tr>
	</table>
<%--	댓글을 쓸 수 있도록 폼을 만들어주고 --%>
	<form method="POST" id="rfrm" action="../ReBoard/ReplyWrite.sun">
	<%--	이처럼
			폼에 의해서 데이터를 전송하고 싶으면
			그 데이터는 반드시 form 안에 있어야 하는데....
			그것을 노출시키고 싶지않으면 감춰서 보내도록한다.
	--%>
		<input type="hidden" name="oriNo" value="${VIEW.no}">
		<table width="700" border="1" align="center">
			<tr>
				<td>글쓴이</td>
<%--	
		이처럼 특정 기능에 대한 권하는 설정하는 작업을
		우리는		정책을 세운다. 	라고 표현한다.
		
		만약 로그인한 사람만 댓글을 쓰게하고 싶다면.....
		지난번에 배웠던 ${sessionScope.USER.id}를 이용해서
		자동 출력되도록 해주어야 한다.
		
		필요하다면 댓글을 쓰는 부분에 글쓰기 단추를 
		로그인한 사람에게만 보이도돌 조치해 주어야 한다.
--%>
				<td>
					<input type="text" id="writer" name="writer" value="${sessionScope.USER.id}" readonly>
				</td>
			</tr>
			<tr>
				<td>본문</td>
				<td><textarea id="body" name="body"></textarea></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="pw" name="pw"></td>
			</tr>
		<c:if test="${not empty sessionScope.USER}">	
			<tr>
				<td colspan="2" align="center">
					<input type="button" id="wBtn" value="댓글쓰기">
				</td>
			</tr>
		</c:if>
		</table>
	</form>
<%--	
		댓글도 보여주고 
		RLIST라는 키값으로 댓글 정보가 뷰에게 모델로 전달되었다.
		
		수정하기 단추를 누르면 그 자체가 수정하기 폼으로 바뀌도록
		하고자 한다.
		
		원리 
			댓글을 보여주고 그 밑에 수정폼도 같이 만들어준다.
			수정폼은 안보이도록 조치해 놓은 후
			나중에 단추를 누르면 그때 보이도록 조치할 예정이다.
--%>
	<c:forEach var="data" items="${RLIST}">
<%--
	언제가는 이 테이블을 보이지 않게 해야 한다.
	
		$("요소").hide();
		
	그러면 이 테이블을 찾을 수 있도록 어떤 조치를 해야 한다.
	방법	1.	강제로 id를 배정해서 그것을 이용해서 찾는 방법
			2.	DOM 노드 추적을 이용해서 찾는 방법
 	
		<table width="600" border="1" align="center" id="${data.no}">
			<tr>
				<td>글번호</td>
				<td>${data.no}</td>
				<td>작성날짜</td>
				<td>${data.wday}</td>
			</tr>
			<tr>
				<td>글쓴이</td>
				<td>${data.writer}</td>
				<td></td>
				<td>
					<c:if test="${data.kind eq '베스트'}">
						<img src="../view/ReBoard/like.jpg">
					</c:if>
					<c:if test="${data.kind ne '베스트'}">
						<img src="../view/ReBoard/na.jpg">
					</c:if>
				</td>
			</tr>
			<tr>
				<td>댓글내용</td>
				<td colspan="3">${data.body}</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
--%>
<%--
	HTML 5에서는 data-? 라는 속성을 사용할 수 있다.
	
	이것은 주로 특정 데이터를 임시로 기억했다가 나중에
	JQuery에서 그 데이터를 사용할 목적으로 데이터를 기억하기 위한
	하나의 방책이다.
--%>
					<input type="button" data-1="${data.no}" data-2="G" value="좋아요 (${data.good})" class="recommen">
					<input type="button" data-1="${data.no}" data-2="B" value="나빠요 (${data.bad})" class="recommen">
					<input type="button" class="mBtn" value="수정하기">					
				</td>
			</tr>
		</table>
<%--	 댓글을 수정할 수 있는 폼 --%>
		<form method="POST" action="../ReBoard/ReplyModify.sun">
		<table width="700" border="1" align="center" style="display:none">
			<input type="hidden" name="oriNo" value="${VIEW.no}">
			<input type="hidden" name="reNo" value="${data.no}">
			<tr>
				<td>글쓴이</td>
				<td>
					<input type="text" value="${sessionScope.USER.id}" readonly>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea id="body" name="body">${data.body}</textarea>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" id="pw" name="pw"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" class="m2Btn" value="수정하기">
					<input type="button" class="rBtn" value="취소하기">
				</td>
			</tr>
		</table>
		</form>
	</c:forEach>

</body>
</html>
