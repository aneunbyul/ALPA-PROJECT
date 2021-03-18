<%@page import="member.MemberDAO"%>
<%@page import="member.MemberBean"%>
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
<!-- 이건 자바코드가 아니라 제이에스피 코드입니다. 그래서 그냥 여기 적어줘야해요네!
여기 적은 id가 이거랑 같아요! 변수명입나더!
class는 전체 경로를 적어줘야 해요 src 밑에서 부터 !

이렇게만하면 저렇게만 한거랑 같습니다.
이제 값을 넣어줘야죠 sp -->

<jsp:useBean id="mb" class="member.MemberBean">
	<jsp:setProperty name="mb" property="*"/>

</jsp:useBean>


<%




/* 여기 파라미터로 받는 이것들 input name이랑 MemberBean에 있는 멤버변수랑 이름이 똑같져?
		네!
		꼭 같아야지만 가능합니다. */
/* String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String address=request.getParameter("address");
String subAddress=request.getParameter("subAddress");
String postCode=request.getParameter("postCode");
String phone=request.getParameter("phone");

System.out.println(subAddress);
System.out.println(postCode);

MemberBean mb=new MemberBean();

mb.setId(id);
mb.setPass(pass);
mb.setName(name);
mb.setEmail(email);
mb.setAddress(address);
mb.setSubAddress(subAddress);
mb.setPostCode(postCode);
mb.setPhone(phone); */

MemberDAO mdao =new MemberDAO();






String id=request.getParameter("id");
String pass=request.getParameter("pass");
String email=request.getParameter("email");
mb.setId(id);
mb.setPass(pass);  
mb.setEmail(email);  

mdao.naverMailSend(email);
	 
int check2=mdao.passCheck(pass); 
boolean isCheck = true; 
if(check2>=2) {
	   session.setAttribute("pass", pass);
	   
		mdao.insertMember(mb);
	 
	} else if(check2<=1){
		isCheck = false;
	  
	} 

	   %> 


<script>


const isCheck = <%= isCheck%>;
if(isCheck) {
	alert("회원가입성공");
	location.href="login.jsp";
	
} else {
	alert("비밀번호 형식 틀림");
    history.back();
}
</script>

</body>
</html>