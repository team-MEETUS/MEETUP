/*
 * package kr.co.meetup.web.action.board;
 * 
 * import jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import
 * kr.co.meetup.web.action.Action;
 * 
 * 
 * public class DetailBoardAction implements Action {
 * 
 * @Override public String execute(HttpServletRequest req, HttpServletResponse
 * resp) { String b = req.getParameter("boardNo");
 * 
 * if (b != null) { int boardNo = Integer.parseInt(b); // 게시글 조회수 1 증가 new
 * kr.co.meetup.web.dao.BoardDAO().raiseHitBoard(boardNo); // 2. dao
 * kr.co.meetup.web.dao.BoardDAO dao = new kr.co.meetup.web.dao.BoardDAO(); //
 * 3. 특정 게시물 정보를 vo로 넘겨받기 kr.co.meetup.web.vo.BoardVO vo =
 * dao.selectOneBoard(boardNo); // 4. req 요청객체에 vo를 속성으로 지정
 * req.setAttribute("vo", vo); } // detailBoard로 리다이렉트 return
 * "board/detailBoard.jsp"; } }
 */