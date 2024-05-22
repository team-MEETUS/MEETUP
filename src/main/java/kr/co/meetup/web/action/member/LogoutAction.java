package kr.co.meetup.web.action.member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;

public class LogoutAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		session.invalidate();
		return "index.jsp";
	}

}
