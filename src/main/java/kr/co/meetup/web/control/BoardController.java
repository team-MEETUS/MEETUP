package kr.co.meetup.web.control;
import java.io.IOException;
import java.io.UnsupportedEncodingException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.action.board.DeleteBoardAction;
import kr.co.meetup.web.action.board.DetailBoardAction;
import kr.co.meetup.web.action.board.ListBoardAction;
import kr.co.meetup.web.action.board.WriteBoardAction;
import kr.co.meetup.web.action.board.WriteFormBoardAction;
import kr.co.meetup.web.action.board.updateBoardAction;
import kr.co.meetup.web.action.board.updateFormBoardAction;

@SuppressWarnings("serial")
@WebServlet("/board")
public class BoardController extends HttpServlet {
	
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		// cmd 파라미터 값 가져오기 
		String cmd = req.getParameter("cmd");
		String url = "";
		Action action = null;
		
		if (cmd == null || cmd.equals("listBoard")) {
			action = new ListBoardAction();
		} else if (cmd.equals("writeBoard")) {
			action = new WriteFormBoardAction();
		} else if (cmd.equals("writeOkBoard")) {
			action = new WriteBoardAction();
		} else if (cmd.equals("detailBoard")) {
			action = new DetailBoardAction();
		} else if (cmd.equals("updateBoard")) {
			action = new updateFormBoardAction();
		} else if (cmd.equals("updateOkBoard")) {
			action = new updateBoardAction();
		} else if (cmd.equals("deleteBoard")) {
			action = new DeleteBoardAction();
		}
		
		/*
		 * url = action.execute(req, resp); RequestDispatcher rd =
		 * req.getRequestDispatcher(url); rd.forward(req, resp);
		 */
		
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req, resp);
	}
	
}
