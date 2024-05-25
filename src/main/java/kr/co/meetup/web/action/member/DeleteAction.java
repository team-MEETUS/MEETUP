package kr.co.meetup.web.action.member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MemberDAO;

public class DeleteAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String no = req.getParameter("memberNo");
		
		if(no != null) {
			int memberNo = Integer.parseInt(no);
			
			MemberDAO dao = new MemberDAO();
			dao.deleteOneMemberByMemberNo(memberNo);
		}
		return "index.jsp";
	}

}
