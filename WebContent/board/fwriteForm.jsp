
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>
<body>
<div class="notice-container">
<%
//String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
//if 세션값이 없으면   ../member/login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}
%>
<article>
<h1>File Notice Write</h1>
<form action="fwritePro.jsp" method="post" enctype="multipart/form-data">
<table id="notice">
<tr><td>글쓴이</td>
<td><input type="text" name="name" value="<%=id%>" readonly></td>
<tr><td>비밀번호</td>
<td><input type="password" name="pass"></td>
<tr><td>글제목</td><td><input type="text" name="subject"></td></tr>
<tr><td>첨부파일</td><td><input type="file" name="file"></td></tr>
<tr><td>글내용</td>
<td><textarea name="content" rows="10" cols="20"></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글쓰기" class="btn">
<input type="button" value="글목록" class="btn" 
              onclick="location.href='fnotice.jsp'">
</div>
</form>
<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>