package kr.co.meetup.web.action;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.GeoVO;
import kr.co.meetup.web.vo.MeetingVO;
import kr.co.meetup.web.vo.MemberVO;

public class MainAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		CrewDAO cdao = new CrewDAO();
		MeetingDAO mdao = new MeetingDAO();
		
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		GeoVO gvo = (GeoVO) session.getAttribute("loginMemberGeo");
		List<CrewVO> loginMemberCrewList = (List<CrewVO>) session.getAttribute("loginMemberCrewList");
		List<CrewVO> loginPopularCrewList = (List<CrewVO>) session.getAttribute("loginPopularCrewList");
		List<MeetingVO> loginComingMeetingList = (List<MeetingVO>) session.getAttribute("loginComingMeetingList");
		
		if (vo != null && gvo != null && loginMemberCrewList != null && loginPopularCrewList != null && loginComingMeetingList != null) {
			session.setAttribute("loginMember", vo);
			session.setAttribute("loginMemberGeo", gvo);
			
			loginMemberCrewList = cdao.selectAllCrewByMember(vo.getMemberNo());
			loginPopularCrewList = cdao.selectAllCrewOrderMemberByGeo(vo.getGeoCode(), 0, 5);
			loginComingMeetingList = mdao.selectAllMeetingByGeoCodeOrderMeetingDate(vo.getGeoCode());
			
			session.setAttribute("loginMemberCrewList", loginMemberCrewList);
			session.setAttribute("loginPopularCrewList", loginPopularCrewList);
			session.setAttribute("loginComingMeetingList", loginComingMeetingList);
		}
		
		List<CrewVO> noLoginPopularCrewList = cdao.selectAllCrewOrderMember(0, 5);
		List<MeetingVO> noLoginComingMeetinList = mdao.selectAllMeetingOrderMeetingDate();
		
		session.setAttribute("noLoginPopularCrewList", noLoginPopularCrewList);
		session.setAttribute("noLoginComingMeetinList", noLoginComingMeetinList);
		
		return "index.jsp";
	}

}
