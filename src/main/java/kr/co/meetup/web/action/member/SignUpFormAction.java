package kr.co.meetup.web.action.member;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.GeoDAO;

public class SignUpFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		GeoDAO dao = new GeoDAO();
		List<String> geoCities = dao.selectAllGeoCity();
		
		req.setAttribute("geoCities", geoCities);
		
		return "member/signup.jsp";
	}

}
