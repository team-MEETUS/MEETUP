
package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardVO;

public class updateFormBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) { // 1. 파라미터 값 가져오기
		String b = req.getParameter("bno");
		if (b != null) {
			int boardNo = Integer.parseInt(b);
			BoardDAO dao = new BoardDAO(); 
			BoardVO vo = dao.selectOneBoard(boardNo);
			req.setAttribute("vo", vo);
			
		} // updateFormBoard.jsp로 리다이렉트 return
		return "board/updateFormBoard.jsp";
	}

}
