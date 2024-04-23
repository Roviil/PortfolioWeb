package COMMENT_QNA;

public class Comment_QnA {
	private int COMMENT_NUM; //댓글번호
	private int COMMENT_bbsID; //글번호
	private String COMMENT_userID; //유저아이디
	private String COMMENT_date; //날짜
	private String COMMENT_comment; //댓글내용
	private int COMMENT_Available; //댓삭여부
	public int getCOMMENT_NUM() {
		return COMMENT_NUM;
	}
	public void setCOMMENT_NUM(int cOMMENT_NUM) {
		COMMENT_NUM = cOMMENT_NUM;
	}
	public int getCOMMENT_bbsID() {
		return COMMENT_bbsID;
	}
	public void setCOMMENT_bbsID(int cOMMENT_bbsID) {
		COMMENT_bbsID = cOMMENT_bbsID;
	}
	public String getCOMMENT_userID() {
		return COMMENT_userID;
	}
	public void setCOMMENT_userID(String cOMMENT_userID) {
		COMMENT_userID = cOMMENT_userID;
	}
	public String getCOMMENT_date() {
		return COMMENT_date;
	}
	public void setCOMMENT_date(String cOMMENT_date) {
		COMMENT_date = cOMMENT_date;
	}
	public String getCOMMENT_comment() {
		return COMMENT_comment;
	}
	public void setCOMMENT_comment(String cOMMENT_comment) {
		COMMENT_comment = cOMMENT_comment;
	}
	public int getCOMMENT_Available() {
		return COMMENT_Available;
	}
	public void setCOMMENT_Available(int cOMMENT_Available) {
		COMMENT_Available = cOMMENT_Available;
	}
}