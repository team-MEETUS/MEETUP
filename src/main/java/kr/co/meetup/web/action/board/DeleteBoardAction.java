/*
 * package kr.co.meetup.web.action.board;
 * 
 * import jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import
 * kr.co.meetup.web.action.Action; import kr.co.meetup.web.dao.BoardDAO;
 * 
 * public class DeleteBoardAction implements Action {
 * 
 * @Override public String execute(HttpServletRequest req, HttpServletResponse
 * resp) { String b = req.getParameter("boardNo"); if(b != null) { int boardNo =
 * Integer.parseInt(b); BoardDAO dao = new BoardDAO();
 * dao.deleteOneBoard(boardNo); } // listBoard로 리다이렉트 return
 * "board?cmd=listBoard"; }
 * 
 * }
 */