package kr.co.meetup.web.action.member;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.ListAction;
import kr.co.meetup.web.dao.GeoDAO;

public class FindGeoDistrictAction implements ListAction {

	@Override
	public List<String> execute(HttpServletRequest req, HttpServletResponse resp) {
		String geoCity = req.getParameter("geoCity");
		GeoDAO dao = new GeoDAO();
		List<String> geoDistricts = dao.selectAllGeoDistrictByGeoCity(geoCity);
		
		for(String str : geoDistricts) {
			System.out.println(str);
		}
		
		req.setAttribute("geoDistricts", geoDistricts);
		return geoDistricts;
	}

}
