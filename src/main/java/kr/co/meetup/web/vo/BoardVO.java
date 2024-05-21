package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVO {
	private int boardNo;
	private int crewNo;
	private int boardCategoryNo;
	private int memberNo;
	private String boardTitle;
	private String boardContent;
	private int boardHit;
	private int boardStatus;
	private Timestamp createdAt;
	private Timestamp updatedAt;
}