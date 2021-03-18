<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="tetris.css">
</head>
<body>

        <div id="gameField">
            <div id="gameover">
                <center>
                    <h1>Game Over</h1>
                    <h4>press 'F5' to restart</h4>
                </center>
            </div>
            <div id="pause">
                <center>
                    <h1>Pause</h1>
                    <h4>press 'F5' to resume</h4>
                </center>
            </div>
            <table id="nextTable" border=0>
                <tr><td id="00"></td><td id="01"></td><td id="02"></td><td id="03"></td></tr>
                <tr><td id="10"></td><td id="11"></td><td id="12"></td><td id="13"></td></tr>
                <tr><td id="20"></td><td id="21"></td><td id="22"></td><td id="23"></td></tr>
                <tr><td id="30"></td><td id="31"></td><td id="32"></td><td id="33"></td></tr>
            </table>
            <div id="scoreField">
                <p class="sub">LEVEL</p>
                <p id="level">1</p>
                <p class="sub">SCORE</p>
                <p id="score">0</p>
                <p class="sub">NEXT</p>
                <p><br><br><br></p>
                <p class="sub">HELP</p>
                <p id="help">← ↓ →</p>
                <p id="help">Space Bar</p>
                <p id="help">P to pause</p>
                <p class="sub" id="about" onclick="info()">ABOUT</p>
                <div id="comboField"><i></i></div>
            </div>
        
 <%
String id=(String)session.getAttribute("id");

if(id==null) {
	%> 
		<% 
} else {
	%>
	<div class="log"><%=id %>님 도전중! </div>
	<%
}
%>   



          	<form action="scorePro.jsp" method="post" name="scoreForm">
          		<input type="hidden" name="score" class="score-js" value="0"/>
<!--           		<button>전송</button> -->
          	</form>
            <script type="text/javascript" src="tetris.js"></script>
          
            
            
            
            
            
</body>
</html>