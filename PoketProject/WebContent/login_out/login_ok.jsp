<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" %>
<%@page import="com.sist.user.MemberDAO" %>
<%@page import="javafx.scene.control.Alert" %>
<jsp:useBean id="accessUserCount" class="java.util.ArrayList" scope="application" />
<%
	String id=request.getParameter("id");
	String pwd=request.getParameter("pwd");
	
	//DB����
	MemberDAO dao=MemberDAO.newInstance();
	int res=dao.isLogin(id, pwd);
	
	if(res==0){
%>
	<script>
		alert("ID�� Ȯ���ϼ���.")
		history.back();
	</script>
<%
	}else if(res==1){
%>
	<script>
		alert("��й�ȣ�� Ʋ�Ƚ��ϴ�.")
		history.back();
	</script>
<%
	}else if(res==2){
		String name=dao.getLogData(id);
		session.setAttribute("id", id);
		session.setAttribute("name", name);
		
		//������ ����Ʈ�� �߰�
		HashMap userInfo = new HashMap();
		userInfo.put("sessionId",session.getId());
		userInfo.put("id",id);
		userInfo.put("name",name);
		userInfo.put("accessTime",System.currentTimeMillis());
		accessUserCount.add(userInfo);
		System.out.println(id);
		
		//�ʱ� ������
		response.sendRedirect("../main/main.jsp");
	}
%>