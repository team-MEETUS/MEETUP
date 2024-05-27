package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardCommentVO {
	private int boardCommentNo;
	private int boardNo;
	private int memberNo;
	private String memberNickname;
	private int boardCommentPno;
	private String boardCommentContent;
	private int boardCommentStatus;
	private Timestamp createdAt;
}