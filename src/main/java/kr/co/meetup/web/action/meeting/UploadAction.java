package kr.co.meetup.web.action.meeting;

import java.io.IOException;
import java.sql.Timestamp;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.co.meetup.web.action.Action;
import kr.co.meetup.web.dao.MeetingDAO;
import kr.co.meetup.web.vo.MeetingVO;
import kr.co.meetup.web.vo.MemberVO;

@SuppressWarnings("serial")
@WebServlet("/meetingUpload")
public class UploadAction extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 현재 로그인한 회원 vo 가져오기
		HttpSession session = req.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		
		// 로그인한 회원일 경우
		if(loginMember != null) {
			String saveDir = req.getServletContext().getRealPath("/upload");
			System.out.println("saveDir : " + saveDir);
			 
			// 최대 파일 크기 지정 
		    int maxFileSize = 1024 * 1024 * 30;
		    
		    MultipartRequest mr = new MultipartRequest(req, saveDir, maxFileSize, "UTF-8", new DefaultFileRenamePolicy());
	
		    int memberNo = loginMember.getMemberNo();
		    
		    String crewNo = mr.getParameter("crewNo");
			String meetingName = mr.getParameter("meetingName");
			String meetingDay = mr.getParameter("meetingDate");
			String meetingTime1 = mr.getParameter("meetingTime1");
			String meetingTime2 = mr.getParameter("meetingTime2");
			String meetingLoc = mr.getParameter("meetingLoc");
			String meetingPrice = mr.getParameter("meetingPrice");
			String meetingMax = mr.getParameter("meetingMax");
			
			// 메인 이미지의 원본파일명, 저장파일명
			String meetingOriginalImg = mr.getOriginalFileName("meetingImg");
			String meetingSaveImg = mr.getFilesystemName("meetingImg");
			String meetingDate = meetingDay + " " + meetingTime1 + ":" + meetingTime2 + ":00";
			
			if(meetingOriginalImg == null) {
				meetingOriginalImg = "meetingDefault.jpg";
			}
			if(meetingSaveImg == null) {
				meetingSaveImg = "meetingDefault.jpg";
			}
			
			System.out.println("crewNo : " + crewNo);
			System.out.println("memberNo : " + memberNo);
			System.out.println("meetingName : " + meetingName);
			System.out.println("meetingLoc : " + meetingLoc);
			System.out.println("meetingPrice : " + meetingPrice);
			System.out.println("meetingMax : " + meetingMax);
			System.out.println("meetingOriginalImg : " + meetingOriginalImg);
			System.out.println("meetingSaveImg : " + meetingSaveImg);
			System.out.println("meetingDate : " + meetingDate);
			
			MeetingDAO dao = new MeetingDAO();
			MeetingVO vo = new MeetingVO();
			
			vo.setCrewNo(Integer.parseInt(crewNo));
			vo.setMemberNo(memberNo);
			vo.setMeetingName(meetingName);
			vo.setMeetingDate(Timestamp.valueOf(meetingDay + " " + meetingTime1 + ":" + meetingTime2 + ":00"));
			vo.setMeetingLoc(meetingLoc);
			vo.setMeetingPrice(Integer.parseInt(meetingPrice));
			vo.setMeetingMax(Integer.parseInt(meetingMax));
			vo.setMeetingOriginalImg(meetingOriginalImg);
			vo.setMeetingSaveImg(meetingSaveImg);
			
			dao.addMeeting(vo);
			resp.sendRedirect("crew?cmd=detail&crewNo=" + crewNo);
		} else {
			System.err.println("로그인 후 진행해주세요!!!!");
			req.setAttribute("errormsg", "로그인 후 진행해주세요!!!!");
		}
	}
}
