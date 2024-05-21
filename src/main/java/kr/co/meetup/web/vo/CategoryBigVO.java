package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategoryBigVO {
	private int categoryBigNo;
	private String categoryBigName;
	private String categoryBigIcon;
	private Timestamp createdAt;
}
