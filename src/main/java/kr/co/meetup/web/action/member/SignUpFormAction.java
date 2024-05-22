package kr.co.meetup.web.action.member;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.GeoVO;

public class SignUpFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		GeoDAO dao = new GeoDAO();
		List<GeoVO> list = dao.selectAllGeo();
		Set<String> uniqueGeoCities = new LinkedHashSet<>();
		Map<String, List<String>> cityDistrictMap = new HashMap<>();
		
		for (GeoVO vo : list) {
            uniqueGeoCities.add(vo.getGeoCity());
            cityDistrictMap.computeIfAbsent(vo.getGeoCity(), k -> new ArrayList<>()).add(vo.getGeoDistrict());
        }
		
		HttpSession session = req.getSession();
		session.setAttribute("list", list);
		session.setAttribute("geoCities", uniqueGeoCities);
		session.setAttribute("cityDistrictMap", cityDistrictMap);
		
		return "member/signup.jsp";
	}

}
