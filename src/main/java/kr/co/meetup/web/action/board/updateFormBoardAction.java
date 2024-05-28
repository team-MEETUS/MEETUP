package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.BoardVO;
import kr.co.meetup.web.vo.CrewMemberVO;

public class updateFormBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) { // 1. 파라미터 값 가져오기
		String b = req.getParameter("bno");
		if (b != null) {
			int boardNo = Integer.parseInt(b);
			BoardDAO dao = new BoardDAO();
			BoardVO vo = dao.selectOneBoard(boardNo);
			req.setAttribute("vo", vo);

			String cno = req.getParameter("crewNo");
			int crewNo = 0;

			if (cno != null) {
				crewNo = Integer.parseInt(cno);
			}

			req.setAttribute("crewNo", crewNo);
			req.setAttribute("boardNo", boardNo);
		}
		// updateFormBoard.jsp로 리다이렉트 return
		return "board/updateFormBoard.jsp";

	}

}
