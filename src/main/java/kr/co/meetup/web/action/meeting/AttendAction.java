package kr.co.meetup.web.action.meeting;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.dao.MeetingDAO;

@SuppressWarnings("serial")
@WebServlet("/meetingAttend.do")
public class AttendAction extends HttpServlet {
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String meetingNo = req.getParameter("meetingNo");
		String memberNo = req.getParameter("memberNo");
		String crewNo = req.getParameter("crewNo");
		
		System.out.println("meetingNo : " + meetingNo);
		System.out.println("memberNo : " + memberNo);
		System.out.println("crewNo : " + crewNo);
		
		MeetingDAO dao = new MeetingDAO();
		
		if(meetingNo != null && memberNo != null) {
			dao.addMeetingMember(Integer.parseInt(meetingNo), Integer.parseInt(memberNo));
		} else {
			System.out.println("meeingNo와 memberNo를 확인해주세요!");
		}
		
		resp.sendRedirect("meeting?cmd=detail&crewNo=" + crewNo);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
}