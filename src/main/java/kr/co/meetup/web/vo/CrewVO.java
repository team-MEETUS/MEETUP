package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CrewVO {
	private int crewNo;
	private int geoCode;
	private int categoryBigNo;
	private int categorySmallNo;
	private String crewName;
	private String crewContent;
	private int crewMax;
	private int crewStatus;
	private String crewOriginalImg;
	private String crewSaveImg;
	private String crewOriginalBanner;
	private String crewSaveBanner;
	private Timestamp crewDeadDate;
	private Timestamp createdAt;
	private Timestamp updatedAt;
}
