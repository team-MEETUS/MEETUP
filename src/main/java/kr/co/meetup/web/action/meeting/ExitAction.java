package kr.co.meetup.web.action.meeting;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.MemberVO;

@SuppressWarnings("serial")
@WebServlet("/meetingExit")
public class ExitAction extends HttpServlet {
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		
		String meetingNo = req.getParameter("meetingNo");
		int memberNo = loginMember.getMemberNo();
		String crewNo = req.getParameter("crewNo");
		
		MeetingDAO dao = new MeetingDAO();
		
		dao.deleteMeetingMember(Integer.parseInt(meetingNo), memberNo);
		
		resp.sendRedirect("crew?cmd=detail&crewNo=" + crewNo);
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