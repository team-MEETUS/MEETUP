package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface BoardAction {
	public String execute(HttpServletRequest req, HttpServletResponse resp);
}