package kr.co.meetup.web.control;

import java.io.IOException;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.action.board.DetailBoardAction;
import kr.co.meetup.web.action.board.ListBoardAction;
import kr.co.meetup.web.action.board.WriteBoardAction;
import kr.co.meetup.web.action.board.WriteFormBoardAction;

@SuppressWarnings("serial")
@WebServlet("/board")

public class BoardController extends HttpServlet {

	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");

		String cmd = "";
		String url = "";
		Action action = null;

		cmd = req.getParameter("cmd");

		System.out.println("cmd : " + cmd);

		if (cmd == null || cmd.equals("listBoard")) {
			action = new ListBoardAction();
		} else if (cmd.equals("writeBoard")) {
			action = new WriteFormBoardAction();
		} else if (cmd.equals("writeOkBoard")) {
			action = new WriteBoardAction();
		} else if (cmd.equals("detailBoard")) {
			action = new DetailBoardAction();
		}
		/*
		 * else if (cmd.equals("updateBoard")) { action = new updateFormBoardAction(); }
		 * else if (cmd.equals("updateOkBoard")) { action = new updateBoardAction(); }
		 * else if (cmd.equals("deleteBoard")) { action = new DeleteBoardAction(); }
		 */

		url = action.execute(req, resp);

		if (url.startsWith("redirect:")) {
			resp.sendRedirect(url.replace("redirect:", ""));
			return;
		}
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
//		// upload 디렉토리 실제 경로
//		String saveDir = req.getServletContext().getRealPath("/upload");
//		// System.out.println("saveDir : " + saveDir); // 경로 확인용
//
//		// 최대 파일 크기 지정
//		int maxFileSize = 1024 * 1024 * 30;
//
//		try {
//			// MultipartRequest 객체 생성
//			MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
//			// cmd 파라미터 값 가져오기
//			String cmd = mr.getParameter("cmd");
//			// writeOkBoard 라면 파라미터 값 가져오기
//			if (cmd.equals("writeOkBoard")) {
//				String boardNo = mr.getParameter("boardNo");
//				String crewNo = mr.getParameter("crewNo");
//				String boardCategoryNo = mr.getParameter("boardCategoryNo");
//				String memberNo = mr.getParameter("memberNo");
//				String boardTitle = mr.getParameter("boardTitle");
//				String boardContent = mr.getParameter("boardContent");
//				String boardHit = mr.getParameter("boardHit");
//				String boardStatus = mr.getParameter("boardStatus");
//				
//
//				// 메인 이미지의 원본파일명, 저장파일명
//				String boardImgOriginalImg = mr.getOriginalFileName("boardImg");
//				String boardImgSaveImg = mr.getFilesystemName("boardImg");
//				;
//
//				// 속성으로 파라미터 값 부여
//				 req.setAttribute("boardNo", boardNo);
//				 req.setAttribute("crewNo", crewNo);
//				 req.setAttribute("boardCategoryNo", boardCategoryNo);
//				 req.setAttribute("memberNo", memberNo);
//				 req.setAttribute("boardTitle", boardTitle);
//				 req.setAttribute("boardContent", boardContent);
//				 req.setAttribute("boardHit", boardHit);
//				 req.setAttribute("boardStatus", boardStatus);
//				 
//				Action action = new WriteBoardAction();
//
//				String url = action.execute(req, resp);
//
//				// "redirect:" 문자열 제거하고 리다이렉트
//				if (url.startsWith("redirect:")) {
//					resp.sendRedirect(url.substring(9));
//				} else {
//					RequestDispatcher rd = req.getRequestDispatcher(url);
//					rd.forward(req, resp);
//				}
//			}
//		} catch (IOException e) {
//			System.err.println("IOException: " + e.getMessage());
//			e.printStackTrace();
//		}
	}

}