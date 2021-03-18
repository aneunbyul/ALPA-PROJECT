package member;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;




public class gameDAO {

	// 디비연결 1,2단계 메서드()
	public Connection getConnection() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		// 2단계 디비연결
		String dbUrl="jdbc:mysql://localhost:3306/alpa";
		String dbUser="root";
		String dbPass="1234";
		Connection con=DriverManager.getConnection(dbUrl,dbUser,dbPass);
		return con;
	}
	
	public void insertScore(gameBean gb) {
		System.out.println("폼에서 전달받은 값  id :"+gb.getId());
//		System.out.println("폼에서 전달받은 값  HighScore :"+gb.getHighScore());
		System.out.println("폼에서 전달받은 값  Score :"+gb.getScore());
		
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		
		try {
			con=getConnection();
			
			String sql="insert into games(id,high_score,score) values(?,?,?)";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, gb.getId());
			pstmt.setInt(2, gb.getScore());
			pstmt.setInt(3, gb.getScore());

			pstmt.executeUpdate();
		} catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
		return;
	}//메서드
	
	
	public gameBean getGame(String id) {
		
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		gameBean gb=new gameBean();
		try {
			con=getConnection();
			
			String sql="select * from games where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("디비에서 가져온 아이디 : " +rs.getString("id"));
				System.out.println("디비에서 가져온 highScore : " +rs.getInt("high_score"));
				System.out.println("디비에서 가져온 Score : " +rs.getString("score"));
				
				gb.setId(rs.getString("id"));
				gb.setHighScore(rs.getInt("high_score"));
				gb.setScore(rs.getInt("score"));
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
		return gb;
	}//메서드
	
	//=====================================
	public  int scoreCheck(String id,int score) {
		// 내장객체 선언
		Connection con=null;
		ResultSet rs=null;
		PreparedStatement pstmt=null;
		
		int check=-1;
		try {
			con=getConnection();
			String sql="select * from games where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {	//데이터가 있을때  update
			
				if(score > rs.getInt("high_score")) {
					check=1;//신기록 갱신 = 1
				}else {
					check=0;//신기록 갱신 못함 = 0
				}
				System.out.println(check);
			}else {	check=-1;
				
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
	
	
	
	
	public void updateScore(gameBean gb) {
		try {
			// 1,2 단계 메서드 호출
			Connection con=getConnection();
			// 3단계 sql 구문 update 준비 수정name=?  조건 id=?
			String sql="update games set high_score=?, score=? where id=?";
			PreparedStatement pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, gb.getScore());
			pstmt.setInt(2, gb.getScore());
			pstmt.setString(3, gb.getId());
			// 4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			// 마무리 작업
		}
}
	
	public List<gameBean> getScoreList(int startRank,int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<gameBean> scoreList=new ArrayList<gameBean>();
		
		try {
			con=getConnection();
			String sql="select * from games order by high_score desc limit ?,?";			
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRank-1);  //시작순위
			pstmt.setInt(2, num);  //랭커수
			rs=pstmt.executeQuery();
			// 5단계 while 저장 rs 다음행 이동 데이터 있으면 true
			//          한개의 글 저장 BoardBean bb 객체생성
			//          set메서드 호출 <- rs.get name pass..
			//         배열 bbList 한칸에 저장  add(한개글 바구니 주소)
			while(rs.next()) {
				// 게시판 글 하나를 BoardBean 바구니에 담아서 준비
				gameBean gb=new gameBean();
				gb.setHighScore(rs.getInt("high_score"));
				gb.setId(rs.getString("id"));
				gb.setScore(rs.getInt("score"));
				scoreList.add(gb);
				// 실행한번 해볼까요.
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리 //  사용한 내장객체(기억장소) 해제
			if(pstmt!=null) 	try {	pstmt.close(); } catch (SQLException ex) { }
			if(rs!=null) 	        try {	rs.close(); } catch (SQLException ex) { }
			if(con!=null) 	    try {	con.close(); } catch (SQLException ex) { }
		}
		return scoreList;
	} 
	
	
	
	
	
	
	
	
	
	
	
}
