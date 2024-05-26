package kr.co.meetup.web.action.member;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.GeoVO;
import kr.co.meetup.web.vo.MemberVO;

public class UpdateFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		if(mvo != null) {
			GeoDAO dao = new GeoDAO();
			GeoVO gvo = dao.selectOneGeoCityGeoDistrictByGeoCode(mvo.getGeoCode());
			List<String> geoCities = dao.selectAllGeoCity();
			
			req.setAttribute("GeoVO", gvo);
			req.setAttribute("geoCities", geoCities);
		}
		return "member/myPage.jsp";
	}

}
