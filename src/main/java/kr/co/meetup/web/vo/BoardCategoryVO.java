package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardCategoryVO {
	private int boardCategoryNo;
	private String boardCategoryName;
	private Timestamp createdAt;
}