package kr.co.meetup.web.action.crew;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewLikeVO;
import kr.co.meetup.web.vo.MemberVO;

public class LikeAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 파라미터 가져오기
		String cn = req.getParameter("crewNo");
		String requestType = req.getParameter("requestType");
		
		// 형변환
		int crewNo = 0;
		if (cn != null) {
			crewNo = Integer.parseInt(cn);
		}
		
		// 현재 로그인한 유저 가져오기
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		
		// 데이터 삽입 || 삭제
		CrewDAO dao = new CrewDAO();
		CrewLikeVO vo = new CrewLikeVO();
		
		if (requestType.equals("add")) {
			vo.setCrewNo(crewNo);
			vo.setMemberNo(mvo.getMemberNo());
			dao.addCrewLike(vo);
		} else if (requestType.equals("delete")) {
			vo.setCrewNo(crewNo);
			vo.setMemberNo(mvo.getMemberNo());
			dao.deleteCrewLike(vo);
		}
		
		return "crew?cmd=detail&crewNo=" + crewNo;
	}

}
