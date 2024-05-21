package kr.co.meetup.web.action.crew;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CategoryBigVO;
import kr.co.meetup.web.vo.CategorySmallVO;

public class WriteFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		
		CrewDAO dao = new CrewDAO();

		List<CategoryBigVO> categoryBigList = dao.selectAllCategoryBig();
		List<CategorySmallVO> categorySmallList = dao.selectAllCategorySmall();

		System.out.println(categoryBigList.toString());
		System.out.println(categorySmallList.toString());
		
		req.setAttribute("categoryBigList", categoryBigList);
		req.setAttribute("categorySmallList", categorySmallList);
		
		return "crew/writeForm.jsp";
	}
	
}
