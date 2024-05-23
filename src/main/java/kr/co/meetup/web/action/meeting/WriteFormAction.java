package kr.co.meetup.web.action.meeting;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;

public class WriteFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String crewNo = req.getParameter("crewNo");
		String memberNo = req.getParameter("memberNo");
		
		req.setAttribute("crewNo", crewNo);
		req.setAttribute("memberNo", memberNo);
		
		return "meeting/writeForm.jsp";
	}

}
