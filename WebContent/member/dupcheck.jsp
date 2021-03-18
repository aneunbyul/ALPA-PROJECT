<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function ok() {
		// window.opener 변수 : join.jsp에서 window.open(dupcheck.jsp) 창열기
		// dupcheck.jsp 에서 창을 열리게 한 페이지 join.jsp 를 opener변수에 저장
// 		join.jsp 아이디상자 value= dupcheck.jsp에서 찾은 아이디 value 
		alert("찾은 아이디 : "+document.wfr.id.value);
		window.opener.document.fr.id.value=document.wfr.id.value;
		// 창닫기
		window.close();
	}
</script>
</head>
<body>
<!-- member/dupcheck.jsp -->
<h1>member/dupcheck.jsp </h1>
<%
// http://localhost:8080/FunWeb/member/dupcheck.jsp?id=dd
// http가 id파라미터 값을 들고 옴 => request 저장
String id=request.getParameter("id");
// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// int check= iddupcheck(id) 메서드 정의 하고 호출
int check=mdao.iddupcheck(id);
// check==1  "아이디 있음" "아이디 중복"
// check==-1 "아이디 없음" "아이디 사용가능"  
if(check==1){
	%>아이디 중복<%
}else{
	%>아이디 사용가능 
	<input type="button" value="아이디사용" onclick="ok()"><%
}
%>
<form action="dupcheck.jsp" method="get" name="wfr">
아이디 : <input type="text" name="id" value="<%=id%>"><br>
<input type="submit" value="아이디중복체크">
</form>
</body>
</html>