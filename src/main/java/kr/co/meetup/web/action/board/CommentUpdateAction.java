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
	    try {
	        req.setCharacterEncoding("UTF-8");
	        resp.setContentType("text/html;charset=UTF-8");

	        // 현재 로그인한 유저 정보 가져오기
	        HttpSession session = req.getSession();
	        MemberVO mvo = (MemberVO) session.getAttribute("loginMember");

	        if (mvo == null) {
	            return "redirect:/member?cmd=login";
	        }

	        int boardCommentNo = Integer.parseInt(req.getParameter("boardCommentNo"));
	        String boardCommentContent = req.getParameter("boardCommentContent");
	        int boardNo = Integer.parseInt(req.getParameter("boardNo"));
	        int boardCommentStatus = 1; // 댓글 상태를 1(정상)로 설정

	        BoardCommentVO boardCommentVO = new BoardCommentVO();
	        boardCommentVO.setBoardNo(boardNo);
	        boardCommentVO.setBoardCommentNo(boardCommentNo);
	        boardCommentVO.setBoardCommentContent(boardCommentContent);
	        boardCommentVO.setBoardCommentStatus(boardCommentStatus);

	        BoardDAO dao = new BoardDAO();
	        // 댓글 작성자의 회원번호 가져오기
	        BoardCommentVO writerNo = dao.selectOneBoardComment(boardCommentNo);
	        int commentWriterNo = writerNo.getMemberNo();

	        // 현재 로그인한 사용자의 회원번호와 댓글 작성자의 회원번호 비교
	        if (mvo.getMemberNo() == commentWriterNo) {
	            dao.updateOneBoardComment(boardCommentVO);
	            // 수정 완료 후 게시글 페이지로 리다이렉트
	            return "redirect:board?cmd=detailboard&boardsNo=" + req.getParameter("boardNo");
	        } else {
	            // 작성자만 수정 가능하다는 메시지 출력
	            req.setAttribute("errorMessage", "작성자만 댓글을 수정할 수 있습니다.");
	            return "redirect:board?cmd=detailboard&boardsNo=" + req.getParameter("boardNo");
	        }
	    } catch (UnsupportedEncodingException e) {
	        e.printStackTrace();
	        return "error";
	    }
	}
}
