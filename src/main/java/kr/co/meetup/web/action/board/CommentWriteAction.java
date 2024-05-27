package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.BoardImgVO;
import kr.co.meetup.web.vo.BoardVO;

public class CommentWriteAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");

			// 임시로그인
			String memberNo = "1";

			if (memberNo == null) {
				return "redirect:/member?cmd=login";
			}
			Integer boardNo = Integer.parseInt(req.getParameter("boardNo"));
			String boardCommentContent = req.getParameter("boardCommentContent");

			BoardDAO dao = new BoardDAO();
			BoardCommentVO vo = new BoardCommentVO();

			vo.setBoardCommentContent(boardCommentContent);
			vo.setBoardCommentStatus(1);
			vo.setMemberNo(Integer.parseInt(memberNo));
			vo.setBoardNo(boardNo);

			System.out.println(vo);


			dao.addOneComment(vo);
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		// 작성 완료 후 게시글 페이지로 리다이렉트
		return "redirect:board?cmd=detailboard&boardNo="+req.getParameter("boardNo");
	}

}
