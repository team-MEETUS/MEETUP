package kr.co.meetup.web.action.crew;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewVO;

public class ListAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		
		CrewDAO dao = new CrewDAO();
		
		List<CrewVO> crewList = dao.selectAll();
		
		System.out.println(crewList.toString());
		
		req.setAttribute("crewList", crewList);
		
		return "crew/list.jsp";
	}
	
}
