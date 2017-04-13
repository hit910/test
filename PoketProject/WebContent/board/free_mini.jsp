<%@page import="com.sistautodb.dao.PokemonVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sist.board.*" %>
<%@page import="java.text.SimpleDateFormat"%>
    <%
    	freeDAO dao = new freeDAO();
    	List<freeVO> list = dao.freeMiniData(1);
    %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="list" value="<%=list %>"></c:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<div id="chatHeader" >
		<img class="chat_ball" alt="���Ϻ�" src="../chat/image/chat_subject.png">
		�����Խ���
		<img class="chat_ball" alt="���Ϻ�" src="../chat/image/chat_subject.png">
	</div>
	
	<div id="chatContent_board_mini">
	<table id="chatTable" >
		<!-- <tr>
			<th width="20%" align="center">��ȣ</th>
			<th width="50%" align="center">����</th>
			<th width="30%" align="center">�г���</th>
			<th width="20%" align="center">��ȸ��</th>
		</tr> -->
		
		<c:forEach var="vo" items="${list }">
		<tr height="34">
			<td width="20%" align="center">
				<img alt="�α��" src="../image/board_image/mini_star.png" width="20">
			</td>
			<td width="50%" align="left">${vo.subject }</td>
			<td width="30%" align="center">${vo.name }</td>
			<%-- <td width="20%" align="center">${vo.hit }</td> --%>
		</tr>
		</c:forEach>
	</table>
	</div>
</body>
</html>