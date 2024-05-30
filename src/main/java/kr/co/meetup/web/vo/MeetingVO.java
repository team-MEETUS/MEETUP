package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MeetingVO {
	private int meetingNo;
	private int crewNo;
	private int memberNo;
	private String meetingName;
	private Timestamp meetingDate;
	private String meetingLoc;
	private int meetingPrice;
	private int meetingMax;
	private int meetingAttend;
	private int meetingstatus;
	private String meetingOriginalImg;
	private String meetingSaveImg;
	private Timestamp createdAt;
	
	private String geoCity;
	private String geoDistrict;
	private String categoryBigName;
	private String categorySmallName;
	private String crewName;
}
