package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CategorySmallVO {
	private int categorySmallNo;
	private int categoryBigNo;
	private String categorySmallName;
	private Timestamp createdAt;
}
