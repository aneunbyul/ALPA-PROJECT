<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardBean"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/event-con.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>
<body>
<div class="container">
<%
// content.jsp?num=<%=bb.getNum()
int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO bdao 객체생성
BoardDAO2 bdao=new BoardDAO2();
// 조회수 1증가  readcount=readcount+1
bdao.updateReadcount(num);
// BoardBean bb=  getBoard(num);
BoardBean bb=bdao.getBoard(num);
%>
<article>
<table id="notice">
<tr><td>글번호</td><td><%=bb.getNum() %></td>
     <td>작성일</td><td><%=bb.getDate() %></td><tr>
<tr><td>글쓴이</td><td><%=bb.getName() %></td>
      <td>조회수</td><td><%=bb.getReadcount() %></td><tr>
<tr><td>글제목</td><td colspan="3"><%=bb.getSubject() %></td><tr>
<tr><td>첨부파일</td>
      <td colspan="3">
      <a href="../upload2/<%=bb.getFile() %>" download><%=bb.getFile() %></a>
      <img src="../upload2/<%=bb.getFile() %>" width="400" height="400">
      파일다운로드 <a href="file_down.jsp?file_name=<%=bb.getFile()%>"><%=bb.getFile() %></a></td><tr>
<tr><td>글내용</td><td colspan="3"><%=bb.getContent() %></td><tr>
</table>
<div id="table_search">
<%
// 글수정, 글삭제  보이기 : 글쓴사람, 로그인사람 일치하면 
// String id 세션값 가져오기 
String id = (String)session.getAttribute("id");
// if 세션값이 있으면 
//  if  세션   글쓴이 비교  일치하면 글수정 글삭제 버튼 보이기
if(id!=null){
	if(id.equals(bb.getName())){
	%>
<input type="button" value="글수정" class="btn" 
        onclick="location.href='fupdateForm2.jsp?num=<%=bb.getNum()%>'">
<input type="button" value="글삭제" class="btn" 
        onclick="location.href='fdeleteForm2.jsp?num=<%=bb.getNum()%>'">	
	<%
	}
}
%>
<input type="button" value="글목록" class="btn" 
              onclick="location.href='fnotice2.jsp'">
</div>
<div class="clear"></div>
<div id="page_control">

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>