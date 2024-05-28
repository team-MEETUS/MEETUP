package kr.co.meetup.web.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CrewLikeVO {
	private int crewLikeNo;
	private int crewNo;
	private int memberNo;
}
