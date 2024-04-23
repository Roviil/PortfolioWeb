package user;

//DAO는 데이터 접근 객체의 약자. 데이터베이스데이터베이스에 접근하는 코드.

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() { //데이터 접근 객체
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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";  
		//SQL 명령어 부분, ID가 존재하는지, 존재하면 비번이 뭔지 가져오는거
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);//SQL 인젝션같은 해킹기법 방어
			rs = pstmt.executeQuery();
			if(rs.next()) { //결과가 존재 한다면 실행
				if(rs.getString(1).equals(userPassword)) { //로그인 시도한 비번이랑 데이터베이스 비번이 같으면
					return 1; //로긴성공!
				}
				else {
					return 0; //로긴실패!
				}
			}
			return -1; //아이디 없으면
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?, 2, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getUserNickname());

			return pstmt.executeUpdate(); //결과를 집어넣는거??
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		
		return -1; //DB오류. INSERT문이 실행되면 반드시 0 넘는 숫자가 반환됨
	}
	
	public int serach(String userID) {
		String SQL = "SELECT userGrage from USER where userID = ?";
		//SQL 명령어 부분, ID의 Grage를 가져옴 
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);//SQL 인젝션같은 해킹기법 방어
			rs = pstmt.executeQuery();
			if(rs.next()) { //결과가 존재 한다면 실행
				if(rs.getString(1).equals("1")) { //유저 그레이드가 일치한다
					return 1; //어드민 로그
				}
				else if(rs.getString(1).equals("2")){
					return 2; //일반 회원 로그
				}
			}
			return -1; //아이디 없으면
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;
	}
	public String nameserach(String userID) {//아이디 기반 닉네임 찾는 코드 
		String SQL = "SELECT userNickname from USER where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);//SQL 인젝션같은 해킹기법 방어
			rs = pstmt.executeQuery();
			if(rs.next()) { //결과가 존재 한다면 실행
				String name = rs.getString(1);
					return name;
			}
			return ""; //아이디 없으면
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	public int name(String name) {//닉네임 중복 체크 
		String SQL = "SELECT userNickname from USER where userNickname = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, name);//SQL 인젝션같은 해킹기법 방어
			rs = pstmt.executeQuery();

			if(rs.next()) { //결과가 존재 한다면 실행
				if(rs.getString(1).equals(name)) {
					return -1;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return 1;
	}
	
	public User getUserdata(String userID) {
		String SQL = "SELECT * FROM USER where userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL); 
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				User user = new User();
				user.setUserID(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserName(rs.getString(3));
				user.setUserGender(rs.getString(4));
				user.setUserEmail(rs.getString(5));
				user.setUserGrade(rs.getInt(6));
				user.setUserNickname(rs.getString(7));
				return user;
			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public int updateUserdata(String userID, String userPassword, String userName, String userGender, String userEmail, String userNickname) {
		String SQL = "UPDATE USER SET userPassword = ?, userName = ?, userGender = ?, userEmail = ?, userNickname = ? WHERE userID =?"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userName);
			pstmt.setString(3, userGender);
			pstmt.setString(4, userEmail);
			pstmt.setString(5, userNickname);
			pstmt.setString(6, userID);
			
			//2.3배정훈 추가 닉네임 수정 사항 없으면 그냥 넘어가고 있으면 닉네임 중복되는지 확인 후 수정 
			String pname = nameserach(userID);
			int name = name(userNickname);
			if(pname.equals(userNickname)) {
				return pstmt.executeUpdate();
			}
			else {
				if(name != -1) {
					return pstmt.executeUpdate();
				}
				else {
					return -2; //닉네임이 중복되는 경우
				}
			}			
			
		}
		catch (Exception e){
			e.printStackTrace();
		}
		
		return -1; //데이터베이스 오류
	}
	
}