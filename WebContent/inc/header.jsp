<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<div id="logo"> alpa-project</div>
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">HOME</a></li>
	<li><a href="../game/rank.jsp">RANK</a></li>
	<li><a href="../board/fnotice.jsp">Q/A</a></li>
	<li><a href="../board2/fnotice2.jsp">event</a></li>
	
<%
String id=(String)session.getAttribute("id");

if(id==null) {
	%> 
		<li><a href="../member/join.jsp">join</a></li>	
	<li><a href="../member/login.jsp">login</a></li>
	<%
} else {
	%>
	<li><a href="../member/updateForm.jsp">my page</a></li>
	<li><a href="../member/logout.jsp">logout</a></li>
	<li><div class="log"><%=id %>님 환영합니다 </div></li>
	<%
}
%>
</ul>
</nav>

</header>
