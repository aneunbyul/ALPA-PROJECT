<%@page import="member.gameDAO"%>
<%@page import="member.gameBean"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/rank.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>
<body>
<div class="container">
<div class="rank-container">


<%
gameDAO gdao=new gameDAO();

int startRank=1;
int num=5;


List<gameBean> scoreList=gdao.getScoreList(startRank,num);
%>


<table border="1" class="rank-table">
<tr><td>순위</td><td>아이디</td><td>점수</td></tr>
      <%
   for(int i=0;i<num;i++){
	   gameBean gb=scoreList.get(i);
	   %>
	   <tr><td><%=i+1 %></td>
	   <td><%=gb.getId() %></td>
      <td><%=gb.getHighScore() %></td></tr><%
   }
      %>
      
</table>


</div>

</div>


</body>
</html>