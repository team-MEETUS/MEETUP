package kr.co.meetup.web.action.member;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.GeoVO;
import kr.co.meetup.web.vo.MemberVO;

public class MyMenuAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String url = "";
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		
		// 로그인이 되어있는 상태라면 마이페이지
		if(vo != null) {
			GeoDAO gdao = new GeoDAO();
			GeoVO gvo = gdao.selectOneGeoCityGeoDistrictByGeoCode(vo.getGeoCode());
			
			CrewDAO cdao = new CrewDAO();
			List<CrewVO> loginMemberCrewList = cdao.selectAllCrewByMember(vo.getMemberNo());
			List<CrewVO> loginMemberLikeCrewList = cdao.selectAllCrewLikeByMember(vo.getMemberNo());
			
			url = "member/myMenu.jsp";
			req.setAttribute("GeoVO", gvo);
			req.setAttribute("loginMemberCrewList", loginMemberCrewList);
			req.setAttribute("loginMemberLikeCrewList", loginMemberLikeCrewList);
		} 
		// 그렇지 않다면 로그인 페이지
		else {
			url = "member?cmd=login";
		}
		
		return url;
	}

}
