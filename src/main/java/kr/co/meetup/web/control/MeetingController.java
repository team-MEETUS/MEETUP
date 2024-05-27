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
import kr.co.meetup.web.action.meeting.AttendAction;
import kr.co.meetup.web.action.meeting.DetailAction;
import kr.co.meetup.web.action.meeting.ExitAction;
import kr.co.meetup.web.action.meeting.ListAction;
import kr.co.meetup.web.action.meeting.WriteFormAction;

@SuppressWarnings("serial")
@WebServlet("/meeting")
public class MeetingController extends HttpServlet{
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		String cmd = req.getParameter("cmd");
		
		String url = "";
		Action action = new ListAction();
		
		if (cmd == null || cmd.equals("list")) {
			action = new ListAction();
		} else if (cmd.equals("write")) {
			action = new WriteFormAction();
		} else if (cmd.equals("detail")) {
			action = new DetailAction();
		}
		
		url = action.execute(req, resp);
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
	}
}
