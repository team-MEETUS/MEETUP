package kr.co.meetup.web.action.crew;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewMemberVO;
import kr.co.meetup.web.vo.MemberVO;

public class ManagementListAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// crewNo 파라미터 가져오기
		String crewNo = req.getParameter("crewNo");
		
		// 해당 모임회원 가져오기
		CrewDAO dao = new CrewDAO();
		List<CrewMemberVO> cmvo = null;
		if (crewNo != null) {
			cmvo = dao.selectAllCrewMember(Integer.parseInt(crewNo));
		}
		
		// 현재 로그인한 유저 정보 가져오기
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		
		System.out.println(cmvo.toString());
		
		// 유저의 역할 확인
		String role = "guest";
		if (mvo != null) {
			for (CrewMemberVO vo : cmvo) {
				if (vo.getMemberNo() == mvo.getMemberNo()) {
					if (vo.getCrewMemberStatus() == 1) role = "crewMember";			// 일반회원
					else if (vo.getCrewMemberStatus() == 2) role = "adminMember";	// 운영진
					else if (vo.getCrewMemberStatus() == 3) role = "leader";			// 모임장
					else if (vo.getCrewMemberStatus() == 4) role = "pendingMember";	// 승인대기
					else if (vo.getCrewMemberStatus() == 5) role = "rejectedMember";// 승인거절
					else role = "kick";	// 강퇴
					break;
				} else {
					role = "member";
				}
			}
		}
		
		// attribute 에 추가
		req.setAttribute("crewNo", crewNo);
		req.setAttribute("crewMemberList", cmvo);
		
		
		return "crew/management.jsp";
	}
	
}
