package kr.co.meetup.web.action.crew;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import com.google.gson.Gson;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.GeoDAO;
import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CategorySmallVO;
import kr.co.meetup.web.vo.CrewVO;
import kr.co.meetup.web.vo.GeoVO;

public class UpdateFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// crewNo 파라미터 가져오기
		String cn = req.getParameter("crewNo");
		
		// 형변환
		int crewNo = 0;
		if (cn != null) {
			crewNo = Integer.parseInt(cn);
		}
		
		// 해당 모임 정보 가져오기
		CrewDAO dao = new CrewDAO();
		CrewVO vo = dao.selectOneCrew(crewNo);
		
		// 전체 카테고리 조회
		List<CategoryBigVO> categoryBigList = dao.selectAllCategoryBig();
		List<CategorySmallVO> categorySmallList = dao.selectAllCategorySmall();
		
		// 카테고리 별 세부 카테고리 그룹화
        Map<Integer, List<CategorySmallVO>> categorySmallMap = categorySmallList.stream()
                .collect(Collectors.groupingBy(CategorySmallVO::getCategoryBigNo));
        
        // JSON 변환 
        Gson gson = new Gson();
        String categorySmallMapJson = gson.toJson(categorySmallMap);
        
        // 전체 지역 조회
        GeoDAO geoDao = new GeoDAO();
		List<String> geoList = geoDao.selectAllGeoCity();
		
		// 모임의 지역 vo 가져오기
		GeoVO gvo = geoDao.selectOneGeoCityGeoDistrictByGeoCode(vo.getGeoCode());
        
		// attribute 에 넣기 
		req.setAttribute("crewVO", vo);
		req.setAttribute("categoryBigList", categoryBigList);
		req.setAttribute("categorySmallList", categorySmallList);
		req.setAttribute("categorySmallMapJson", categorySmallMapJson);
		req.setAttribute("GeoVO", gvo);
		
		req.setAttribute("geoList", geoList);
		
		return "crew/updateForm.jsp";
	}

}
