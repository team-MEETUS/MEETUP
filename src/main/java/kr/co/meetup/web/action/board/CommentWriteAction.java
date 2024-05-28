//package kr.co.meetup.web.action.board;
//
//import java.io.UnsupportedEncodingException;
//
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//import kr.co.meetup.web.action.Action;
//import kr.co.meetup.web.dao.BoardDAO;
//import kr.co.meetup.web.vo.BoardCommentVO;
//import kr.co.meetup.web.vo.MemberVO;
//
//public class CommentWriteAction implements Action {
//
//    @Override
//    public String execute(HttpServletRequest req, HttpServletResponse resp) {
//        try {
//            req.setCharacterEncoding("UTF-8");
//            resp.setContentType("text/html;charset=UTF-8");
//
//            // 현재 로그인한 유저 정보 가져오기
//            HttpSession session = req.getSession();
//            MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
//            
//            String b = req.getParameter("boardNo");
//            int boardNo = 0;
//            if(b != null) {
//            	boardNo = Integer.parseInt(b);
//            }
//
//            String boardCommentNo = req.getParameter("boardCommentNo");
//            int memberNo = loginMember.getMemberNo();
//            String bcp = req.getParameter("boardCommentPno");
//            String boardCommentContent = req.getParameter("boardCommentContent");
//            String bs = req.getParameter("boardCommentStatus");
//
//            int boardCommentNo = 0;
//            int boardCommentStatus = 0;
//            
//            if(bcp != null && !bcp.equlas("")) {
//            	boardCommentPno = Integer.parseInt(bcp);
//            }
//            if(bs !=null && bs.equals("")) {
//            	boardCommentStatus = Integer.parseInt(bs);
//            }
//            
//            BoardDAO dao = new BoardDAO();
//            BoardCommentVO vo = new BoardCommentVO();
//
//            vo.setBoardNo(boardNo);
//            vo.setCrewNo(crewNo);
//            vo.setBoardCommentNo(boardCommentNo);
//            vo.setMemberNo(loginMember.getMemberNo());
//            vo.setBoardCommentPno(setBoardCommentPno);
//            //pno가 있다 -> 부모의 BoardCommentNo를 가져온다
//            //pno가 없다 -> 0
//            vo.setBoardCommentContent(boardCommentContent);
//            vo.setBoardCommentStatus(1);
//
//            dao.addOneComment(vo);
//
//        // 예외 발생 시 기본 리턴값
//        return "redirect:board?cmd=detailboard&boardNo=" + req.getParameter("boardNo");
//    }
//
//}
