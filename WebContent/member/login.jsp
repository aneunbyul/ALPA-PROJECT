<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/login.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>
</head>

<body>
	<form action="loginPro.jsp" class="login" method="post">
	<div class="container">
	
	<div class="login-container">
	<h3> what is you're name? </h3>
	<fieldset>
	<legend>Login Info</legend>
	<label>User ID</label>
	<input type="text" name="id"><br>
	<label>Password</label>
	<input type="password" name="pass"><br>
	</fieldset>
	
	<div class="buttons">
	<input type="submit" value="Submit" class="submit">
	</div>
	</div>
	</div>
	</form>

</body>
</html>