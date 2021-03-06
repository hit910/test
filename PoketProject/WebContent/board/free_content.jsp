<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" import="com.sist.board.*" import="com.sist.user.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("EUC-KR");
	String no = request.getParameter("no");
	freeDAO dao = freeDAO.newInstance();
	freeVO vo=dao.boardContent(Integer.parseInt(no), 1);
	replyDAO dao3 = replyDAO.newInstance();
	List<replyVO> list = dao3.getList(Integer.parseInt(no));
	String str = (String)session.getAttribute("id");
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<!-- BootStrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	var i=0;
	$(function(){
		$('#delBtn').click(function(){
			if(i==0){
				$('#del').show();
				i=1;
			}else{
				$('#del').hide();
				i=0;
			}
		});	
	});
	var p=0;
	$(function(){
		$('#up_del_btn').click(function(){
			if(p==0){
				$('#up_del').show();
				p=1;
			}else{
				$('#up_del').hide();
				p=0;
			}
		});	
	});
	function levup(){
		<% 
		MemberDAO dao2 = MemberDAO.newInstance();
		MemberVO vo2 = dao2.getMember(vo.getId());
		dao2.levUp(vo2, 100,20);
		%>
	};

</script>
</head>
<body>
	<center>
	<div style="margin-top: 15px"></div>
		<img alt="커뮤니티" src="../image/board_image/po.png" width="1000">
		<p>
		<table class="table table-bordered" style="width: 60%">
			<tr>
				<td width="20%" align="center" bgcolor="#f5f5f5">번호</td>
				<td width="30%" align="center"><%=vo.getNo() %></td>
				<td width="20%" align="center" bgcolor="#f5f5f5">작성일</td>
				<td width="30%" align="center"><%=vo.getRegdate().toString() %></td>
			</tr>	
			<tr>
				<td width="20%" align="center" bgcolor="#f5f5f5">이름</td>
				<td width="30%" align="center"><%=vo.getName() %></td>
				<td width="20%" align="center" bgcolor="#f5f5f5">조회수</td>
				<td width="30%" align="center"><%=vo.getHit() %></td>
			</tr>
			<tr>
				<td width="20%" bgcolor="#f5f5f5" align="center">제목</td>
				<td colspan="3"><%=vo.getSubject()%></td>
			</tr>
			<tr>
				<td colspan="4" align="left" valign="top" height="200">
					<%=vo.getContent() %>
				</td>
			</tr>					
		</table>
		
		<table class="table table-bordered" style="width: 60%">
			<tr>
				<td align="left">
				 <input type="button" value="추천"  class="btn btn-default" onclick="levup();">
				</td>
				
				
				<td align="right">		
					<a href="main.jsp?mode=11&no=<%=no%>">
						<input type="button" value="수정" id="WriteBtn" class="btn btn-default">
					</a>
					<input type="button" value="삭제" id="delBtn" class="btn btn-default">
					<a href="main.jsp?mode=5">
						<input type="button" value="목록" class="btn btn-default">
					</a>
				</td>
			</tr>
			<tr id="del" style="display: none;">
				<td colspan="2" align="right">
					<form action="../board/free_delete_ok.jsp" method="post">
						비밀번호 : <input type="password" size="10" name="pwd">
								<input type="hidden" name="no" value="<%=no%>">
						<input type="submit" value="삭제">
					</form>
				</td>
			</tr>
		</table>
		
		<form action="../board/reply_ok.jsp" method="post">
			<table  class="table table-bordered" style="width: 60%" border="1">
				<tr>
					<td width="85%">
						<textarea name="content" rows="3" cols="100"></textarea>
					</td>
					
					<td width="15%">
						<%if(session.getAttribute("name") != null){ %>
						<input type="hidden" name="c_no" value="<%=vo.getNo() %>">
						<input type="hidden" name="name" value="<%=session.getAttribute("name") %>">
						Pwd : <input type="password" name="c_pwd" size="8"></br>
						<input type="submit" value="등록" width="50" height="40">
						<% } else { %>
						로그인 해주세요
						<a href="main.jsp?mode=7"><input type="button" value="Login"></a>
						<% } %>
					</td>
				</tr>
				</table>
		</form>
		
				<table  class="table table-bordered" style="width: 60%" border="1">
				<c:forEach var="vo" items="<%=list %>">
					<tr>
						<td width="85%">
							<textarea name="content" rows="3" cols="100" >${vo.content }</textarea>
						</td>
						<td width="15%">
							${vo.name }</br>
							${vo.date}</br>
							<input type="button" id="up_del_btn" value="수정/삭제">
						</td>
					</tr>
					<tr id="up_del" style="display: none;">
						<td colspan="2" align="right">
						<form action="../board/re_delete.jsp" method="post">
							Pwd : <input type="password" size="10" name="d_pwd">
							<input type="hidden" name="d_id" value="<%=str%>">
							<input type="hidden" name="d_no" value="${vo.no }">
							<input type="hidden" name="content_no" value="<%=vo.getNo()%>">
							<input type="submit" value="삭제">
						</form>
						</td>
					</tr>
				</c:forEach>
			</table>
		</center>
</body>
</html>