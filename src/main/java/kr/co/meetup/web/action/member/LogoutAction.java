package kr.co.meetup.web.action.member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;

public class LogoutAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		HttpSession session = req.getSession();
		// 세션에 담긴 회원 MemberVO 정보 삭제
		session.invalidate();
		// 메인페이지로 보냄
		return "main?cmd=null";
	}

}
