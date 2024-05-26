package kr.co.meetup.web.action.member;

import common.AES128;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.vo.MemberVO;

public class ConfirmPwAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String url = "";
		// 암호화 키
		String key = "1234567890123456";
		AES128 aes = new AES128(key);
		
		// 비교용 비밀번호
		String confirmPw = req.getParameter("memberPw");
		// 비교용 비밀번호 암호화
		confirmPw = aes.encrypt(confirmPw);
				
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("MemberVO");
		
		if (confirmPw.equals(vo.getMemberPw())) {
			url = "member?cmd=updatePwLogin";
		} else {
			url = "member?cmd=confirmPw";
		}
		
		return url;
	}

}
