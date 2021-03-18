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
<link rel="stylesheet" href="../css/event.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>
<body>
<div class="container">


<%
BoardDAO2 bdao=new BoardDAO2();
int count=bdao.getBoardCount();

int pageSize=15;

String pageNum=request.getParameter("pageNum");
if(pageNum==null){
	pageNum="1";
}
int currentPage=Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
int endRow = currentPage*pageSize;
List<BoardBean> bbList=bdao.getBoardList(startRow,pageSize);
SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
%>

<div class="event-container">
	<div class="envet-content">
	 <%
    for(int i=0;i<bbList.size();i++){
    	BoardBean bb=bbList.get(i);
    	%>
    <ul class="event-ul">
   <li class="event-li">
      <%
      if(bb.getFile()!=null){ %>
		<img src="../upload2/<%=bb.getFile() %>" width="100%" height="200" onclick="location.href='fcontent2.jsp?num=<%=bb.getNum()%>'">
    	  <%  } %> </li>
	<li class="event-li">      <%=bb.getSubject() %></li>
	<li class="event-li">     <%=sdf.format(bb.getDate()) %></li>
    </ul><	
    	<%}   %>
    </div>
    </div>
    
    
    
    <div class="bottom">
    
<%
// String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
// if 세션값이 있으면  글쓰기 버튼 보이기
if(id!=null){
	%>
<input type="button" value="글쓰기" class="btn" 
                       onclick="location.href='fwriteForm2.jsp'">	
	<%
}
%>
    
<div class="clear"></div>
<div class="page_control">
<%
// 한화면에 보여줄 페이지개수 설정
int pageBlock=12;
// 한화면에 보여줄 시작페이지번호 구하기
// 1~10 => 1  , 11~20 -> 11
int startPage=((currentPage-1) /pageBlock)*pageBlock + 1;
// 한화면에 보여줄 끝페이지번호 구하기
int endPage=startPage+pageBlock-1;
// 전체페이지개수 구하기
int pageCount=count/pageSize+(count%pageSize==0?0:1);
if(endPage > pageCount){
	endPage=pageCount;
}
if(startPage > pageBlock){
	%><a href="fnotice2.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a><%
}
for(int i=startPage;i<=endPage;i++){
	%><a href="fnotice2.jsp?pageNum=<%=i%>"><%=i %></a><%
}
if(endPage < pageCount){
	%><a href="fnotice2.jsp?pageNum=<%=startPage+pageBlock%>">Next</a><%
}
%>

</div>
</div>
</div>
</body>
</html>