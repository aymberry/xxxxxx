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
			//	��Ϻ��� ��û�� �ϸ� �ȴ�.
			$(location).attr("href", "../ReBoard/BoardList.time?nowPage=${NOWPAGE}");
		});
		$("#wBtn").click(function() {
			//	���Ἲ �˻��Ͻð�
			
			$("#rfrm").submit();
		});
		
		

	});
</script>
<body>
<%-- 	�󼼺��� �����ְ�	

		�Ѿ�� �����ʹ� MAP �̶�� Ű������ Map ���·� �Ѿ�԰�
		���߿��� �󼼺��� ������ VIEW��� Ű������ ���� �ִ�.
		
		${MAP.VIEW}		<==		���� ReBoardVO	�� ���´�.
		
		�� �߿��� ��ȣ�� getNo() �Լ��� �����ǰ� �����Ƿ�...
		
		��ȣ�� ����Ϸ���		${MAP.VIEW.no}
--%>
	<table width="600" border="1" align="center">
		<tr>
			<td>�۹�ȣ</td>
			<td>${MAP.VIEW.oriNo}</td>
			<td>��ȸ��</td>
			<td>${MAP.VIEW.hit}</td>
		</tr>
		<tr>
			<td>�ۼ���</td>
			<td>${MAP.VIEW.writer}</td>
			<td>�ۼ���</td>
			<td>${MAP.VIEW.wday}</td>
		</tr>
		<tr>
			<td>����</td>
			<td colspan="3">${MAP.VIEW.title}</td>
		</tr>
		<tr>
			<td>����</td>
			<td colspan="3">${MAP.VIEW.body}</td>
		</tr>
		<tr>
			<td>�±�</td>
			<td colspan="3">${MAP.VIEW.tags}</td>
		</tr>
	</table>
<%-- 	��� ��� �����ְ� --%>
	<table width="600" border="1" align="center">
		<tr>
			<th>�۹�ȣ</th>
			<th>����</th>
			<th>�ۼ���</th>
			<th>�ۼ���</th>
			<th>��ȸ��</th>
		</tr>
	<c:forEach var="data" items="${MAP.LIST}">
		<tr>
			<td>${data.oriNo}</td>

			<td>
	<c:if test="${data.bstep ne 0}">	<%-- 	����� ��쿡�� �鿩���Ⱑ �Ǿ�� �ϰڴ�. --%>
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
<%-- 	��Ÿ ��� ����� --%>
	<table width="700" border="1" align="center">
		<tr>
			<td align="center">
				<input type="button" id="lBtn" value="��Ϻ���">
<%-- 	�����̳� ������ �⺻������ �ڽ��� �� �ۿ� ���ؼ���
		�۾��� �̷�� ���� �Ѵ�.
		�� �� ���ߴ� �� ���� �� ������Ը� �����ֵ��� �ϰ��� �Ѵ�.
--%>
		<c:if test="${sessionScope.USER.id eq VIEW.writer}">		
				<input type="button" id="mBtn" value="�����ϱ�">
				<input type="button" id="dBtn" value="�����ϱ�">
		</c:if>		
			</td>
		</tr>
	</table>
<%--	����� �� �� �ֵ��� ���� ������ְ� --%>
	<form method="POST" id="rfrm" action="../ReBoard/ReplyWrite.sun">
	<%--	��ó��
			���� ���ؼ� �����͸� �����ϰ� ������
			�� �����ʹ� �ݵ�� form �ȿ� �־�� �ϴµ�....
			�װ��� �����Ű�� ���������� ���缭 ���������Ѵ�.
	--%>
		<input type="hidden" name="oriNo" value="${VIEW.no}">
		<table width="700" border="1" align="center">
			<tr>
				<td>�۾���</td>
<%--	
		��ó�� Ư�� ��ɿ� ���� ���ϴ� �����ϴ� �۾���
		�츮��		��å�� �����. 	��� ǥ���Ѵ�.
		
		���� �α����� ����� ����� �����ϰ� �ʹٸ�.....
		�������� ����� ${sessionScope.USER.id}�� �̿��ؼ�
		�ڵ� ��µǵ��� ���־�� �Ѵ�.
		
		�ʿ��ϴٸ� ����� ���� �κп� �۾��� ���߸� 
		�α����� ������Ը� ���̵��� ��ġ�� �־�� �Ѵ�.
