<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="mb" class="member.MemberBean">
<jsp:setProperty name="mb" property="*"/>

</jsp:useBean>

<%

// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();






String id=request.getParameter("id");
String pass=request.getParameter("pass");
mb.setId(id);
mb.setPass(pass);   
// int check = userCheck(id,pass) 정의 호출
int check=mdao.userCheck(id, pass);
// check==1 아이디비밀번호 일치 updateMember(mb)  main.jsp 이동
// check==0  "비밀번호틀림" 뒤로이동 
// check==-1 "아이디없음" 뒤로이동
if(check==1){
	//  member 테이블  수정 name,email,address,phone,mobile
	//                         조건 id
	mdao.updateMember(mb);
	%>
	<script>
		alert("수정성공");
		location.href="../main/main.jsp";
	</script>
	<%	
}else if(check==0){
	%>
	<script>
		alert("비밀번호틀림");
		history.back();
	</script>
	<%
}else{
	%>
	<script>
		alert("아이디없음");
		history.back();
	</script>
	<%
}

%>