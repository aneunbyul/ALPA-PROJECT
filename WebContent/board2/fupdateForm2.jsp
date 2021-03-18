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
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<!-- 헤더들어가는 곳

<!-- 게시판 -->
<%
//String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
//if 세션값이 없으면   ../member/login.jsp 이동
if(id==null){
	response.sendRedirect("../member/login.jsp");
}
//  게시판 글가져오기 
// updateForm.jsp?num=<%=bb.getNum()
int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO bdao 객체생성
BoardDAO2 bdao=new BoardDAO2();
// BoardBean bb=  getBoard(num);
BoardBean bb=bdao.getBoard(num);
%>
<article>
<h1>File Notice Update</h1>
<form action="fupdatePro2.jsp" method="post" enctype="multipart/form-data">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">
<tr><td>글쓴이</td>
<td><input type="text" name="name" value="<%=id%>" readonly></td>
<tr><td>비밀번호</td>
<td><input type="password" name="pass"></td>
<tr><td>글제목</td>
      <td><input type="text" name="subject" value="<%=bb.getSubject()%>"></td></tr>
<tr><td>첨부파일</td>
      <td><input type="file" name="file" ><%=bb.getFile()%>
      <input type="hidden" name="oldfile" value="<%=bb.getFile()%>"></td></tr>      
<tr><td>글내용</td>
<td><textarea name="content" rows="10" cols="20"><%=bb.getContent() %></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="글수정" class="btn">
<input type="button" value="글목록" class="btn" 
              onclick="location.href='fnotice2.jsp'">
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