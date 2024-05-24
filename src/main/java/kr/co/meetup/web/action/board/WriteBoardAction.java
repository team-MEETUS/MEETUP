package kr.co.meetup.web.action.board;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.MemberVO;

public class WriteBoardAction implements Action {


    	@Override
    	public String execute(HttpServletRequest req, HttpServletResponse resp) {
    		BoardDAO dao = new BoardDAO();
        // 1. 로그인 여부 확인
		/* HttpSession session = request.getSession(); */
//        MemberVO member = (MemberVO) session.getAttribute("member");
//        if (member == null) {
//            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
//            return "redirect:/login.jsp";
//        }
//
//        // 2. 모임 회원 여부 확인
//        if (!isMeetupMember(member.getMemberNo())) {
//            // 모임 회원이 아닌 경우 접근 불가 페이지로 리다이렉트
//            return "redirect:/accessDenied.jsp";
//        }

        // 3. 게시글 작성 로직 수행
        String boardNo = req.getParameter("boardNo");
        String boardCategoryNo = req.getParameter("boardCategoryNo");
        String memberNo = req.getParameter("memberNo");
        String boardTitle = req.getParameter("boardTitle");
        String boardContent = req.getParameter("boardContent");
        String boardHit = req.getParameter("boardHit");
        String boardImgOriginalImg = req.getParameter("boardImgOriginalImg");
        String boardImgSaveImg = req.getParameter("boardImgSaveImg");

        // 게시글 작성 로직 구현
        // ...

        // 작성 완료 후 게시글 목록 페이지로 리다이렉트
        return "redirect:/board?cmd=listBoard";
    }

    private boolean isMeetupMember(int memberNo) {
        // 회원 번호를 이용하여 모임 회원 여부를 확인하는 로직 구현
        // 예: DB 조회 등을 통해 확인
        return true; // 임시로 true 반환
    }
}