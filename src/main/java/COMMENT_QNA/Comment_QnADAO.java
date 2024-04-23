package COMMENT_QNA;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;

import java.sql.PreparedStatement;

public class Comment_QnADAO {
	private Connection conn;
	private ResultSet rs;
	
	public Comment_QnADAO() { //데이터 접근 객체
		try {
			String dbURL = "jdbc:mysql://144.24.87.149:3306/BBS";
			String dbID = "qowjdgns0106";
			String dbPassword = "Doqemddl1!";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String comment_getDate() { //현재 시간 가져오기
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //SQL 문장을 실행 준비 단계로 만들기
			rs = pstmt.executeQuery(); //실제로 실행했을때 결과를 가져옴
			if (rs.next()) { //결과가 있다면 실행
				return rs.getString(1); //날짜 반환
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	public int comment_getNext() { //댓글 번호 부여하기
		String SQL = "SELECT COMMENT_NUM FROM COMMENT_QNA ORDER BY COMMENT_NUM DESC"; //댓글 번호 부여를 위해 맨 마지막에 쓰인 아이디 가져오기
		try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				rs = pstmt.executeQuery();
				if (rs.next()) { 
					return rs.getInt(1)+1; //위에서 가져온거에서 1 더해서 댓글번호 숫자 하나 늘려줌
				}
			}
		
		catch (Exception e){
			e.printStackTrace();
		}
		return 1;  //첫 번째 댓글인 경우
	}

	public int comment_write(String COMMENT_userID, int bbsID, String COMMENT_comment) {
		String SQL = "INSERT INTO COMMENT_QNA VALUES(?, ?, ?, ?, ?, ?)"; //bbs테이블 안에 6개 인자 집어넣기
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_getNext()); //위에 ?라고 써뒀던 테이블에 넣을 애들
			pstmt.setInt(2, bbsID); 
			pstmt.setString(3, COMMENT_userID);
			pstmt.setString(4, comment_getDate());
			pstmt.setString(5, COMMENT_comment);
			pstmt.setInt(6, 1); //available이라 1 넣음..
			return pstmt.executeUpdate(); //성공적일시 상수 반환
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Comment_QnA> comment_getList(int bbsID){
		String SQL = "SELECT * FROM COMMENT_QNA WHERE COMMENT_bbsID = ? AND COMMENT_Available = 1 ORDER BY COMMENT_NUM DESC"; 
		//bbsID가 특정일 때, 그리고 댓글이 삭제가 되지 않았을 때
		ArrayList<Comment_QnA> list = new ArrayList<Comment_QnA>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while (rs.next()) { 
				Comment_QnA comment_qna = new Comment_QnA();
				comment_qna.setCOMMENT_NUM(rs.getInt(1)); 
				comment_qna.setCOMMENT_bbsID(rs.getInt(2));
				comment_qna.setCOMMENT_userID(rs.getString(3));
				comment_qna.setCOMMENT_date(rs.getString(4));
				comment_qna.setCOMMENT_comment(rs.getString(5));
				comment_qna.setCOMMENT_Available(rs.getInt(6));
				list.add(comment_qna); //게시글 목록을 담아서 리스트에 인스턴스 담아서 반환
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return list; //게시글 리스트 반환
	}
	
}