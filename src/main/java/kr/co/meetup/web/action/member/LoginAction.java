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
			
			// 가압된 정보가 있는 회원이라면
			if(vo != null) {
				int memberStatus = vo.getMemberStatus();
				
				// memberStatus가 정상이라면
				if (memberStatus == 1) {
					// 로그인 성공
					HttpSession session = req.getSession();
					session.setAttribute("MemberVO", vo);
					
					url = "index.jsp";
				} 
				// 탈퇴 처리된 회원이라면
				else if (memberStatus == 0) {
					// 탈퇴 처리된 메시지 전송
					req.setAttribute("memberNotice", "deleteMember");
					
					url = "member/login.jsp";
				} 
				// 정지 처리된 회원이라면
				else if (memberStatus == 2) {
					// 정지 처리된 메시지 전송
					req.setAttribute("memberNotice", "warningMember");
					
					url = "member/login.jsp";
				}
				
			} 
			// 로그인 실패시 로그인 페이지 다시
			else {
				url = "member/login.jsp";
			}
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return url;
		
	}

}
