package kr.co.meetup.web.action.member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.vo.MemberVO;

public class ConfirmPwFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String url = "";
		
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("loginMember");
		
		if (vo != null) {
			url = "member/confirmPw.jsp";
		} else {
			url = "member/login.jsp";
		}
		
		return url;
	}

}
