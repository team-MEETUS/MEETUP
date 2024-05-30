package kr.co.meetup.web.action;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.GeoVO;
import kr.co.meetup.web.vo.MemberVO;

public class MainAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		GeoVO gvo = (GeoVO) session.getAttribute("loginMemberGeo");
		List<CrewVO> loginMemberCrewList = (List<CrewVO>) session.getAttribute("loginMemberCrewList");
		
		if (vo != null && gvo != null && loginMemberCrewList != null) {
//			session.setAttribute("loginMember", vo);
			session.setAttribute("loginMemberGeo", gvo);
			session.setAttribute("loginMemberCrewList", loginMemberCrewList);
		}
		
		return "index.jsp";
	}

}
