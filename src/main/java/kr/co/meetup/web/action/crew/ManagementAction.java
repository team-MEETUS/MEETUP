package kr.co.meetup.web.action.crew;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewMemberVO;

public class ManagementAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 요청 타입 가져오기
		String requestType = req.getParameter("requestType");
		
		// 모임&회원 번호 파라미터 가져오기
		String cn = req.getParameter("crewNo");
		String mn = req.getParameter("memberNo");
		
		// 형변환
		int crewNo = 0;
		int memberNo = 0;
		if (cn != null && mn != null) {
			crewNo = Integer.parseInt(cn);
			memberNo = Integer.parseInt(mn);
		}
		
		// DAO , VO 객체 생성
		CrewDAO dao = new CrewDAO();
		CrewMemberVO vo = new CrewMemberVO();
		
		// 요청 승인
		if (requestType.equals("approval")) {
			System.out.println("요청 승인!!");
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(1);
			dao.updateCrewMember(vo);
			// 모임 인원수 1 증가
			dao.updateCrewAttend(crewNo, 1);
		} 
		// 요청 거절
		else if (requestType.equals("reject")) {
			System.out.println("요청 거절!!");
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(5);
			dao.updateCrewMember(vo);
		}
		
		return "crew?cmd=mnglist&crewNo=" + crewNo;
	}

}
