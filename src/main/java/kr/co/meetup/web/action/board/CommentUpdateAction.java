package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.MemberVO;

public class CommentUpdateAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		int boardNo = 0;
		int crewNo = 0;
		int memberNo = 0;
		
		try {
			req.setCharacterEncoding("UTF-8");
		
		resp.setContentType("text/html;charset=UTF-8");
		
		

			// 현재 로그인한 유저 정보 가져오기
			HttpSession session = req.getSession();
			MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
			int loginNo = mvo.getMemberNo();

			// 댓글 작성자의 회원번호 가져오기
			BoardDAO dao = new BoardDAO();
			int boardCommentNo = Integer.parseInt(req.getParameter("boardCommentNo"));
			BoardCommentVO writerNo = dao.selectOneBoardComment(boardCommentNo);
			int commentWriterNo = writerNo.getMemberNo();

			// 로그인한 회원의 번호 가져오기
			memberNo = loginNo;

			// boardNo 가져오기
			String b = req.getParameter("boardNo");
			if (b != null) {
				boardNo = Integer.parseInt(b);
			}

			// crewNo 가져오기
			String cno = req.getParameter("crewNo");
			if (cno != null) {
				crewNo = Integer.parseInt(cno);
			}


				String boardCommentContent = req.getParameter("boardCommentContent");

				BoardCommentVO boardCommentVO = new BoardCommentVO();
				boardCommentVO.setBoardNo(boardNo);
				boardCommentVO.setBoardCommentNo(boardCommentNo);
				boardCommentVO.setBoardCommentContent(boardCommentContent);
				boardCommentVO.setBoardCommentStatus(1);

				dao.updateOneBoardComment(boardCommentVO);
				
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "redirect:board?cmd=detailboard&boardNo=" + boardNo + "&crewNo=" + crewNo + "&memberNo=" + memberNo;
}
	}
	