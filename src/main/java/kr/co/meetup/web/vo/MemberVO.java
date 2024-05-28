package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
	private int memberNo;
	private int geoCode;
	private String memberPhone;
	private String memberPw;
	private String memberNickname;
	private String memberIntro;
	private String memberBirth;
	private String memberGender;
	private int memberStatus;
	private String memberOriginalImg;
	private String memberSaveImg;
	private Timestamp memberDeadDate;
	private Timestamp createdAt;
	private Timestamp updatedAt;
}
