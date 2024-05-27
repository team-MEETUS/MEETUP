package kr.co.meetup.web.vo;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CrewMemberVO {
	private int crewMemberNo;
	private int crewNo;
	private int memberNo;
	private int crewMemberStatus;
	private Timestamp createdAt;
	
	// 조인으로 가져오는 필드
	private String memberNickname;
	private String memberSaveImg;
}
