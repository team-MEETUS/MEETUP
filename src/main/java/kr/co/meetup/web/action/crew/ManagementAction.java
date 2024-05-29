package kr.co.meetup.web.action.crew;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.MeetingDAO;
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
		MeetingDAO mdao = new MeetingDAO();
		CrewMemberVO vo = new CrewMemberVO();
		
		// 가입 승인
		if (requestType.equals("approval")) {
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(1);
			dao.updateCrewMember(vo);
			dao.updateCrewAttend(crewNo, 1); // 모임 인원수 1 증가
		} // 가입 거절
		else if (requestType.equals("reject")) {
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(5);
			dao.updateCrewMember(vo);
		} // 운영진 임명 
		else if (requestType.equals("appoint")) {
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(2);
			dao.updateCrewMember(vo);
		} // 운영진 해제
		else if (requestType.equals("demote")) {
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(1);
			dao.updateCrewMember(vo);
		} // 모임장 양도
		else if (requestType.equals("transfer")) {
			dao.updateCrewMemberLeader(crewNo);	// 기존 모임장 -> 운영진
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(3);
			dao.updateCrewMember(vo);
		} // 강퇴 
		else if (requestType.equals("kick")) {
			vo.setCrewNo(crewNo);
			vo.setMemberNo(memberNo);
			vo.setCrewMemberStatus(0);
			dao.updateCrewMember(vo);
			mdao.deleteMeetingMemberByCrewNoMemberNo(crewNo, memberNo);
			dao.updateCrewAttend(crewNo, -1); // 모임 인원수 1 감소
		} // 퇴장 
		else if (requestType.equals("leave")) {
			// crew_member 삭제
			dao.deleteCrewMember(crewNo, memberNo);
			// meeting_member 삭제
			mdao.deleteMeetingMemberByCrewNoMemberNo(crewNo, memberNo);
			dao.updateCrewAttend(crewNo, -1); // 모임 인원수 1 감소
			return "crew?cmd=detail&crewNo=" + crewNo;
		}
		
		return "crew?cmd=mnglist&crewNo=" + crewNo;
	}

}
