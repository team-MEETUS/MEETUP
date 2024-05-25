package kr.co.meetup.web.action.member;

import common.AES128;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.MemberVO;

public class UpdatePasswordNoLoginAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String key = "1234567890123456";
		AES128 aes = new AES128(key);
		
		String memberPhone = req.getParameter("memberPhone");
		String memberPw = req.getParameter("memberPw");
		memberPw = aes.encrypt(memberPw);
		
		MemberDAO dao = new MemberDAO();
		MemberVO vo = new MemberVO();
		vo.setMemberPhone(memberPhone);
		vo.setMemberPw(memberPw);
		
		dao.updateMemberPw(vo);
		
		return "member?cmd=login";
	}

}
