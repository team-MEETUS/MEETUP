package kr.co.meetup.web.action.crew;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewMemberVO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.MemberVO;

public class DetailAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		
		// crewNo 파라미터 가져오기
		String crewNo = req.getParameter("crewNo");
		
		// 해당 crew 정보, 가입멤버 가져오기
		CrewDAO dao = new CrewDAO();
		CrewVO cvo = dao.selectOneCrew(Integer.parseInt(crewNo));
		List<CrewMemberVO> cmvo = dao.selectAllCrewMember(Integer.parseInt(crewNo));
		
		// crewContent 줄바꿈 포맷
		String formattedContent = cvo.getCrewContent().replace("\n", "<br/>");
		
		// 현재 로그인한 유저 가져오기
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		
		// 유저의 역할 확인
		String role = "guest";
		if (mvo != null) {
			for (CrewMemberVO vo : cmvo) {
				if (vo.getMemberNo() == mvo.getMemberNo()) {
					if (vo.getCrewMemberStatus() == 1) role = "crewMember";		// 일반회원
					else if (vo.getCrewMemberStatus() == 2) role = "leader";		// 모임장
					else if (vo.getCrewMemberStatus() == 3) role = "admin";		// 운영진
					else if (vo.getCrewMemberStatus() == 4) role = "pendingMember";	// 승인대기
					else role = "kick";	// 강퇴
				} else {
					role = "member";
				}
			}
		}
		
		System.out.println("role : " + role);
		
		// attribute 에 추가
		req.setAttribute("crewVO", cvo);
		req.setAttribute("crewMemberList", cmvo);
		req.setAttribute("formattedContent", formattedContent);
		req.setAttribute("role", role);
		
		return "crew/detail.jsp";
	}

}
