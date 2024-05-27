package kr.co.meetup.web.action.board;

import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardVO;

public class updateBoardAction implements Action {

	@Override
	public String execute(HttpServletRequest req, HttpServletResponse resp) {
		String b = "";
		try {
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			b = req.getParameter("boardNo"); // 파라미터 값 가져오기
			if (b != null) {
				int boardNo = Integer.parseInt(req.getParameter("boardNo"));
				String boardTitle = req.getParameter("boardTitle");
				String boardContent = req.getParameter("boardContent");

				// DAO 객체 생성 및 게시글 업데이트
				BoardDAO dao = new BoardDAO();
				BoardVO vo = new BoardVO();
				vo.setBoardNo(boardNo);
				vo.setBoardTitle(boardTitle);
				vo.setBoardContent(boardContent);
				vo.setBoardStatus(1);
				dao.updateOneBoard(vo);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "board?cmd=detailboard&boardNo=" + b;
	}
}
