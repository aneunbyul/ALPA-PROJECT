<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link rel="stylesheet" href="../css/modal.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>
<body>

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
<!-- notice 불러오기-->

<%
// content.jsp?num=<%=bb.getNum()
int num=Integer.parseInt(request.getParameter("num"));
// BoardDAO bdao 객체생성
// 조회수 1증가  readcount=readcount+1
bdao.updateReadcount(num);
// BoardBean bb=  getBoard(num);
BoardBean bb=bdao.getBoard(num);
%>

<!-- 컨텐츠불러오기 -->

		<div class="event-container">
				<div class="envet-content">


<!-- ============================================================== -->
<!-- Button -->
<div class="page-wrapper">
  <a class="btn trigger" href="#">
   <%
    for(int i=0;i<bbList.size();i++){
    	bb=bbList.get(i);
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
			    </div></div> 
<!-- 			    버튼들어가는 부분 -->
  </a>
</div>

<!-- Modal -->
<div class="modal-wrapper">
  <div class="modal">
    <div class="head">
      <a class="btn-close trigger" href="#">
      
        <i class="fa fa-times" aria-hidden="true"></i>
      </a>
    </div>
    <div class="content">
        <div class="good-job">
          <i class="fa fa-thumbs-o-up" aria-hidden="true"></i>
          <h1><%=bb.getContent() %></h1>
        </div>
    </div>
  </div>
</div>

</body>
</html>