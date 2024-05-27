package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardCommentVO;

public class CommentUpdateAction implements Action {
    
    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html;charset=UTF-8");

            int boardCommentNo = Integer.parseInt(req.getParameter("boardCommentNo"));
            String boardCommentContent = req.getParameter("boardCommentContent");
            int boardNo = Integer.parseInt(req.getParameter("boardNo"));
            int boardCommentStatus = 1; // 댓글 상태를 1로 설정

            System.out.println(req.getParameter("boardCommentNo"));
            
            BoardCommentVO boardCommentVO = new BoardCommentVO();
            boardCommentVO.setBoardNo(boardNo);
            boardCommentVO.setBoardCommentNo(boardCommentNo);
            boardCommentVO.setBoardCommentContent(boardCommentContent);
            boardCommentVO.setBoardCommentStatus(boardCommentStatus);

            BoardDAO dao = new BoardDAO();
            dao.updateOneBoardComment(boardCommentVO);
            
            // 수정 완료 후 게시글 페이지로 리다이렉트
            return "redirect:board?cmd=detailboard&boardNo=" + req.getParameter("boardNo");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
            return "error";
        }
    }
}
