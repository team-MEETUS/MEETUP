package kr.co.meetup.web.action.crew;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CrewVO;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		
		CrewDAO dao = new CrewDAO();
		
		// 전체 카테고리 리스트 가져오기
		List<CategoryBigVO> categoryBigList = dao.selectAllCategoryBig();
		
		// ctg 값 가져오기
		String ctg = req.getParameter("ctg");
		
		// ctg 값이 있으면 해당 카테고리의 모임만 가져오기
		List<CrewVO> crewList;
		if (ctg != null) {
			crewList = dao.selectCrewByCategory(Integer.parseInt(ctg));
		} else {
			// 전체 모임 리스트 가져오기
			crewList = dao.selectAll();
		}
		
		// attribute 에 추가
		req.setAttribute("crewList", crewList);
		req.setAttribute("categoryBigList", categoryBigList);
		
		return "crew/list.jsp";
	}
	
}
