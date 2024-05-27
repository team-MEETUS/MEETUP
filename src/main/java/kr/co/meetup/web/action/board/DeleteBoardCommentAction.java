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

		if (mvo == null) {
			return "redirect:/member?cmd=login";
		}

		int boardNo = Integer.parseInt(req.getParameter("bno"));
		int boardCommentNo = Integer.parseInt(req.getParameter("bcno"));

		// 댓글 작성자의 회원번호 가져오기
		BoardDAO dao = new BoardDAO();
		BoardCommentVO writerNo = dao.selectOneBoardComment(boardCommentNo);
		int commentWriterNo = writerNo.getMemberNo();

		// 현재 로그인한 사용자의 회원번호와 댓글 작성자의 회원번호 비교
		if (mvo.getMemberNo() == commentWriterNo) {
			dao.deleteOneBoardComment(boardCommentNo);
			// 삭제 완료 후 게시글 페이지로 리다이렉트
			return "redirect:board?cmd=detailboard&boardsNo=" + boardNo;

		} else {
			// 작성자만 삭제 가능하다는 메시지 출력
			req.setAttribute("errorMessage", "작성자만 댓글을 삭제할 수 있습니다.");
			return "redirect:board?cmd=detailboard&boardsNo=" + boardNo;
		}
	}
}
