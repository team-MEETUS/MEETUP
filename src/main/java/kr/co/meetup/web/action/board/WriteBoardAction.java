package kr.co.meetup.web.action.board;

import java.io.UnsupportedEncodingException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardImgVO;
import kr.co.meetup.web.vo.BoardVO;

public class WriteBoardAction implements Action {


    	@Override
    	public String execute(HttpServletRequest req, HttpServletResponse resp) {
    		try {
				req.setCharacterEncoding("UTF-8");
				resp.setContentType("text/html;charset=UTF-8");
				

        // 게시글 작성 로직 수행
				//임시로그인 
		//String crewNo =  (String) req.getAttribute("crewNo");
		//String memberNo = (String) req.getAttribute("memberNo");
		
		String crewNo = "1";
		String memberNo = "1";
		
		if(crewNo == null || memberNo==null) {
			  return "redirect:/member?cmd=login";
		}
        String boardCategoryNo = (String) req.getParameter("boardCategoryNo");
        String boardTitle = req.getParameter("boardTitle");
        String boardContent = req.getParameter("boardContent");
        //String boardHit = req.getParameter("boardHit");
        //이미지의 원본파일명, 저장파일명
        //이미지 처리 제외
        //String boardImgOriginalImg = req.getParameter("boardImg");
        //String boardImgSaveImg = req.getParameter("boardImg");
        
        BoardDAO dao = new BoardDAO();
        BoardVO vo = new BoardVO();
        BoardImgVO iv = new BoardImgVO();
        
    
   
        int categoryNo = Integer.parseInt(boardCategoryNo);
        vo.setCrewNo(Integer.parseInt(crewNo));
        vo.setMemberNo(Integer.parseInt(memberNo));
        vo.setBoardCategoryNo(Integer.parseInt(boardCategoryNo));
        vo.setBoardTitle(boardTitle);
        vo.setBoardContent(boardContent);
        vo.setBoardStatus(categoryNo==1?1:2);
        System.out.println(vo);
   
        //vo.setBoardHit(Integer.parseInt(boardHit));
		//iv.setBoardImgOriginalImg(boardImgOriginalImg);
		//iv.setBoardImgSaveImg(boardImgSaveImg);
		     
		dao.addOneBoard(vo);

    		} catch (UnsupportedEncodingException e) {
    			// TODO Auto-generated catch block
    			e.printStackTrace();
    		}

        // 작성 완료 후 게시글 목록 페이지로 리다이렉트
        return "redirect:board?cmd=listBoard";
    }

}