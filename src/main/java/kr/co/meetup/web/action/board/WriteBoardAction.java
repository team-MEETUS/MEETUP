package kr.co.meetup.web.action.board;

import java.io.IOException;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.dao.BoardDAO;

import kr.co.meetup.web.vo.BoardVO;

import kr.co.meetup.web.vo.MemberVO;

@SuppressWarnings("serial")
@WebServlet("/boardWrite")
public class WriteBoardAction extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        // 현재 로그인한 유저 정보 가져오기
        HttpSession session = req.getSession();
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");

        // 파일 경로 받아오기
        String saveDir = req.getServletContext().getRealPath("/upload");

        // 최대 파일 크기 지정
        int maxFileSize = 1024 * 1024 * 30;

        // MultipartRequest 객체 생성
        MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());

        // MultipartRequest 객체로부터 파라미터 값 가져오기
        String cno = mr.getParameter("crewNo");
        int memberNo = loginMember.getMemberNo();
        // 선택된 boardCategoryNo 가져오기
        String selectedBoardCategoryNo = mr.getParameter("boardCategoryNo");
        int boardCategoryNo = 0;
        if (selectedBoardCategoryNo != null && !selectedBoardCategoryNo.isEmpty()) {
            boardCategoryNo = Integer.parseInt(selectedBoardCategoryNo);
        }

        String boardTitle = mr.getParameter("boardTitle");
        String boardContent = mr.getParameter("boardContent");
        String bh = mr.getParameter("boardHit");
        String bs = mr.getParameter("boardStatus");

        // String > int 형변환
        int crewNo = 0;
        int boardHit = 0;
        int boardStatus = 0;

        if (cno != null && !cno.equals("")) {
            crewNo = Integer.parseInt(cno);
        }
        if (bh != null && !bh.equals("")) {
            boardHit = Integer.parseInt(bh);
        }
        if (bs != null && !bs.equals("")) {
            boardStatus = Integer.parseInt(bs);
        }

        // DAO 객체 생성 및 게시글 작성
        BoardDAO dao = new BoardDAO();
        BoardVO vo = new BoardVO();

        vo.setCrewNo(crewNo);
        vo.setBoardCategoryNo(boardCategoryNo);
        vo.setMemberNo(memberNo);
        vo.setBoardTitle(boardTitle);
        vo.setBoardContent(boardContent);
        vo.setBoardHit(boardHit);
        vo.setBoardStatus(1);
        System.out.println("vo : " + vo);
        // DB에 게시글 저장
        dao.addOneBoard(vo);

        // 작성 완료 후 게시글 목록 페이지로 리다이렉트
        resp.sendRedirect("board?cmd=listBoard&crewNo=" + cno + "&memberNo=" + memberNo);
    }
}
