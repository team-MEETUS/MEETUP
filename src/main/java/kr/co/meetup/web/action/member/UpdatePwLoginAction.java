package kr.co.meetup.web.action.member;

import common.AES128;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.MemberVO;

public class UpdatePwLoginAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 암호화 키
		String key = "1234567890123456";
		AES128 aes = new AES128(key);
		
		// 변경 할 비밀번호
		String memberPw = req.getParameter("memberPw");
		memberPw = aes.encrypt(memberPw);
		
		HttpSession session = req.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("MemberVO");
		vo.setMemberPw(memberPw);
		
		MemberDAO dao = new MemberDAO();
		dao.updateMemberPw(vo);
		
		return "member?cmd=login";
	}

}
