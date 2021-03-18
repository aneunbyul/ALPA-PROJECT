<%@page import="member.MemberBean"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/update.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>


<body>

<div class="update-container">
<article>
<%
// String id =  세션값 가져오기
String id=(String)session.getAttribute("id");
//  MemberDAO mdao 객체 생성
MemberDAO mdao=new MemberDAO();
// MemberBean mb = getMember(id) 메서드 만들고 호출
MemberBean mb=mdao.getMember(id);
%>
<form action="updatePro.jsp" id="join" method="post">
<fieldset>
<legend>Basic Info</legend>
	<label>User ID<input type="text" name="id" class="id"  value="<%=mb.getId()%>"  readonly></label><br>
	<label>Password<input type="password" name="pass"></label><br>
	<label>Name<input type="text" name="name" value="<%=mb.getName()%>"></label><br>
	<label>E-Mail<input type="email" name="email" value="<%=mb.getEmail()%>"></label><br>
</fieldset>
<fieldset>
<legend>Optional</legend>
	<label>Address<input type="text" name="address" value="<%=mb.getAddress()%>"></label>	<br>
	<label>Phone Number<input type="text" name="phone" value="<%=mb.getPhone()%>"></label><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
	<input type="submit" value="회원정보수정" class="submit">
	<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
</div>
</body>
</html>