package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.dao.CrewDAO;
import kr.co.meetup.web.vo.BoardImgVO;
import kr.co.meetup.web.vo.BoardVO;
import kr.co.meetup.web.vo.CrewMemberVO;
import kr.co.meetup.web.vo.MemberVO;

public class WriteBoardAction implements Action {

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

            // 모임 회원번호 가져오기
            HttpSession session2 = req.getSession();
            String cno = req.getParameter("boardCrewNo");
            int crewNo = 0;
            
           if(cno != null) {
        	    crewNo = Integer.parseInt(cno);
           }

           //게시글 정보 가져오기
           String boardCategoryNo = (String) req.getParameter("boardCategoryNo");
           String boardTitle = req.getParameter("boardTitle");
           String boardContent = req.getParameter("boardContent");
           
           BoardDAO dao = new BoardDAO();
           BoardVO vo = new BoardVO();
           BoardImgVO iv = new BoardImgVO();
           
           //현재 로그인한 사용자의 회원번호와 모임회원번호 비교
            if(mvo.getMemberNo() == crewNo) {
            	dao.addOneBoard(vo);
           
	            int categoryNo = Integer.parseInt(boardCategoryNo);
	            vo.setCrewNo(crewNo); // 모임 번호 설정
	            vo.setMemberNo(mvo.getMemberNo());
	            vo.setBoardCategoryNo(Integer.parseInt(boardCategoryNo));
	            vo.setBoardTitle(boardTitle);
	            vo.setBoardContent(boardContent);
	            vo.setBoardStatus(categoryNo == 1 ? 1 : 2);

            // iv.setBoardImgOriginalImg(boardImgOriginalImg);
            // iv.setBoardImgSaveImg(boardImgSaveImg);
            
            }else {
            	req.setAttribute("errorMessage", "모임에 가입해보세요.");
                return "redirect:/crew?cmd=signup"; // 모임 가입 페이지로 리다이렉트
            }
            

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 작성 완료 후 게시글 목록 페이지로 리다이렉트
        return "redirect:board?cmd=listBoard";
    }

}
