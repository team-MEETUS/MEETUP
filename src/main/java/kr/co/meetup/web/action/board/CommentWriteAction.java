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
        int boardNo = 0; // 기본값 초기화
        int crewNo = 0;  // crewNo 기본값 초기화
        int memberNo = 0; // memberNo 기본값 초기화

        try {
            req.setCharacterEncoding("UTF-8");
            resp.setContentType("text/html;charset=UTF-8");

            // 현재 로그인한 유저 정보 가져오기
            HttpSession session = req.getSession();
            MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

            if (loginMember == null) {
                return "redirect:login.jsp"; // 로그인 정보가 없으면 로그인 페이지로 리다이렉트
            }

            // 로그인한 회원의 번호 가져오기
            memberNo = loginMember.getMemberNo();

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

            // 파라미터 값 가져오기
            String bcp = req.getParameter("boardCommentPno");
            String boardCommentContent = req.getParameter("boardCommentContent");

            // 형변환
            int boardCommentPno = 0;
            if (bcp != null && !bcp.equals("")) {
                boardCommentPno = Integer.parseInt(bcp);
            }

            BoardDAO dao = new BoardDAO();
            BoardCommentVO vo = new BoardCommentVO();

            // DB에 저장
            vo.setBoardNo(boardNo);
            vo.setMemberNo(memberNo);
            vo.setBoardCommentPno(boardCommentPno);
            vo.setBoardCommentContent(boardCommentContent);
            vo.setBoardCommentStatus(1);

            dao.addOneComment(vo);

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 예외 발생 시 기본 리턴값
        return "redirect:board?cmd=detailboard&boardNo=" + boardNo + "&crewNo=" + crewNo + "&memberNo=" + memberNo;

    }
}
