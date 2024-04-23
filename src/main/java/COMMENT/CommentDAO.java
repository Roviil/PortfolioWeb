package COMMENT;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.sql.PreparedStatement;

public class CommentDAO {
	private Connection conn;
	private ResultSet rs;
	
	public CommentDAO() { //데이터 접근 객체
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
		String SQL = "SELECT COMMENT_NUM FROM COMMENT ORDER BY COMMENT_NUM DESC"; //댓글 번호 부여를 위해 맨 마지막에 쓰인 아이디 가져오기
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
	
	public int comment_write(String COMMENT_userID, int bbsID, String COMMENT_comment, String COMMENT_userNickname) {
		String SQL = "INSERT INTO COMMENT VALUES(?, ?, ?, ?, ?, ?, ?)"; //bbs테이블 안에 6개 인자 집어넣기
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_getNext()); //위에 ?라고 써뒀던 테이블에 넣을 애들
			pstmt.setInt(2, bbsID); 
			pstmt.setString(3, COMMENT_userID);
			pstmt.setString(4, comment_getDate());
			pstmt.setString(5, COMMENT_comment);
			pstmt.setInt(6, 1); //available이라 1 넣음..
			pstmt.setString(7, COMMENT_userNickname);
			return pstmt.executeUpdate(); //성공적일시 상수 반환
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Comment> comment_getList(int bbsID){
		String SQL = "SELECT * FROM COMMENT WHERE COMMENT_bbsID = ? AND COMMENT_Available = 1 ORDER BY COMMENT_NUM DESC"; 
		//bbsID가 특정일 때, 그리고 댓글이 삭제가 되지 않았을 때
		ArrayList<Comment> list = new ArrayList<Comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while (rs.next()) { 
				Comment comment = new Comment();
				comment.setCOMMENT_NUM(rs.getInt(1)); 
				comment.setCOMMENT_bbsID(rs.getInt(2));
				comment.setCOMMENT_userID(rs.getString(3));
				comment.setCOMMENT_date(rs.getString(4));
				comment.setCOMMENT_comment(rs.getString(5));
				comment.setCOMMENT_Available(rs.getInt(6));
				comment.setCOMMENT_userNickname(rs.getString(7));
				list.add(comment); //게시글 목록을 담아서 리스트에 인스턴스 담아서 반환
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return list; //게시글 리스트 반환
	}
	
	public int delete(int comment_num) {
		String SQL = "UPDATE COMMENT SET COMMENT_Available = 0 WHERE COMMENT_NUM = ?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_num); //ID를 저 물음표에 넣어서 ID값의 글을 삭제
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public Comment getComment(int comment_num) {
		String SQL = "SELECT * FROM COMMENT WHERE COMMENT_NUM = ?"; 
		//bbsID가 특정 숫자일 경우에 실행
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, comment_num);
			rs = pstmt.executeQuery();
			if(rs.next()) {  //결과가 나왔다면
				Comment comment = new Comment();
				comment.setCOMMENT_NUM(rs.getInt(1));
				comment.setCOMMENT_bbsID(rs.getInt(2));
				comment.setCOMMENT_userID(rs.getString(3));
				comment.setCOMMENT_date(rs.getString(4));
				comment.setCOMMENT_comment(rs.getString(5));
				comment.setCOMMENT_Available(rs.getInt(6));
				comment.setCOMMENT_userNickname(rs.getString(7));
				return comment; //bbs에 있는 내용 그대로 반환 및 함수에 전달
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null; //글이 존재하지 않는 경우
	}
	
}