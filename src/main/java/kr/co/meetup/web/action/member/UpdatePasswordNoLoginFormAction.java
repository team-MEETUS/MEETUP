package kr.co.meetup.web.action.member;

import common.AES128;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;

public class UpdatePasswordNoLoginFormAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 암호화 키
		String key = "1234567890123456";
		AES128 aes = new AES128(key);
		
		String memberPhone = req.getParameter("memberPhone");
		memberPhone = aes.encrypt(memberPhone);
		req.setAttribute("memberPhone", memberPhone);
		
		
		return "member/updatePasswordNoLogin.jsp";
	}

}