--%>
				<td>
					<input type="text" id="writer" name="writer" value="${sessionScope.USER.id}" readonly>
				</td>
			</tr>
			<tr>
				<td>����</td>
				<td><textarea id="body" name="body"></textarea></td>
			</tr>
			<tr>
				<td>��й�ȣ</td>
				<td><input type="password" id="pw" name="pw"></td>
			</tr>
		<c:if test="${not empty sessionScope.USER}">	
			<tr>
				<td colspan="2" align="center">
					<input type="button" id="wBtn" value="��۾���">
				</td>
			</tr>
		</c:if>
		</table>
	</form>
<%--	
		��۵� �����ְ� 
		RLIST��� Ű������ ��� ������ �信�� �𵨷� ���޵Ǿ���.
		
		�����ϱ� ���߸� ������ �� ��ü�� �����ϱ� ������ �ٲ��
		�ϰ��� �Ѵ�.
		
		���� 
			����� �����ְ� �� �ؿ� �������� ���� ������ش�.
			�������� �Ⱥ��̵��� ��ġ�� ���� ��
			���߿� ���߸� ������ �׶� ���̵��� ��ġ�� �����̴�.
--%>
	<c:forEach var="data" items="${RLIST}">
<%--
	�������� �� ���̺��� ������ �ʰ� �ؾ� �Ѵ�.
	
		$("���").hide();
		
	�׷��� �� ���̺��� ã�� �� �ֵ��� � ��ġ�� �ؾ� �Ѵ�.
	���	1.	������ id�� �����ؼ� �װ��� �̿��ؼ� ã�� ���
			2.	DOM ��� ������ �̿��ؼ� ã�� ���
 	
		<table width="600" border="1" align="center" id="${data.no}">
			<tr>
				<td>�۹�ȣ</td>
				<td>${data.no}</td>
				<td>�ۼ���¥</td>
				<td>${data.wday}</td>
			</tr>
			<tr>
				<td>�۾���</td>
				<td>${data.writer}</td>
				<td></td>
				<td>
					<c:if test="${data.kind eq '����Ʈ'}">
						<img src="../view/ReBoard/like.jpg">
					</c:if>
					<c:if test="${data.kind ne '����Ʈ'}">
						<img src="../view/ReBoard/na.jpg">
					</c:if>
				</td>
			</tr>
			<tr>
				<td>��۳���</td>
				<td colspan="3">${data.body}</td>
			</tr>
			<tr>
				<td colspan="4" align="center">
--%>
<%--
	HTML 5������ data-? ��� �Ӽ��� ����� �� �ִ�.
	
	�̰��� �ַ� Ư�� �����͸� �ӽ÷� ����ߴٰ� ���߿�
	JQuery���� �� �����͸� ����� �������� �����͸� ����ϱ� ����
	�ϳ��� ��å�̴�.
--%>
					<input type="button" data-1="${data.no}" data-2="G" value="���ƿ� (${data.good})" class="recommen">
					<input type="button" data-1="${data.no}" data-2="B" value="������ (${data.bad})" class="recommen">
					<input type="button" class="mBtn" value="�����ϱ�">					
				</td>
			</tr>
		</table>
<%--	 ����� ������ �� �ִ� �� --%>
		<form method="POST" action="../ReBoard/ReplyModify.sun">
		<table width="700" border="1" align="center" style="display:none">
			<input type="hidden" name="oriNo" value="${VIEW.no}">
			<input type="hidden" name="reNo" value="${data.no}">
			<tr>
				<td>�۾���</td>
				<td>
					<input type="text" value="${sessionScope.USER.id}" readonly>
				</td>
			</tr>
			<tr>
				<td>����</td>
				<td><textarea id="body" name="body">${data.body}</textarea>
			</tr>
			<tr>
				<td>��й�ȣ</td>
				<td><input type="password" id="pw" name="pw"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" class="m2Btn" value="�����ϱ�">
					<input type="button" class="rBtn" value="����ϱ�">
				</td>
			</tr>
		</table>
		</form>
	</c:forEach>

</body>
</html>
