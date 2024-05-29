
package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.dao.MemberDAO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.BoardVO;
import kr.co.meetup.web.vo.CrewMemberVO;
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
		
		// url에서 직접 입력한 결과 막는 로직
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("loginMember");
		CrewDAO cdao = new CrewDAO();
		List<CrewMemberVO> crewMemberList = cdao.selectAllCrewMember(crewNo);
		boolean check = false;
		for(CrewMemberVO vo : crewMemberList) {
			if(memberVO != null && memberVO.getMemberNo() == vo.getMemberNo()) {
				check = true;
				break;
			}
		}
		if (check == false) {
			return "redirect:board?cmd=listBoard&crewNo=" + crewNo;
		}
		
		BoardDAO dao = new BoardDAO();
		String b = req.getParameter("boardNo");
		
		if(b==null) {
			return "redirect:board?cmd=listBoard&crewNo=" + crewNo;
		}
		
		int boardNo = 0;
		boardNo = Integer.parseInt(b); 
		System.out.println(boardNo);
		
		BoardVO vo= dao.selectOneBoard(boardNo);
		
		// board 테이블에서 memberNo가져와서 member 정보 조회
		MemberDAO mdao = new MemberDAO();
		MemberVO mvo = mdao.selectOneMemberByMemberNo(vo.getMemberNo());
		
		// 댓글 작성자 정보 댓글 리스트에 추가
		List<BoardCommentVO> commentList = dao.selectComment(boardNo);
		List<MemberVO> writerList = new ArrayList<MemberVO>(); // 댓글 작성자 정보를 담을 리스트 생성
		for (BoardCommentVO comment : commentList) {
		    MemberVO mmvo = mdao.selectOneMemberByMemberNo(comment.getMemberNo()); // 댓글 작성자 정보 조회
		    writerList.add(mmvo);
		}
		
		//댓글 ID를 키로 하고 작성자 정보(MemberVO)를 값으로 하는 맵(Map)
		Map<Integer, MemberVO> commentAuthorMap = new HashMap<>();
		for (BoardCommentVO comment : commentList) {
		    MemberVO mmvo = mdao.selectOneMemberByMemberNo(comment.getMemberNo());
		    commentAuthorMap.put(comment.getBoardCommentNo(), mmvo);
		}
		req.setAttribute("commentAuthorMap", commentAuthorMap);


		
		dao.raiseHitBoard(boardNo); 
		vo.setBoardHit(vo.getBoardHit() +1);
		req.setAttribute("vo", vo);
		req.setAttribute("commentList", commentList);
		req.setAttribute("boardMemberVO", mvo);
		req.setAttribute("boardNo", boardNo);
		req.setAttribute("writerList", writerList);
		dao.selectOneBoard(boardNo); 
		req.setAttribute("crewNo", crewNo);
		return "board/detailBoard.jsp";
	}
}
