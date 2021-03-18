<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/main.css">
<link rel="stylesheet" href="../css/join.css">
<link href="../css/inc.css" rel="stylesheet" type="text/css">
<jsp:include page="../inc/header.jsp"></jsp:include>

<!-- ---------------------------중복확인 ---------------->
<script type="text/javascript">
function dupcheck(){
	if(document.fr.id.value==""){
	alert("아이디 입력하세요");
	document.fr.id.focus();
	return;
	}
// 아이디 상자 입력되었을 경우 
// 	window.open("열문서", "창이름","옵션"); 
var idvalue=document.fr.id.value;
window.open("dupcheck.jsp?id="+idvalue,"","width=400, height=300");
	
}

</script>
<!--------------------------------------- 중복확인 끝 -->


</head>

<body>
<div class="join">
<div class="join-container">
<form action="joinPro.jsp"  method="post" id="join" name="fr">
<div class="info-container">
<fieldset class="fieldset">
<legend>Basic Info</legend>
<label>User ID  </label><input type="text" name="id" class="id" placeholder="아이디">
	<input type="button" value="중복확인" class="dup" value="dup.check" onclick="dupcheck()"><br>
<label>Password  </label><input type="password" class="pass" name="pass" placeholder="영문,숫자,특수문자 2가지이상 조합"><br>
<label>Retype Password  </label><input type="password" class="pass2" name="pass2" placeholder="영문,숫자,특수문자 2가지이상 조합"><br>
<label>Name  </label><input type="text" name="name" placeholder="이름"><br>
<label>E-Mail  </label><input type="email" name="email"placeholder="이메일" ><br>
</fieldset>

<fieldset class="fieldset">
<legend>Optional</legend>
<label>post code  </label>
<input type="text" id="sample6_postcode" name="postCode" placeholder="우편번호">
<input type="button" onclick="sample6_execDaumPostcode()" class="postCode-btn"value="우편번호 찾기"><br>
address  <input type="text" id="sample6_address" name="address" placeholder="주소"><br>
sub address  <input type="text" id="sample6_detailAddress" name="subAddress" placeholder="상세주소"><br>

<label>Phone Number  </label><input type="text" name="phone"placeholder=" - 없이 숫자만 입력"><br>
</fieldset>
</div>

<div id="buttons">
<input type="submit" value="Submit" class="submit">
</div>
</form>
</div>
</div>


<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>



</body>
</html>