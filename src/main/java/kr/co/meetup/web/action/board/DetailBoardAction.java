
package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;
import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.BoardVO;
import kr.co.meetup.web.vo.MemberVO;

public class DetailBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// crewNo 가져오기
		String cno = req.getParameter("crewNo");
		int crewNo = 0;
		if (cno != null) {
			crewNo = Integer.parseInt(cno);
		}
		
		BoardDAO dao = new BoardDAO();
		String b = req.getParameter("boardNo");
		int boardNo = Integer.parseInt(b); // 게시글 조회수 1 증가 new
		System.out.println(boardNo);
		if(b==null) {
			return "redirect:board?cmd=listBoard&crewNo=" + crewNo;
		}
		BoardVO vo= dao.selectOneBoard(boardNo);
		
		// board 테이블에서 memberNo가져와서 member 정보 조회
		MemberDAO mdao = new MemberDAO();
		MemberVO mvo = mdao.selectOneMemberByMemberNo(vo.getMemberNo());
		
		if(vo.getCrewNo()!= crewNo) {
			return "redirect:board?cmd=listBoard&crewNo=" + crewNo;
		}
		List<BoardCommentVO> commentList=dao.selectComment(boardNo);
		
		dao.raiseHitBoard(boardNo); 
		dao.selectOneBoard(boardNo); 
		vo.setBoardHit(vo.getBoardHit()+1);
		req.setAttribute("vo", vo);
		req.setAttribute("commentList", commentList);
		req.setAttribute("boardMemberVO", mvo);
		req.setAttribute("crewNo", crewNo);
		return "board/detailBoard.jsp";
	}
}
