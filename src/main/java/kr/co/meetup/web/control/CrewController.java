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
import kr.co.meetup.web.action.crew.DetailAction;
import kr.co.meetup.web.action.crew.ListAction;
import kr.co.meetup.web.action.crew.SignUpAction;
import kr.co.meetup.web.action.crew.WriteFormAction;

@SuppressWarnings("serial")
@WebServlet("/crew")
public class CrewController extends HttpServlet {
	
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		String cmd = "";
		String url = "";
		Action action = null;
		
		cmd = req.getParameter("cmd");
		
		if (cmd == null || cmd.equals("list")) {
			action = new ListAction();
		} else if (cmd.equals("write")) {
			action = new WriteFormAction();
		} else if (cmd.equals("detail")) {
			action = new DetailAction();
		} else if (cmd.equals("signup")) {
			action = new SignUpAction();
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
