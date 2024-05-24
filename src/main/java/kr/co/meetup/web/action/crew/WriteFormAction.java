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
        
        // JSON 변환 
        Gson gson = new Gson();
        String categorySmallMapJson = gson.toJson(categorySmallMap);
        
        // 전체 지역 조회
        GeoDAO geoDao = new GeoDAO();
		List<String> geoList = geoDao.selectAllGeoCity();
        
		req.setAttribute("categoryBigList", categoryBigList);
		req.setAttribute("categorySmallList", categorySmallList);
		req.setAttribute("categorySmallMapJson", categorySmallMapJson);
		req.setAttribute("geoList", geoList);
		
		return "crew/writeForm.jsp";
	}
	
}
