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
import kr.co.meetup.web.action.member.ConfirmPwAction;
import kr.co.meetup.web.action.member.ConfirmPwFormAction;
import kr.co.meetup.web.action.member.DeleteAction;
import kr.co.meetup.web.action.member.FindGeoDistrictAction;
import kr.co.meetup.web.action.member.FindPasswordFormAction;
import kr.co.meetup.web.action.member.LoginAction;
import kr.co.meetup.web.action.member.LoginFormAction;
import kr.co.meetup.web.action.member.LogoutAction;
import kr.co.meetup.web.action.MainAction;
import kr.co.meetup.web.action.member.MemberPhoneCheckAction;
import kr.co.meetup.web.action.member.MemberProfileAction;
import kr.co.meetup.web.action.member.MyMenuAction;
import kr.co.meetup.web.action.member.SignUpAction;
import kr.co.meetup.web.action.member.SignUpFormAction;
import kr.co.meetup.web.action.member.UpdateFormAction;
import kr.co.meetup.web.action.member.UpdatePasswordNoLoginAction;
import kr.co.meetup.web.action.member.UpdatePasswordNoLoginFormAction;
import kr.co.meetup.web.action.member.UpdatePwLoginAction;
import kr.co.meetup.web.action.member.UpdatePwLoginFormAction;

@WebServlet("/member")
public class MemberController extends HttpServlet {
	
	private void doProcess(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=UTF-8");
		
		String cmd = req.getParameter("cmd");
		String url = "";
		Action action = null;
		ListAction listAction = null;
		
		if(cmd == null) {
			action = new MainAction();
		}
		// 회원가입 페이지 action
		else if(cmd.equals("signup")) {
			action = new SignUpFormAction();
		} 
		// 회원가입 처리 action
		else if (cmd.equals("signupOk")) {
			action = new SignUpAction();
		} 
		// 로그인 페이지 action
		else if (cmd.equals("login")) {
			action = new LoginFormAction();
		} 
		// 로그인 처리 action
		else if (cmd.equals("loginOk")) {
			action = new LoginAction();
		} 
		// 로그아웃 처리 action
		else if (cmd.equals("logout")) {
			action = new LogoutAction();
		} 
		// geoCity 선택에 따른 geoDistrict json 전송 action
		else if (cmd.equals("geoDistricts")) {
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
		} 
		// 인증번호 전송 action
		else if (cmd.equals("phoneCheck")) {
			action = new MemberPhoneCheckAction();
			String phoneCheckResult = action.execute(req, resp);
			String findCheckResult = "";
			int randomNumber = 0;
			
			// 가입된 정보가 없다면 result가 -1이 되고
			// 4자리 난수 생성 후 전송(콘솔에 나옴)
			if (phoneCheckResult.equals("-1")) {
				randomNumber = (int) (Math.random() * (9999-1000+1)) + 1000;
				phoneCheckResult = Integer.toString(randomNumber);
			} 
			// 이미 가입된 회원이 있다면 "isValidMember" 전송
			else {
				phoneCheckResult = "isValidMember";
				// 비로그인 상태 비밀찾기에 사용되는 4자리 난수 전송(콘솔에 나옴)
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
		} 
		// 마이페이지 페이지 action
		else if(cmd.equals("myMenu")) {
			action = new MyMenuAction();
		} 
		// 내 정보 수정 페이지 action
		else if (cmd.equals("update")) {
			action = new UpdateFormAction();
		} 
		// 비 로그인 상태 비밀번호 찾기 페이지 action
		else if (cmd.equals("find")) {
			action = new FindPasswordFormAction();
		} 
		// 비 로그인 핸드폰 인증 성공 후 비밀번호 변경 페이지 action
		else if (cmd.equals("updatePwNoLogin")) {
			action = new UpdatePasswordNoLoginFormAction();
		} 
		// 비 로그인 비밀번호 변경 action
		else if (cmd.equals("updatePwNoLoginOk")) {
			action = new UpdatePasswordNoLoginAction();
		} 
		// 회원탈퇴 action(마이페이지에 회원탈퇴 버튼 있음)
		else if (cmd.equals("delete")) {
			action = new DeleteAction();
		} 
		// 비밀번호 변경전 비밀번호 확인 action
		else if (cmd.equals("confirmPw")) {
			action = new ConfirmPwFormAction();
		}
		// 비밀번호 변경전 비밀번호 일치 확인 action
		else if (cmd.equals("confirmPwOk")) {
			action = new ConfirmPwAction();
		}
		// 로그인 상태 비밀번호 변경 action
		else if(cmd.equals("updatePwLogin")) {
			action = new UpdatePwLoginFormAction();
		}
		// 로그인 상태 비밀번호 변경 성공 action
		else if (cmd.equals("updatePwLoginOk" )) {
			action = new UpdatePwLoginAction();
		}
		// 다른 회원 프로필 action
		else if (cmd.equals("memberProfile")) {
			action = new MemberProfileAction();
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
