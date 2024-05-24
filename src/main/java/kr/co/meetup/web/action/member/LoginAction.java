package kr.co.meetup.web.action.member;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.MemberVO;

public class LoginAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		// 로그인 성공/실패에 따라 달라지는 변수
		String url = "";
		
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			
			
			String memberPhone = req.getParameter("memberPhone");
			String memberPw = req.getParameter("memberPw");
			
			MemberDAO dao = new MemberDAO();		
			MemberVO vo = dao.selectOneMemberByPhone(memberPhone, memberPw);
			
			
			if(vo != null) {
				int memberStatus = vo.getMemberStatus();
				
				if (memberStatus == 1) {
					HttpSession session = req.getSession();
					session.setAttribute("MemberVO", vo);
					
					url = "index.jsp";
				} else if (memberStatus == 0) {
					req.setAttribute("memberNotice", "deleteMember");
					
					url = "member/login.jsp";
				} else if (memberStatus == 2) {
					req.setAttribute("memberNotice", "warningMember");
					
					url = "member/login.jsp";
				}
				
			} else {
				url = "member/login.jsp";
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return url;
		
	}

}
