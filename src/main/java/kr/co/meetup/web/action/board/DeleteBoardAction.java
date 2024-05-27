package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardVO;
import kr.co.meetup.web.vo.MemberVO;

public class DeleteBoardAction implements Action {

    @Override
    public String execute(HttpServletRequest req, HttpServletResponse resp) {
        try {
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html;charset=UTF-8");

            // 현재 로그인한 유저 정보 가져오기
            HttpSession session = req.getSession();
            MemberVO mvo = (MemberVO) session.getAttribute("loginMember");
            int loginNo = mvo.getMemberNo();

            // boardNo 가져오기
            String b = req.getParameter("bno");
            int boardNo = 0;
            if (b != null) {
                boardNo = Integer.parseInt(b);
            }

            // 게시글 작성자의 회원번호 가져오기
            BoardDAO dao = new BoardDAO();
            BoardVO board = dao.selectOneBoard(boardNo);
            int writerNo = board.getMemberNo();

            // 현재 로그인한 사용자와 게시글 작성자 비교
            if (loginNo != writerNo) {
                // 권한이 없는 경우 게시글 페이지로 리다이렉트
                return "redirect:board?cmd=detailboard&boardsNo=" + boardNo;
            } else {
                // 게시글 삭제
                dao.deleteOneBoard(boardNo);
                return "redirect:board?cmd=listBoard";
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:board?cmd=listBoard";
        }
    }
}
