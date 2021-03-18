<%@page import="member.gameDAO"%>
<%@page import="member.gameBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

String id=(String)session.getAttribute("id");
int score=Integer.parseInt(request.getParameter("score"));

gameBean gb=new gameBean();

gb.setId(id);
gb.setScore(score);


gameDAO gdao =new gameDAO();

 
int check=gdao.scoreCheck(id, score); 

if(check==1){
	gdao.updateScore(gb);
	%>
	<script>
		alert("신기록 달성 !");
		history.back();
	</script>
	<%	
}else if(check==0){
	%>
	<script>
		alert("다시 시작");
		history.back();
	</script>
	<%
}else{
	gdao.insertScore(gb);
	%>
	<script>
		alert("첫기록 달성 !");
		history.back();
	</script>
	<%
}

%>

</body>
</html>