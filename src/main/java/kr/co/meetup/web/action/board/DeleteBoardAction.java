package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.MemberVO;

public class DeleteBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {


		// 현재 로그인한 유저 정보 가져오기
		HttpSession session = req.getSession();
		MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
		int loginNo = mvo.getMemberNo();

		// boardNo 가져오기
		int boardNo = 0;
		String b = req.getParameter("boardNo");
		if (b != null) {
			boardNo = Integer.parseInt(b);
			BoardDAO dao = new BoardDAO();
			dao.deleteOneBoard(boardNo);
		}
		
		int crewNo = 0;
		String cno = req.getParameter("crewNo");
		if (cno != null) {
			crewNo = Integer.parseInt(cno);
		}
		
		req.setAttribute("crewNo", crewNo);
		req.setAttribute("boardNo", boardNo);
		req.setAttribute("memberNo", loginNo);

		return "board?cmd=listBoard&boardNo="+boardNo;
	}

}
