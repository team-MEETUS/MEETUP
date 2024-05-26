
package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardVO;

public class DetailBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		try {
			req.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		BoardDAO dao = new BoardDAO();
		resp.setContentType("text/html;charset=UTF-8");
		String b = req.getParameter("boardNo");
		int boardNo = Integer.parseInt(b); // 게시글 조회수 1 증가 new
		if(b==null) {
			return "redirect:board?cmd=listBoard";
		}
		//Integer crewNo = (Integer) req.getSession().getAttribute("crew");
		Integer crewNo=1;
		BoardVO vo= dao.selectOneBoard(boardNo);
		
		if(vo.getCrewNo()!=crewNo) {
			return "redirect:board?cmd=listBoard&msg=crewN";
		}
		
		dao.raiseHitBoard(boardNo); 
		dao.selectOneBoard(boardNo); 
		vo.setBoardHit(vo.getBoardHit()+1);
		req.setAttribute("vo", vo);
		return "board/detailBoard.jsp";
	}
}
