package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;

public class DeleteBoardCommentAction implements Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        int boardNo = Integer.parseInt(req.getParameter("bno"));
        int boardCommentNo = Integer.parseInt(req.getParameter("bcno"));
        
        BoardDAO dao = new BoardDAO();
        dao.deleteOneBoardComment(boardCommentNo);
        
        // 삭제 후 게시글 상세 페이지로 리다이렉트
        return "board?cmd=detailboard&boardNo=" + boardNo;
    }

}
