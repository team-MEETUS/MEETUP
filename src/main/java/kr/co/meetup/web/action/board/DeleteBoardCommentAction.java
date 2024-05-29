package kr.co.meetup.web.action.board;



import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.MemberVO;

public class DeleteBoardCommentAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {


			// 현재 로그인한 유저 정보 가져오기
			HttpSession session = req.getSession();
			MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
			int loginNo = mvo.getMemberNo(); // 로그인한 회원의 번호 가져오기

			// boardNo 가져오기
			int boardNo = 0;
			String b = req.getParameter("boardNo");
			if (b != null) {
				boardNo = Integer.parseInt(b);
			}

			// 댓글 작성자의 회원번호 가져오기
			BoardDAO dao = new BoardDAO();
			int boardCommentNo = Integer.parseInt(req.getParameter("boardCommentNo"));
			BoardCommentVO commentVO = dao.selectOneBoardComment(boardCommentNo);
			int commentWriterNo = commentVO.getMemberNo();

			// crewNo 가져오기
			String cn = req.getParameter("crewNo");
			
			// 형변환
			int crewNo = 0;
			if (cn != null) {
				crewNo = Integer.parseInt(cn);
			}

			// 현재 로그인한 사용자의 회원번호와 댓글 작성자의 회원번호 비교
			if (loginNo == commentWriterNo) {
				dao.deleteOneBoardComment(boardCommentNo);
			}

			req.setAttribute("boardNo", boardNo);
			req.setAttribute("boardCommentNo", boardCommentNo);
			req.setAttribute("crewNo", crewNo);
			
			return "redirect:board?cmd=detailboard&boardNo=" + boardNo + "&crewNo=" + crewNo;
	}
}