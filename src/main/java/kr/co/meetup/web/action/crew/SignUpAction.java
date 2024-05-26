package kr.co.meetup.web.action.crew;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewMemberVO;
import kr.co.meetup.web.vo.MemberVO;

public class SignUpAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 모임번호 가져오기
		String cn = req.getParameter("crewNo");
		
		// 현재 로그인한 유저 가져오기
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		
		if (cn != null) {
			int crewNo = Integer.parseInt(cn);
			// 모임에 가입 신청
			CrewDAO dao = new CrewDAO();
			CrewMemberVO vo = new CrewMemberVO();
			vo.setCrewNo(crewNo);
			vo.setMemberNo(mvo.getMemberNo());
			dao.addCrewMember(vo);
		}
		
		
		return "crew?cmd=detail&crewNo=" + cn;
	}

}
