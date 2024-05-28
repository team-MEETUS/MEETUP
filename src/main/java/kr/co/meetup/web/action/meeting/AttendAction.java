package kr.co.meetup.web.action.meeting;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.MeetingVO;
import kr.co.meetup.web.vo.MemberVO;

@SuppressWarnings("serial")
@WebServlet("/meetingAttend")
public class AttendAction extends HttpServlet {
	protected void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		
		String meetingNo = req.getParameter("meetingNo");
		int memberNo = loginMember.getMemberNo();
		String crewNo = req.getParameter("crewNo");
		
		System.out.println("meetingNo : " + meetingNo);
		System.out.println("memberNo : " + memberNo);
		System.out.println("crewNo : " + crewNo);
		
		MeetingDAO dao = new MeetingDAO();
		MeetingVO vo = dao.selectOneMeetingByMeetingNo(Integer.parseInt(meetingNo));
		// null값 체크
		if(meetingNo != null && memberNo + "" != null) {
			// 해당 유저가 이미 정모에 가입했는지 확인
			int cnt1 = dao.selectAllMeetingMemberCnt(Integer.parseInt(meetingNo), memberNo);
			// 정모에 가입한 유저 수 확인
			int cnt2 = dao.selectAllMeetingMemberByMeetingNoCnt(Integer.parseInt(meetingNo));
			if(cnt1 == 0) {
				System.out.println("vo.getMeetingMax() : " +vo.getMeetingMax());
				if(cnt2 < vo.getMeetingMax()) {
					dao.addMeetingMember(Integer.parseInt(meetingNo), memberNo);
				} else {
					System.out.println("해당 정모의 정원이 가득 찼습니다.");
					req.setAttribute("errorMsg", "해당 정모의 정원이 가득 찼습니다.");
				}
			} else {
				System.out.println("이미 해당 정모에 가입한 회원입니다!");
				req.setAttribute("errorMsg", "이미 해당 정모에 가입한 회원입니다!");
			}
		} else {
			System.out.println("meeingNo와 memberNo를 확인해주세요!");
		}
		
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