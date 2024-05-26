
package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;

public class updateFormBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) { // 1. 파라미터 값 가져오기
		String b = req.getParameter("bno");
		if (b != null) {
			int boardNo = Integer.parseInt(b); // 2. dao
			kr.co.meetup.web.dao.BoardDAO dao = new kr.co.meetup.web.dao.BoardDAO(); //
			kr.co.meetup.web.vo.BoardVO vo = dao.selectOneBoard(boardNo); // 4. req 요청객체에 vo를 속성으로 지정
			req.setAttribute("vo", vo);
			
		} // updateFormBoard.jsp로 리다이렉트 return
		return "board/updateFormBoard.jsp";
	}

}
