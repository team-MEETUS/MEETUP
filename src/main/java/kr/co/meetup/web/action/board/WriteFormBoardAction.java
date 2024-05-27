package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.CrewMemberVO;

public class WriteFormBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) { 
		String cno = req.getParameter("crewNo");
		String mno = req.getParameter("memberNo");
		int crewNo = 0;
		int memberNo = 0;
		
		if(cno != null && mno != null) {
			crewNo = Integer.parseInt(cno);
			memberNo = Integer.parseInt(mno);
		}
		
		CrewDAO cdao = new CrewDAO();
		CrewMemberVO vo = cdao.selectCrewMemberByCrewNoMemberNo(crewNo, memberNo);
		
		req.setAttribute("crewNo", crewNo);
		req.setAttribute("memberNo", memberNo);
		req.setAttribute("crewMemberVO", vo);
		
		return "board/writeFormBoard.jsp";
	}

}

