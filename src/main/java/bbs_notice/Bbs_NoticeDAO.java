package bbs_notice;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class Bbs_NoticeDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public Bbs_NoticeDAO() { //데이터 접근 객체
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
	
	public String getDate() { //현재 시간 가져오기
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
	
	public int getNext() { //글 번호 부여하기
		String SQL = "SELECT notice_bbsID FROM BBS_NOTICE ORDER BY notice_bbsID DESC"; //글 번호 부여를 위해 맨 마지막에 쓰인 아이디 가져오기
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) { 
				return rs.getInt(1)+1; //위에서 가져온거에서 1 더해서 글번호 숫자 하나 늘려줌
			}
			return 1;  //첫 번째 게시물인 경우
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int write(String notice_bbsTitle, String notice_userID, String notice_bbsContent, String notice_userNickname) {
		String SQL = "INSERT INTO BBS_NOTICE VALUES(?, ?, ?, ?, ?, ?, ?)"; //bbs테이블 안에 6개 인자 집어넣기
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); //위에 ?라고 써뒀던 테이블에 넣을 애들
			pstmt.setString(2, notice_bbsTitle);
			pstmt.setString(3, notice_userID);	
			pstmt.setString(4, getDate());
			pstmt.setString(5, notice_bbsContent);
			pstmt.setInt(6, 1); //available이라 1 넣음..
			pstmt.setString(7, notice_userNickname);
			return pstmt.executeUpdate(); //성공적일시 상수 반환
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public ArrayList<Bbs_Notice> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS_NOTICE WHERE notice_bbsID < ? AND notice_bbsAvailable = 1 ORDER BY notice_bbsID DESC LIMIT 10"; 
		//bbsID가 특정 숫자보다 작을때, 그리고 글이 삭제가 되지 않았을 때. 글을 10개까지만 가져온다.
		ArrayList<Bbs_Notice> list = new ArrayList<Bbs_Notice>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) { 
				Bbs_Notice bbs_notice = new Bbs_Notice();
				bbs_notice.setNotice_bbsID(rs.getInt(1)); //bbs에 있는 첫번째 속성. 즉, ID 가져오는거
				bbs_notice.setNotice_bbsTitle(rs.getString(2));
				bbs_notice.setNotice_userID(rs.getString(3));
				bbs_notice.setNotice_bbsDate(rs.getString(4));
				bbs_notice.setNotice_bbsContent(rs.getString(5));
				bbs_notice.setNotice_bbsAvailable(rs.getInt(6));
				bbs_notice.setNotice_userNickname(rs.getString(7));
				list.add(bbs_notice); //게시글 목록을 담아서 리스트에 인스턴스 담아서 반환
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return list; //게시글 리스트 반환
	}
	
	public boolean nextPage(int pageNumber) { //페이징 처리. pageNumber가 맨첨에는 bbs.jsp에서 초기값 1로 넘어옴
		String SQL = "SELECT * FROM BBS_NOTICE WHERE notice_bbsID < ? AND notice_bbsAvailable = 1"; 
		//bbsID가 특정 숫자보다 작을때, 그리고 글이 삭제가 되지 않았을 때.
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				return true; //다음 페이지로 넘어갈 수 있음
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return false; //다음 페이지로 넘어갈 수 없음
	}
	
	public int Paging() {
		String SQL = "SELECT COUNT(*) FROM BBS_NOTICE WHERE notice_bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) { 
				int result = rs.getInt(1);
				return result;
			}
			return 1;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //DB 오류
	}
	
	public Bbs_Notice getBbs_Notice(int notice_bbsID) {
		String SQL = "SELECT * FROM BBS_NOTICE WHERE notice_bbsID = ?"; 
		//bbsID가 특정 숫자일 경우에 실행
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, notice_bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {  //결과가 나왔다면
				Bbs_Notice bbs_notice = new Bbs_Notice();
				bbs_notice.setNotice_bbsID(rs.getInt(1));
				bbs_notice.setNotice_bbsTitle(rs.getString(2));
				bbs_notice.setNotice_userID(rs.getString(3));
				bbs_notice.setNotice_bbsDate(rs.getString(4));
				bbs_notice.setNotice_bbsContent(rs.getString(5));
				bbs_notice.setNotice_bbsAvailable(rs.getInt(6));
				bbs_notice.setNotice_userNickname(rs.getString(7));
				return bbs_notice; //bbs에 있는 내용 그대로 반환 및 함수에 전달
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null; //글이 존재하지 않는 경우
	}
	
	public int update(int notice_bbsID, String notice_bbsTitle, String notice_bbsContent) { //새로 들어온 내용, 제목으로 업뎃하겠다.
		//특정한ID에 해당하는 제목과 내용을 바꾸겠다.
		String SQL = "UPDATE BBS_NOTICE SET notice_bbsTitle = ?, notice_bbsContent = ? WHERE notice_bbsID =?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, notice_bbsTitle);
			pstmt.setString(2, notice_bbsContent);
			pstmt.setInt(3, notice_bbsID);
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	public int delete(int notice_bbsID) {
		//글을 삭제하더라도 혹시 모르니까 데이터는 보관해두게 available만 0으로 바꿈
		String SQL = "UPDATE BBS_NOTICE SET notice_bbsAvailable = 0 WHERE notice_bbsID = ?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, notice_bbsID); //ID를 저 물음표에 넣어서 ID값의 글을 삭제
			return pstmt.executeUpdate();
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}

}
