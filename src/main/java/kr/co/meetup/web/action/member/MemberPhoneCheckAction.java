package kr.co.meetup.web.action.member;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MemberDAO;

public class MemberPhoneCheckAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
			String memberPhone = req.getParameter("memberPhone");
			MemberDAO dao = new MemberDAO();
			String phoneCheckResult = dao.selectMemberNoByPhone(memberPhone).toString();
			
			req.setAttribute("phoneCheckResult", phoneCheckResult);
			return phoneCheckResult;
	}

}
