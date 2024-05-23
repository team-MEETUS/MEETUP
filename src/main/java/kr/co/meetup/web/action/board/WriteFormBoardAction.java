package kr.co.meetup.web.action.board;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.MemberVO;

public class WriteFormBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		BoardDAO dao = new BoardDAO();
		
		/*
		 * 로그인 안 한 사람 (회원 정보 있냐 없냐) //
		 * 로그인 했는데 모임 회원이 아니야 이거랑 //
		 * 크루 멤버랑 지금 들어온 애 //
		 * 크루스테이터스랑 값 비교해야 함 (강퇴회원 등)
		 */
		
		System.out.println("writeformaction");
		 // 1. 로그인 여부 확인
/*        HttpSession session = request.getSession();*/
/*        MemberVO member = (MemberVO) session.getAttribute("member");
        if (member == null) {*/
            // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
			/* return "redirect:/login.jsp"; */
			/* } */

        // 2. 모임 회원 여부 확인
		/*
		 * if (!isMeetupMember(member.getMemberNo())) { // 모임 회원이 아닌 경우 접근 불가 페이지로 리다이렉트
		 * return "redirect:/accessDenied.jsp"; }
		 */

		/*
		 * // 3. 게시글 작성 폼 페이지로 포워딩 return "/board/writeForm.jsp"; }
		 * 
		 * private boolean isMeetupMember(int memberNo) { // 회원 번호를 이용하여 모임 회원 여부를 확인하는
		 * 로직 구현 // 예: DB 조회 등을 통해 확인 return true; // 임시로 true 반환 } }
		 */
		
		
		return "board/writeFormBoard.jsp";
	}
}
