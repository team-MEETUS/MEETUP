package kr.co.meetup.web.action;

import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public interface ListAction {
	public List<String> execute(HttpServletRequest req, HttpServletResponse resp);
}
