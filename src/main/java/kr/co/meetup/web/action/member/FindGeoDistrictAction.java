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
		// geoCity에 따른 geoDistrict 내용이 담긴 리스트 생성
		List<String> geoDistricts = dao.selectAllGeoDistrictByGeoCity(geoCity);
		
		// geoDistrict 내용이 담긴 리스트 geoDistricts 이름으로 전송
		req.setAttribute("geoDistricts", geoDistricts);
		return geoDistricts;
	}

}
