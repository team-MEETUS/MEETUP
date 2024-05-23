package kr.co.meetup.web.action.board;


import java.util.List;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.BoardDAO;
import kr.co.meetup.web.vo.BoardVO;

public class ListBoardAction implements Action {
    public String execute(HttpServletRequest req, HttpServletResponse resp) { 
        BoardDAO dao = new BoardDAO();
//        List<BoardVO> list;

		/* int crewNo = (int) req.getSession().getAttribute("crewNo"); */
		/*
		 * int selectTotalCountBoard = dao.selectTotalCountBoard(); int recordPerPage =
		 * 10; int totalPage = (selectTotalCountBoard % recordPerPage == 0) ?
		 * selectTotalCountBoard / recordPerPage : selectTotalCountBoard / recordPerPage
		 * + 1; String cp = req.getParameter("cp"); int currentPage = 0; if (cp != null)
		 * { currentPage = Integer.parseInt(cp); } else { currentPage = 1; }
		 * 
		 * int boardStartNo = (currentPage - 1) * recordPerPage + 1; int boardEndNo =
		 * currentPage * recordPerPage; int startPage = Math.max(currentPage - 2, 1);
		 * int endPage = Math.min(startPage + 3, totalPage); boolean isPrev = startPage
		 * > 1; boolean isNext = endPage < totalPage;
		 */

//        if (crewNo == 1 || crewNo == -1) { 
//            list = dao.selectAllBoardBycrewNo(crewNo, boardStartNo, boardEndNo); 
//        } else { 
//            list = dao.selectAllBoardBycrewNo(crewNo, boardStartNo, boardEndNo); 
//        }

		/*
		 * req.setAttribute("selectTotalCountBoard", selectTotalCountBoard);
		 * req.setAttribute("recordPerPage", recordPerPage);
		 * req.setAttribute("totalPage", totalPage); req.setAttribute("currentPage",
		 * currentPage); req.setAttribute("boardStartNo", boardStartNo);
		 * req.setAttribute("boardEndNo", boardEndNo); req.setAttribute("startPage",
		 * startPage); req.setAttribute("isPrev", isPrev); req.setAttribute("isNext",
		 * isNext);
		 */

		/* StringBuilder pageHtml = new StringBuilder(); */
       

        return "board/listBoard.jsp"; 
    } 
}
