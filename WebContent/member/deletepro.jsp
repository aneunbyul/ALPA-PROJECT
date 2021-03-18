<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>member/deletePro.jsp</h1>
<%
// request 에 저장된 파라미터(id,pass) 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");
// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// int check= userCheck(id,pass)
int check=mdao.userCheck(id, pass);
// check==1  deleteMember(id)  만들고 호출 
//               세션값 전체삭제 , main.jsp  
// check==0 "비밀번호틀림" 뒤로이동
// check==-1 "아이디 없음" 뒤로이동
if(check==1){
	mdao.deleteMember(id);
	//세션 전체 삭제
	session.invalidate();
	//main.jsp 이동
	response.sendRedirect("main.jsp");
}else if(check==0){
	%>
	<script type="text/javascript">
	alert("비밀번호 틀림");
	history.back();
	</script>
	<%
}else{
	%>
	<script type="text/javascript">
	alert("아이디틀림");
	history.back();
	</script>
	<%
}
%>
</body>
</html>


