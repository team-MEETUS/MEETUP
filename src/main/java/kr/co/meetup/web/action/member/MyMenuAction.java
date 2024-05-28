package kr.co.meetup.web.action.member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.GeoVO;
import kr.co.meetup.web.vo.MemberVO;

public class MyMenuAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String url = "";
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		GeoDAO gdao = new GeoDAO();
		GeoVO gvo = gdao.selectOneGeoCityGeoDistrictByGeoCode(vo.getGeoCode());
		
		// 로그인이 되어있는 상태라면 마이페이지
		if(vo != null) {
			url = "member/myMenu.jsp";
			req.setAttribute("GeoVO", gvo);
		} 
		// 그렇지 않다면 로그인 페이지
		else {
			url = "member?cmd=login";
		}
		
		return url;
	}

}
