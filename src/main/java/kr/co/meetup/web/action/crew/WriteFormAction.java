package kr.co.meetup.web.action.crew;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CategorySmallVO;
import kr.co.meetup.web.vo.GeoVO;

public class WriteFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		
		CrewDAO dao = new CrewDAO();

		// 전체 카테고리 조회
		List<CategoryBigVO> categoryBigList = dao.selectAllCategoryBig();
		List<CategorySmallVO> categorySmallList = dao.selectAllCategorySmall();
		
		// 카테고리 별 세부 카테고리 그룹화
        Map<Integer, List<CategorySmallVO>> categorySmallMap = categorySmallList.stream()
                .collect(Collectors.groupingBy(CategorySmallVO::getCategoryBigNo));
		
        // 전체 지역 조회
        List<GeoVO> geoList = dao.selectAllGeo();
        
        // 시도 별 구군 그룹화
        Map<String, List<GeoVO>> geoMap = geoList.stream()
                .collect(Collectors.groupingBy(GeoVO::getGeoCity));
        
		req.setAttribute("categoryBigList", categoryBigList);
		req.setAttribute("categorySmallMap", categorySmallMap);
		req.setAttribute("geoList", geoList);
		req.setAttribute("geoMap", geoMap);
		
		
		return "crew/writeForm.jsp";
	}
	
}
