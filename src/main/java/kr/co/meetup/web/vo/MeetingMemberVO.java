package kr.co.meetup.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MeetingMemberVO {
	private int mmNo;
	private int meetingNo;
	private int memberNo;
}
