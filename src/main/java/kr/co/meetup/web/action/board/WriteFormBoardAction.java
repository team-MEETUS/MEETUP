package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;

public class WriteFormBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) { 
		String crewNo = req.getParameter("crewNo");
		String memberNo = req.getParameter("memberNo");
		
		req.setAttribute("crewNo", crewNo);
		req.setAttribute("memberNo", memberNo);
		
		return "board/writeFormBoard.jsp";
	}

}

