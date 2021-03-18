<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//  fwritePro.jsp 
// 업로드 프로그램 설치 cos.jar

//  request이용,  업로드 폴더 /upload 물리적경로
// , 업로드파일크기 10M  ,  한글처리 , 파일이름 동일하면 이름변경
//  MultipartRequest 객체생성
// String uploadPath=request.getRealPath("/upload");
String uploadPath = request.getSession().getServletContext().getRealPath("/upload");

//이거 저도 겪은건데.

/* WebContent밑에 폴더를 만들더라도 폴더내부가 비어있으면 컴파일하 때 해당 폴더는 안만들어져요.
그래서 /upload 폴더가 없어서 해당 폴더에 이미지를 올릴수 없는거에요!.
gh선생님은 어떻게 성공하셨는지 궁금하군요... */
File f = new File(uploadPath);
if(!f.exists()) {
	f.mkdir();
}

// 저는 이렇게 파일이 없으면 만들어주는식으로 해결했슴다.

int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

 // 파라미터 가져오기 변수에 저장
 String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
//date 글쓴날짜
Timestamp date=new Timestamp(System.currentTimeMillis());
//readcount  조회수
int readcount=0;
// file 
String file=multi.getFilesystemName("file");
 
 // BoardBean bb 바구니에 객체생성
 BoardBean bb=new BoardBean();
 //  멤버변수에 파라미터값 저장
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setDate(date);
bb.setReadcount(readcount);
//file
bb.setFile(file);

 // BoardDAO bdao 객체생성
 BoardDAO bdao=new BoardDAO();
 // insertBoard(bb) 메서드 만들고 호출
 bdao.insertBoard(bb);
 
 // notice.jsp 이동
 response.sendRedirect("fnotice.jsp");
%>