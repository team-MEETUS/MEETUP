package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardCommentVO;
import kr.co.meetup.web.vo.MemberVO;

public class CommentWriteAction implements Action {

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

            Integer boardNo = Integer.parseInt(req.getParameter("boardNo"));
            String boardCommentContent = req.getParameter("boardCommentContent");

            BoardDAO dao = new BoardDAO();
            BoardCommentVO vo = new BoardCommentVO();

            vo.setBoardCommentContent(boardCommentContent);
            vo.setBoardCommentStatus(1);
            vo.setMemberNo(mvo.getMemberNo());
            vo.setBoardNo(boardNo);

            System.out.println(vo);

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 예외 발생 시 기본 리턴값
        return "redirect:board?cmd=detailboard&boardNo=" + req.getParameter("boardNo");
    }

}
