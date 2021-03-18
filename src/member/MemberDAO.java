package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.regex.Pattern;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class MemberDAO {
	// 멤버변수
	// 디비연결 1,2단계 메서드()
	public Connection getConnection() throws Exception {
		
		Context init=new InitialContext();
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con=ds.getConnection();
		return con;
	}
	
	//리턴할형없음 insertMember(하나의 바구니 주소) 메서드 정의
	public void insertMember(MemberBean mb) {
		System.out.println("폼에서 전달받은 값  id :"+mb.getId());
		System.out.println("폼에서 전달받은 값  pass :"+mb.getPass());
		System.out.println("폼에서 전달받은 값  name :"+mb.getName());
		System.out.println("폼에서 전달받은 값  email :"+mb.getEmail());
		System.out.println("폼에서 전달받은 값  address :"+mb.getAddress());
		System.out.println("폼에서 전달받은 값  sub_address :"+mb.getSubAddress());
		System.out.println("폼에서 전달받은 값  post_code :"+mb.getPostCode());
		System.out.println("폼에서 전달받은 값  phone :"+mb.getPhone());
		
		// 내장객체 선언
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		
		try {
			//에러가 발생할 소지가 있는 구문을 작성
			// 1단계 드라이버로더			// 2단계 디비연결
			con=getConnection();
			// 3단계 sql구문 준비
			String sql="insert into member(id,pass,name,email,address,sub_address,post_code,phone) values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			// ?값 넣기
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3,mb.getName());
			pstmt.setString(4,mb.getEmail());
			pstmt.setString(5,mb.getAddress());
			pstmt.setString(6,mb.getSubAddress());
			pstmt.setString(7,mb.getPostCode());
			pstmt.setString(8,mb.getPhone());

			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			//에러 처리 추적해서 출력
			e.printStackTrace();
		}finally {
			// 에러가 발생 상관없이 마무리 작업, 기억장소 해제
			//마무리 //  사용한 내장객체(기억장소) 해제
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
		return;
	}//메서드
	
	// MemberBean mb  = getMember(id) 메서드 정의
	public MemberBean getMember(String id) {
		// 내장객체 선언
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		// id, pass,name,date를 저장할 바구니를 준비(기억장소 준비)
		MemberBean mb=new MemberBean();
		try {
			// 예기치 못한 에러 발생
			// 1단계 드라이버로더			// 2단계 디비연결
			con=getConnection();
			// 3단계 sql 구문 준비
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 실행 => 결과 저장
			rs=pstmt.executeQuery();
			// 5단계 결과 다음행이동 했때 데이터 있으면 true 
			if(rs.next()) {
				System.out.println("디비에서 가져온 아이디 : " +rs.getString("id"));
				System.out.println("디비에서 가져온 비밀번호 : " +rs.getString("pass"));
				System.out.println("디비에서 가져온 이름 : " +rs.getString("name"));

				System.out.println("디비에서 전달받은 email :"+rs.getString("email"));
				System.out.println("디비에서 전달받은 address :"+rs.getString("address"));
				System.out.println("디비에서 전달받은 sub_address :"+rs.getString("sub_address"));
				System.out.println("디비에서 전달받은 post_code :"+rs.getString("post_code"));
				// MemberBean  id변수에 저장 set() <=   디비에서 가져온 rs 에 id
				//  멤버변수 pass,name,date  set() <- rs
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setSubAddress(rs.getString("sub_address"));
				mb.setPostCode(rs.getString("post_code"));
			}
			
		} catch (Exception e) {
			// 에러 처리 추적해서 출력
			e.printStackTrace();
		}finally {
			// 에러 상관없이 마무리
			//마무리 //  사용한 내장객체(기억장소) 해제
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
		return mb;
	}//메서드
	
	
	
//------------------- 회원가입폼 중복체크----------------------------
	 
	  //비밀번호 패턴 확인 
	   public int passCheck(String pass) {
	      String lengthRegex="[a-z0-9!@#]{8,20}";
	      String engLowerRegex="[a-z]";
	      String numRegex="[0-9]";
	      String specRegex="[!@#]";
	      
	      int check2 = 0;
	      
	      if(Pattern.matches(lengthRegex, pass)) {
	         check2 += Pattern.compile(engLowerRegex).matcher(pass).find() ? 1 : 0;
	         check2 += Pattern.compile(numRegex).matcher(pass).find() ? 1 : 0;
	         check2 += Pattern.compile(specRegex).matcher(pass).find() ? 1 : 0;
	      } else {
	         check2 = -1;
	      }
	      
	      return check2;
	   }
	
	

	
	
//-------------------------------------------------로그인 회원정보 확인------------------------------------
	// int check =  userCheck(id,pass)
	public  int userCheck(String id,String pass) {
		// 내장객체 선언
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		// 보안상 아이디 비밀번호 틀림  초기값 
		int check=-1;
		try {
			// 1,2 단계 디비연결 메서드 호출
			con=getConnection();
			// 3단계 id조건 만족하는 member정보 가져오기 sql구문
			// 3단계 sql 구문 만들고 실행할 준비 폼 id  디비 id 비교
		//  member 조건 디비 id열에서 폼id값 일치하면 가져오기
			String sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 sql 구문 실행 => 결과저장
			// 데이터베이스에서 디비id와  폼에서 가져온  id 비교 해서
			// 일치하면 결과 가져오기, 일치하지 않으면 결과 없음
			// 4단계 실행=> rs 결과 저장
			rs=pstmt.executeQuery();
			// 5단계 rs 다음행으로 이동 데이터있으면 true  아이디있음
			//         비밀번호 비교 일치하면 check=1 틀리면 check=0
			//                                      없으면 false 아이디없음 check=-1
			if(rs.next()) {
				//아이디있음
				if(pass.equals(rs.getString("pass"))) {
					check=1;//비밀번호 일치 신호 1
				}else {
					check=0;//비밀번호 틀림  신호 0
				}
			}else {
				check=-1;//아이디없음  신호를 -1
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리 //  사용한 내장객체(기억장소) 해제
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
		return check;
	}
	
	
	// mdao.updateMember(mb);
	public void updateMember(MemberBean mb) {
		// 내장객체 선언
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		try {
			// 1,2 단계 메서드 호출
			con=getConnection();
			// 3단계 sql 구문 update 준비 수정name=?  조건 id=?
			String sql="update member set name=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, mb.getName());
			pstmt.setString(2, mb.getId());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리 작업
			//마무리 //  사용한 내장객체(기억장소) 해제
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
	}
	
	
	//mdao.deleteMember(id);
	public void deleteMember(String id) {
		// 내장객체 선언
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		try {
			// 1,2 디비연결
			con=getConnection();
			// 3 sql 구문 준비 delete 조건 id=?
			// 회원삭제
			String sql="delete from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			//마무리 //  사용한 내장객체(기억장소) 해제
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
	}

	// List mbList= getMemberList()
	public List getMemberList() {
		// 내장객체 선언
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		// 한명,한명  여러명을 배열List 담아서 다른곳으로 전달
		// 부모인터페이스 =new   자식클래스 객체생성
		List mbList=new  ArrayList();
		try {
			//1,2디비연결
			 con=getConnection();
			// 3sql 준비 select 모든 member  가져오는 sql 구문 준비
			String sql="select * from member";
			pstmt=con.prepareStatement(sql);
			// 4실행 => 결과 저장
			rs=pstmt.executeQuery();
			// 5단계 다음행으로 이동 데이터 있으면 true 
			//       한사람의 정보를 저장할 기억장소 할당
			//      MemberBean mb 객체생성
			//      mb.setId(rs.getString("id"))
			//  한사람의 정보를 배열(mbList)에 한칸에 저장
			while(rs.next()) {
				// 한사람의 정보를 저장 
				MemberBean mb=new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				// 한사람의 정보를 List배열에 한칸에 저장
				mbList.add(mb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			//마무리 //  사용한 내장객체(기억장소) 해제
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
		return mbList;
	}
	
	
	
	//-----------메일보내기=-================
	
	public static void naverMailSend(String email) { 
		String host = "smtp.naver.com"; 
		String user = "kingbar222@naver.com"; 
		String password = "dksdmsquf22!!";

		Properties props = new Properties(); 
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", "true");

		
		Session session = Session.getDefaultInstance(props, new Authenticator() {
			 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(user, password);
				} 
			});

		try {
			MimeMessage message = new MimeMessage(session); 
			message.setFrom(new InternetAddress(user)); 
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(email)); //받는사람 메일주소
		
		//메일제목
		message.setSubject("welcome to ALPA !");

		//메일 내용
		message.setText("회원가입을 축하합니다");

		//
		Transport.send(message); 
		System.out.println("Success Message Send");

		} catch (MessagingException e) { 
			e.printStackTrace();
		}

		
		
	} ///이메일보내기 끝
	
	
	
	//--------------------------아이디 중복확인
	
	// int check= iddupcheck(id) 메서드 정의 하고 호출
		public int iddupcheck(String id) {
			int check=-1;
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			try {
				//1,2 디비연결
				con=getConnection();
				//3 sql 구문 준비  id=?
				String sql="select * from member where id=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, id);
				// 4 sql실행 결과 저장
				rs=pstmt.executeQuery();
				// 5 다음행으로 이동 했을때  데이터 있으면 check=1
				//                                             없으면 check=-1
				if(rs.next()) {
					check=1; // 아이디 있음, 아이디 중복
				}else {
					check=-1; // 아이디 없음, 아이디 사용가능
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				if(rs!=null) try {rs.close();}catch (SQLException ex) {}
				if(pstmt!=null) try {pstmt.close();}catch (SQLException ex) {}
				if(con!=null) try {con.close();}catch (SQLException ex) {}
			}
			return check;
		}//아이디 중복확인 끝
	
}//클래스
