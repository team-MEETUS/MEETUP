package kr.co.meetup.web.action.meeting;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.MeetingVO;

public class WriteAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			
			String crewNo = (String) req.getAttribute("crewNo");
			String memberNo = (String) req.getAttribute("memberNo");
			String meetingName = (String) req.getAttribute("meetingName");
			String meetingDate = (String) req.getAttribute("meetingDate");
			String meetingLoc = (String) req.getAttribute("meetingLoc");
			String meetingPrice = (String) req.getAttribute("meetingPrice");
			String meetingMax = (String) req.getAttribute("meetingMax");
			// 이미지의 원본파일명, 저장파일명
			String meetingOriginalImg = (String) req.getAttribute("meetingImg");
			String meetingSaveImg = (String) req.getAttribute("meetingImg");
			
			MeetingDAO dao = new MeetingDAO();
			MeetingVO vo = new MeetingVO();
			
			// 직접 받아오면 수정
			vo.setCrewNo(Integer.parseInt(crewNo));
			vo.setMemberNo(Integer.parseInt(memberNo));
			vo.setMeetingName(meetingName);
			vo.setMeetingDate(Timestamp.valueOf(meetingDate));
			vo.setMeetingLoc(meetingLoc);
			vo.setMeetingPrice(Integer.parseInt(meetingPrice));
			vo.setMeetingMax(Integer.parseInt(meetingMax));
			vo.setMeetingOriginalImg(meetingOriginalImg);
			vo.setMeetingSaveImg(meetingSaveImg);
			
			dao.addMeeting(vo);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
			
		return "/meeting";
	}

}
