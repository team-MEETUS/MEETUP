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
            int loginNo = mvo.getMemberNo();

            //WFBA에서 memberNo 가져오기
            String mno = req.getParameter("memberNo");
            int memberNo = 0;
            
            // cno(crewNo) 값 가져오기
    		String cno =req.getParameter("crewNo");
    		int crewNo = 0;
    		
    		if(cno != null && mno != null) {
    			crewNo =Integer.parseInt(cno);
    			memberNo = Integer.parseInt(mno);
    		}
    		
    		if(loginNo == memberNo) {
	           //게시글 정보 가져오기
	           String boardCategoryNo = (String) req.getParameter("boardCategoryNo");
	           String boardTitle = req.getParameter("boardTitle");
	           String boardContent = req.getParameter("boardContent");
           
	            int categoryNo = Integer.parseInt(boardCategoryNo);
	            BoardVO boardVO = new BoardVO();
	            boardVO.setCrewNo(crewNo); // 모임 번호 설정
	            boardVO.setMemberNo(mvo.getMemberNo());
	            boardVO.setBoardCategoryNo(categoryNo);
	            boardVO.setBoardTitle(boardTitle);
	            boardVO.setBoardContent(boardContent);
	            boardVO.setBoardHit(0);
	            boardVO.setBoardStatus(1);
	            
	            BoardDAO boardDAO = new BoardDAO();
	            boardDAO.addOneBoard(boardVO);
    		}

            // iv.setBoardImgOriginalImg(boardImgOriginalImg);
            // iv.setBoardImgSaveImg(boardImgSaveImg);
            
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        // 작성 완료 후 게시글 목록 페이지로 리다이렉트
        return "redirect:board?cmd=listBoard";
    }

}
