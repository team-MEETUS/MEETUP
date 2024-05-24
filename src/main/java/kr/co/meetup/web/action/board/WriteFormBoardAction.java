/*
 * package kr.co.meetup.web.action.board;
 * 
 * import jakarta.servlet.http.HttpServletRequest; import
 * jakarta.servlet.http.HttpServletResponse; import
 * kr.co.meetup.web.action.Action;
 * 
 * public class updateFormBoardAction implements Action {
 * 
 * @Override public String execute(HttpServletRequest req, HttpServletResponse
 * resp) { // 1. 파라미터 값 가져오기 String b = req.getParameter("boardNo"); if (b !=
 * null) { int boardNo = Integer.parseInt(b); // 2. dao
 * kr.co.meetup.web.dao.BoardDAO dao = new kr.co.meetup.web.dao.BoardDAO(); //
 * 3. 특정 게시물 정보를 vo로 넘겨받기 kr.co.meetup.web.vo.BoardVO vo =
 * dao.selectOneBoard(boardNo); // 4. req 요청객체에 vo를 속성으로 지정
 * req.setAttribute("vo", vo); } // updateFormBoard.jsp로 리다이렉트 return
 * "board/updateFormBoard.jsp"; }
 * 
 * }
 */