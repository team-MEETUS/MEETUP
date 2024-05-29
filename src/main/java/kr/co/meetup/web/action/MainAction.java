package kr.co.meetup.web.action;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MainAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		return "index.jsp";
	}

}
