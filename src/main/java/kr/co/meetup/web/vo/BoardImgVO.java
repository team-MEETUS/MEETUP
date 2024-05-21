package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardImgVO {
	private int boardImgNo;
	private int boardNo;
	private String boardImgOriginalImg;
	private String boardImgSaveImg;
	
}