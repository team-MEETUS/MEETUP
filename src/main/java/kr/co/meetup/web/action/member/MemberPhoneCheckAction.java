package kr.co.meetup.web.action.member;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MemberDAO;

public class MemberPhoneCheckAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
			// 페이지에서 입력된 핸드폰 번호
			String memberPhone = req.getParameter("memberPhone");
			
			// 번호가 존재하는지에 따라 달리지는 result 값
			MemberDAO dao = new MemberDAO();
			String phoneCheckResult = dao.selectMemberNoByPhone(memberPhone).toString();
			
			req.setAttribute("phoneCheckResult", phoneCheckResult);
			req.setAttribute("memberPhone", memberPhone);
			return phoneCheckResult;
	}

}
