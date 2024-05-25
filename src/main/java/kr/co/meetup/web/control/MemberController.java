package kr.co.meetup.web.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONArray;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.action.ListAction;
import kr.co.meetup.web.action.member.DeleteAction;
import kr.co.meetup.web.action.member.FindGeoDistrictAction;
import kr.co.meetup.web.action.member.FindPasswordFormAction;
import kr.co.meetup.web.action.member.LoginAction;
import kr.co.meetup.web.action.member.LoginFormAction;
import kr.co.meetup.web.action.member.LogoutAction;
import kr.co.meetup.web.action.member.MemberPhoneCheckAction;
import kr.co.meetup.web.action.member.MyMenuAction;
import kr.co.meetup.web.action.member.SignUpAction;
import kr.co.meetup.web.action.member.SignUpFormAction;
import kr.co.meetup.web.action.member.UpdateFormAction;
import kr.co.meetup.web.action.member.UpdatePasswordNoLoginAction;
import kr.co.meetup.web.action.member.UpdatePasswordNoLoginFormAction;

@WebServlet("/member")
public class MemberController extends HttpServlet {
	
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		String cmd = req.getParameter("cmd");
		String url = "";
		Action action = null;
		ListAction listAction = null;
		
		if(cmd.equals("signup")) {
			action = new SignUpFormAction();
		} else if (cmd.equals("signupOk")) {
			action = new SignUpAction();
		} else if (cmd.equals("login")) {
			action = new LoginFormAction();
		} else if (cmd.equals("loginOk")) {
			action = new LoginAction();
		} else if (cmd.equals("logout")) {
			action = new LogoutAction();
		} else if (cmd.equals("geoDistricts")) {
			listAction = new FindGeoDistrictAction();
			List<String> geoDistricts = listAction.execute(req, resp);
			
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			
			JSONArray jsonArray = new JSONArray();
			for (String district : geoDistricts) {
				jsonArray.add(district);
			}
			
			out.println(jsonArray.toString());
			out.flush();
			return;
		} else if (cmd.equals("phoneCheck")) {
			action = new MemberPhoneCheckAction();
			String phoneCheckResult = action.execute(req, resp);
			String findCheckResult = "";
			int randomNumber = 0;
			
			if (phoneCheckResult.equals("-1")) {
				randomNumber = (int) (Math.random() * (9999-1000+1)) + 1000;
				phoneCheckResult = Integer.toString(randomNumber);
			} else {
				phoneCheckResult = "isValidMember";
				randomNumber = (int) (Math.random() * (9999-1000+1)) + 1000;
				findCheckResult = Integer.toString(randomNumber);
			}
			
			System.out.println(phoneCheckResult);
			System.out.println(findCheckResult);
//			System.out.println(req.getParameter("memberPhone"));
			
			resp.setContentType("application/json");
			PrintWriter out = resp.getWriter();
			
			JSONArray jsonArray = new JSONArray();
			jsonArray.add(phoneCheckResult);
			jsonArray.add(findCheckResult);
			
			out.println(jsonArray.toString());
			out.flush();
			return;
		} else if(cmd.equals("myMenu")) {
			action = new MyMenuAction();
		} else if (cmd.equals("update")) {
			action = new UpdateFormAction();
		} else if (cmd.equals("find")) {
			action = new FindPasswordFormAction();
		} else if (cmd.equals("updatePwNoLogin")) {
			action = new UpdatePasswordNoLoginFormAction();
		} else if (cmd.equals("updatePwNoLoginOk")) {
			action = new UpdatePasswordNoLoginAction();
		} else if (cmd.equals("delete")) {
			action = new DeleteAction();
		}
		
		url = action.execute(req, resp);
		RequestDispatcher rd = req.getRequestDispatcher(url);
		rd.forward(req, resp);
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
	

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doProcess(req,resp);
	}
}
