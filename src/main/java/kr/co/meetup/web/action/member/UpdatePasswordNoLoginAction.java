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
		String url = "";
		// 암호화 키
		String key = "1234567890123456";
		AES128 aes = new AES128(key);
		
		String memberPhone = req.getParameter("memberPhone");
		String memberPw = req.getParameter("memberPw");
		if (memberPhone != null && memberPw != null) {		
			// 페이지에서 받은 비밀번호 암호화
			memberPw = aes.encrypt(memberPw);
			
			MemberDAO dao = new MemberDAO();
			MemberVO vo = new MemberVO();
			vo.setMemberPhone(memberPhone);
			vo.setMemberPw(memberPw);
			
			dao.updateMemberPw(vo);
		}
		
		return "member?cmd=login";
	}

}
