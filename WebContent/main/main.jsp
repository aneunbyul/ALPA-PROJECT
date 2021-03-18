<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link rel="stylesheet" href="../css/main.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>


<title>Insert title here</title>
</head>
<body>
<div class="main-container">
   <div class="main-text">
	<p>This is a story, all about how, </p>
	<p>My life got twisted upside down. </p>
	<p>So I'd like to tell a story, just sit right there. </p>
	<p>And I'll tell you how I became only survivor from the earth.</p>
	<p></p>
	<p></p>
	<p>.. Are you ready to listen?  </p>
	<div class="start-container" >
	
	
<%
String id=(String)session.getAttribute("id");

if(id==null) {
	%> 
	<a href="../member/login.jsp">No, i have to login first.◀</a></div>
	<%
} else {
	%>
	<a href="../game/tetris.jsp">yes, i'm ready to start.  ◀</a></div>
	<%
}
%>
	
	</div>	
 </div>
 
 
 
</body>
</html>