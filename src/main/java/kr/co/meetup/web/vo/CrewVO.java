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
	private int memberNo;
	private String crewName;
	private String crewIntro;
	private String crewContent;
	private int crewMax;
	private int crewAttend;
	private int crewStatus;
	private String crewOriginalImg;
	private String crewSaveImg;
	private String crewOriginalBanner;
	private String crewSaveBanner;
	private Timestamp crewDeadDate;
	private Timestamp createdAt;
	private Timestamp updatedAt;
	
	// 조인으로 가져오는 필드
	private String categoryBigName;
	private String categorySmallName;
	private String geoCity;
	private String geoDistrict;
}
